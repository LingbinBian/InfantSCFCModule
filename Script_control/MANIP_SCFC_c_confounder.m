clear
clc
close all
rng(123);  % 固定随机种子，确保可重复

%% 1. 模拟参数
nGroups = 8;               % group 数量
nSubPerGroup = 20;         % 每组被试数
groupAges = linspace(2, 30, nGroups)';  % group 月龄

% 模拟真实的回归系数
true_beta_age    = 0.5;
true_beta_dvars  = -0.3;
true_beta_gender = -0.2;
true_beta_site   = 0.1;  % 新增：站点效应

%% 2. 生成个体水平数据
indivData = table();
for g = 1:nGroups
    nSub = nSubPerGroup;
    group_id = repmat(g, nSub, 1);
    age_group = repmat(groupAges(g), nSub, 1);
    
    % 随机分配站点（1或2）
    site = randi([1, 2], nSub, 1);  % 随机选择站点
    
    % DVARS: 随机但随年龄下降
    dvars = 0.5 + 0.02*(max(groupAges)-age_group) + 0.2*randn(nSub,1);
    dvars = max(dvars,0);
    
    % Gender: 随机分布
    genders = repmat("M", nSub, 1);
    genders(rand(nSub,1) < 0.5) = "F";

    tmp = table(group_id, age_group, dvars, genders, site);
    indivData = [indivData; tmp];
end

% gender: F=1, M=0
indivData.gender_num = double(indivData.genders == "F");

%% 3. 计算 group-level 指标
groupDVARS = groupsummary(indivData, "group_id", "mean", "dvars");
groupDVARS.Properties.VariableNames{'mean_dvars'} = 'mean_DVARS';

groupGender = groupsummary(indivData, "group_id", "mean", "gender_num");
groupGender.Properties.VariableNames{'mean_gender_num'} = 'prop_female';

groupAge = groupsummary(indivData, "group_id", "mean", "age_group");
groupAge.Properties.VariableNames{'mean_age_group'} = 'mean_age';

% 计算每个组的站点比例
groupSite = groupsummary(indivData, "group_id", "mean", "site");
groupSite.Properties.VariableNames{'mean_site'} = 'prop_site_2'; % 站点2的比例

%% 4. 模拟 group-level SFC
SFC_true = true_beta_age   * groupAge.mean_age + ...
           true_beta_dvars * groupDVARS.mean_DVARS + ...
           true_beta_gender * groupGender.prop_female + ...
           true_beta_site   * groupSite.prop_site_2 + ...
           0.2 * randn(nGroups, 1);   % noise

groupTable = table(groupAge.group_id, ...
                   groupAge.mean_age, ...
                   groupDVARS.mean_DVARS, ...
                   groupGender.prop_female, ...
                   groupSite.prop_site_2, ...
                   SFC_true, ...
                   'VariableNames', {'group_id','mean_age','mean_DVARS','prop_female','prop_site_2','SFC'});

%% 5. 标准化变量
groupTable.mean_age_z    = zscore(groupTable.mean_age);
groupTable.mean_DVARS_z  = zscore(groupTable.mean_DVARS);
groupTable.prop_female_z = zscore(groupTable.prop_female);
groupTable.prop_site_2_z  = zscore(groupTable.prop_site_2);
groupTable.SFC_z         = zscore(groupTable.SFC);

%% 6. Residual 方法：先控制 confounder，再对 age 做一元回归
mdl_conf = fitlm(groupTable, 'SFC_z ~ mean_DVARS_z + prop_female_z + prop_site_2_z');
SFC_resid = mdl_conf.Residuals.Raw;

mdl_final = fitlm(groupTable.mean_age_z, SFC_resid);
disp('=== Residual method: Age predicting residual SFC ===')
disp(mdl_final)

% 绘制 residual vs age 散点
figure('Color', 'w');
scatter(groupTable.mean_age, SFC_resid, 60, 'b', 'filled'); hold on;
lsline;
xlabel('Group mean age (months)', 'FontSize', 12);
ylabel('SFC residual (controlling DVARS, gender & site)', 'FontSize', 12);
title('Residual method: Age effect after confound control', 'FontSize', 14);
grid on;

%% 7. 多元回归
mdl_multi = fitlm(groupTable, 'SFC_z ~ mean_age_z + mean_DVARS_z + prop_female_z + prop_site_2_z');
disp('=== Multivariate regression ===')
disp(mdl_multi)

%% 8. 可视化：预测 vs 真实
y_true = groupTable.SFC_z;
y_pred = mdl_multi.Fitted;

figure('Color', 'w');
scatter(y_true, y_pred, 70, 'filled'); hold on;
plot([-3 3], [-3 3], 'k--', 'LineWidth', 1.5);
xlabel('Observed SFC_z', 'FontSize', 12);
ylabel('Predicted SFC_z', 'FontSize', 12);
title('Multivariate regression: Observed vs Predicted', 'FontSize', 14);
grid on; axis equal;

%% 9. Partial regression plots
figure('Color', 'w');
subplot(1,4,1)
plotAdded(mdl_multi, 'mean_age_z');
title('Partial effect: Age', 'FontSize', 12);
grid on;

subplot(1,4,2)
plotAdded(mdl_multi, 'mean_DVARS_z');
title('Partial effect: DVARS', 'FontSize', 12);
grid on;

subplot(1,4,3)
plotAdded(mdl_multi, 'prop_female_z');
title('Partial effect: Gender', 'FontSize', 12);
grid on;

subplot(1,4,4)
plotAdded(mdl_multi, 'prop_site_2_z');
title('Partial effect: Site', 'FontSize', 12);
grid on;

%% 10. 回归系数条形图
coefNames = mdl_multi.CoefficientNames(2:end); % exclude intercept
coefValues = mdl_multi.Coefficients.Estimate(2:end);
coefSE     = mdl_multi.Coefficients.SE(2:end);

figure('Color', 'w');
bar(coefValues);
hold on;
errorbar(1:length(coefValues), coefValues, coefSE, 'k.', 'LineWidth', 1.5);
set(gca, 'XTickLabel', coefNames, 'XTick', 1:numel(coefNames));
ylabel('Standardized Beta', 'FontSize', 12);
title('Multivariate regression coefficients', 'FontSize', 14);
grid on;