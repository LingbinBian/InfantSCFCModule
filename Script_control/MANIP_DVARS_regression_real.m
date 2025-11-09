% DEMO Individual-level DVARS regression with age ranges

% Version 1.0
% 21-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc
close all

% load DVARS

N_roi=400;
scan=2;

if scan==1
    scan_dir='AP';
    load(['../results_fMRI/roi_',num2str(N_roi),'_1_AP/DVARS_AP.mat']);
else
    scan_dir='PA';
    load(['../results_fMRI/roi_',num2str(N_roi),'_1_PA/DVARS_PA.mat']);
end



% ensure DVARS_Global_mean loading correctly
if ~exist('DVARS_Global_mean', 'var')
    error('DVARS_Global_mean variable not found in the loaded MAT file.');
end

% ensure AGE, GENDER, SITE loading correctly
if ~exist('AGE', 'var') || ~exist('GENDER', 'var') || ~exist('SITE', 'var')
    error('AGE, GENDER, or SITE variable not found in the loaded MAT file.');
end

% initialize DVARS_all
nGroups = size(DVARS_Global_mean, 2); % number of age ranges
DVARS_all = cell(nGroups, 1);

% DVARS data
for i = 1:nGroups
    DVARS_all{i} = DVARS_Global_mean(~cellfun('isempty', DVARS_Global_mean(:, i)), i);
end

% define age range
ageGroups_str = { ...
    '0-5month', '3-8month', '6-11month', '9-14month', ...
    '12-17month', '15-23month', '18-29month', ...
    '24-36month', '>36month'};

% central age within the age range
groupAges = nan(nGroups, 1);
for i = 1:nGroups
    str = ageGroups_str{i};
    if contains(str, '-')
        nums = regexp(str, '\d+', 'match');
        groupAges(i) = mean(str2double(nums)); % 取中点
    elseif contains(str, '>')
        num = regexp(str, '\d+', 'match');
        groupAges(i) = str2double(num) + 4; % 例如 ">36month" → 40
    else
        groupAges(i) = NaN;
    end
end

disp(table(ageGroups_str', groupAges, 'VariableNames', {'AgeRange', 'Age_Center'}));

% individual-level data
DVARS_vec = [];
Age_vec   = [];
Gender_vec = [];   
Site_vec   = [];     

for g = 1:nGroups
    thisDVARS = cell2mat(DVARS_all{g}); % 确保将 cell 转换为数值数组
    nSub = length(thisDVARS);
    DVARS_vec = [DVARS_vec; thisDVARS];
    Age_vec   = [Age_vec; repmat(groupAges(g), nSub, 1)];
    
    % gender
    genderData = GENDER(~cellfun('isempty', DVARS_Global_mean(:, g)), g);
    Gender_vec = [Gender_vec; cellfun(@(x) double(strcmp(x, 'M')), genderData)]; % M=1, F=0

    siteData = SITE(~cellfun('isempty', DVARS_Global_mean(:, g)), g);
    Site_vec = [Site_vec; cellfun(@(x) double(strcmp(x, 'MN')), siteData) + 1]; % NC=1, MN=2
end

% create table
T = table(Age_vec, DVARS_vec, Gender_vec, Site_vec, ...
    'VariableNames', {'Age', 'DVARS', 'Gender', 'Site'});

% simple regression DVARS ~ Age
mdl_simple = fitlm(T, 'DVARS ~ Age');
disp('=== Simple regression: DVARS ~ Age ===')
disp(mdl_simple)

% multivariate regression DVARS ~ Age + Gender + Site
mdl_multi = fitlm(T, 'DVARS ~ Age + Gender + Site');
disp('=== Multiple regression: DVARS ~ Age + Gender + Site ===')
disp(mdl_multi)

% residualized DVARS（control for Gender and Site）
mdl_resid = fitlm(T, 'DVARS ~ Gender + Site');
T.DVARS_resid = mdl_resid.Residuals.Raw;

% regress DVARS on age
mdl_age = fitlm(T, 'DVARS_resid ~ Age');
disp('=== Age effect after removing Gender & Site ===')
disp(mdl_age)

% visualization
figure('Color', 'w', 'Position', [100, 100, 600, 400]); % figure size

hold on;

% plot
scatter(T.Age, T.DVARS_resid, 50, 'filled', 'MarkerFaceAlpha', 0.7, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [0.5, 0.7, 1]); % light blue

% fitting
xFit = linspace(min(T.Age), max(T.Age), 100)';
yFit = predict(mdl_age, table(xFit, 'VariableNames', {'Age'}));
plot(xFit, yFit, 'Color', [1, 0.5, 0.5], 'LineWidth', 2, 'DisplayName', 'Fitted Line'); % light red

% axis
xlabel('Age (months)', 'FontSize', 16, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
ylabel('DVARS', 'FontSize', 16, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
if scan==1
    title(['DVARS vs Age', ' ROI ',num2str(N_roi),' AP'], 'FontSize', 18, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
else
    title(['DVARS vs Age', ' ROI ',num2str(N_roi),' PA'], 'FontSize', 18, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
end
grid on;
box on;

% x-axis
xticks(groupAges); 
simplifiedAgeGroups = {'0-5', '3-8', '6-11', '9-14', ...
                       '12-17', '15-23', '18-29', ...
                       '24-36', '>36'};
xticklabels(simplifiedAgeGroups);  

xlim([min(groupAges)-1, max(groupAges)+1]);

legend('Residualized DVARS', 'Fitted Line', 'Location', 'best', 'FontSize', 14, 'FontName', 'Times New Roman');

% font size of axis
set(gca, 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman'); 

pic_path='/Users/lingbinbian/Documents/BCP_fMRI_sMRI/figure';

if scan==1
    saveas(gcf,[pic_path,'/DVARS_',num2str(N_roi),'_regression_ap.svg'])
else
    saveas(gcf,[pic_path,'/DVARS_',num2str(N_roi),'_regression_pa.svg'])
end
