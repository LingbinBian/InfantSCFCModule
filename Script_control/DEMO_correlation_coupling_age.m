% MANIP correlation between structural-functional scoupling (Pearsons's and spearman) and age

%
% Version 1.0
% 30-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc
close all

N_roi=400;
N_window=9;
scan_dir='AP';
gender=0;
coupling_type=2;

switch gender
    case 0
        load(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/results_fMRI/roi_',num2str(N_roi),'_1_',scan_dir,'/FC_ave_results_',scan_dir,'.mat'])
        FC=ave_adj;
        
        load(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/results_DTI_strength/roi_',num2str(N_roi),'_1_',scan_dir,'/SC_ave_results_',scan_dir,'.mat'])
        SC=ave_adj;
    case 1
        load(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/results_fMRI_F/roi_',num2str(N_roi),'_1_',scan_dir,'/FC_ave_results_',scan_dir,'.mat'])
        FC=ave_adj;
        
        load(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/results_DTI_strength_F/roi_',num2str(N_roi),'_1_',scan_dir,'/SC_ave_results_',scan_dir,'.mat'])
        SC=ave_adj;
    otherwise
        load(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/results_fMRI_M/roi_',num2str(N_roi),'_1_',scan_dir,'/FC_ave_results_',scan_dir,'.mat'])
        FC=ave_adj;
        
        load(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/results_DTI_strength_M/roi_',num2str(N_roi),'_1_',scan_dir,'/SC_ave_results_',scan_dir,'.mat'])
        SC=ave_adj;
end

sc_fc_c=zeros(N_roi,N_window);

for j=1:N_window
    for i=1:N_roi
        if coupling_type==1
            sc_fc_c(i,j)=corr(SC{1,j}(i,:)',FC{1,j}(i,:)', 'Type', 'Spearman');  % Spearman correlation
        else
            sc_fc_c(i,j)=corr(SC{1,j}(i,:)',FC{1,j}(i,:)');   % Pearson's correlation
        end
    end
end

% LH
switch N_roi
    case 100
        c_LH_Vis         =mean(sc_fc_c(1:9,:));
        c_LH_SomMot      =mean(sc_fc_c(10:15,:));
        c_LH_DorsAttn    =mean(sc_fc_c(16:23,:));
        c_LH_SalVentAttn =mean(sc_fc_c(24:30,:));
        c_LH_Limbic      =mean(sc_fc_c(31:33,:));
        c_LH_Cont        =mean(sc_fc_c(34:37,:));
        c_LH_Default     =mean(sc_fc_c(38:50,:));
    case 200
        c_LH_Vis         =mean(sc_fc_c(1:14,:));
        c_LH_SomMot      =mean(sc_fc_c(15:30,:));
        c_LH_DorsAttn    =mean(sc_fc_c(31:43,:));
        c_LH_SalVentAttn =mean(sc_fc_c(44:54,:));
        c_LH_Limbic      =mean(sc_fc_c(55:60,:));
        c_LH_Cont        =mean(sc_fc_c(61:73,:));
        c_LH_Default     =mean(sc_fc_c(74:100,:));
    case 300
        c_LH_Vis         =mean(sc_fc_c(1:24,:));
        c_LH_SomMot      =mean(sc_fc_c(25:53,:));
        c_LH_DorsAttn    =mean(sc_fc_c(54:69,:));
        c_LH_SalVentAttn =mean(sc_fc_c(70:85,:));
        c_LH_Limbic      =mean(sc_fc_c(86:95,:));
        c_LH_Cont        =mean(sc_fc_c(96:112,:));
        c_LH_Default     =mean(sc_fc_c(113:150,:));
    otherwise
        c_LH_Vis         =mean(sc_fc_c(1:31,:));
        c_LH_SomMot      =mean(sc_fc_c(32:68,:));
        c_LH_DorsAttn    =mean(sc_fc_c(69:91,:));
        c_LH_SalVentAttn =mean(sc_fc_c(92:113,:));
        c_LH_Limbic      =mean(sc_fc_c(114:126,:));
        c_LH_Cont        =mean(sc_fc_c(127:148,:));
        c_LH_Default     =mean(sc_fc_c(149:200,:));
        
end

% age
ageGroups = [2.5, 5.5, 8.5, 11.5, 14.5, 19, 23.5, 30, 40]';
ageLabels = {'0–5','3–8','6–11','9–14','12–17','15–23','18–29','24–36','>36'};

networkNames = {'LH Vis','LH SomMot','LH DorsAttn','LH SalVentAttn','LH Limbic','LH Cont','LH Default'};
metrics_all = [
    c_LH_Vis;
    c_LH_SomMot;
    c_LH_DorsAttn;
    c_LH_SalVentAttn;
    c_LH_Limbic;
    c_LH_Cont;
    c_LH_Default
];

% color
colors = [ ...
    0.0000 0.4470 0.7410;   % blue Vis
    0.8500 0.3250 0.0980;   % orange SomMot
    0.9290 0.6940 0.1250;   % yellow DorsAttn
    0.4940 0.1840 0.5560;   % purple SalVentAttn
    0.4660 0.6740 0.1880;   % green Limbic
    0.3010 0.7450 0.9330;   % cyan Cont
    0.6350 0.0780 0.1840];  % red Default

% plot
% figure('Units','centimeters','Position',[5 5 14 10]); 
figure
hold on;
hLines = gobjects(7,1);

for i = 1:7
    y = metrics_all(i,:)';
    x = ageGroups;
    rValue = corr(x, y); 
    % linear regression fit
    mdl = fitlm(x, y);
    ageRange = linspace(min(x), max(x), 100)';
    [predVals, ciMat] = predict(mdl, ageRange, 'Alpha', 0.05);

    pValue = mdl.Coefficients.pValue(2); % p-value
    
    %rSquared = mdl.Rsquared.Ordinary; % R-squared value
    
    
      % print CI and p-value
    fprintf('%s: r = %.4f, 95%% CI = [%.4f, %.4f], p-value = %.4f\n', ...
        networkNames{i}, rValue, ciMat(1,1), ciMat(1,2), pValue);
    % confidence interval
    fill([ageRange; flipud(ageRange)], [ciMat(:,1); flipud(ciMat(:,2))], ...
        colors(i,:), 'FaceAlpha', 0.1, 'EdgeColor', 'none');

    % scatter and fitting
    scatter(x, y, 40, 'filled', 'MarkerFaceColor', colors(i,:), 'MarkerFaceAlpha', 0.8);
    hLines(i) = plot(ageRange, predVals, 'Color', colors(i,:), 'LineWidth', 2);
end

%
set(gca, 'XTick', ageGroups, 'XTickLabel', ageLabels);
xlabel('Month','fontname','times');
if coupling_type==1
    ylabel('Spearman','fontname','times');
else
    ylabel('Pearson','fontname','times');
end
switch gender
    case 0
        title(['ROI=',num2str(N_roi),', LH'],'fontname','times');
    case 1
        title(['Female',', ROI=',num2str(N_roi),', LH'],'fontname','times');
    otherwise
        title(['Male',', ROI=',num2str(N_roi),', LH'],'fontname','times');
end
        
legend(hLines, networkNames, 'Location', 'best', 'Box', 'off');
grid on;
set(gca, 'FontSize', 11,'fontname','times');

% y-axis
y_min = min(metrics_all(:)); %
y_max = max(metrics_all(:)); % 
ylim([y_min - 0.05, y_max + 0.05]); 


ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset;
ax.Position = [outerpos(1)+ti(1)*0.8, outerpos(2)+ti(2)*0.8, ...
               outerpos(3)-ti(1)-ti(3)-0.02, outerpos(4)-ti(2)-ti(4)-0.02];

%set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 14 10]);
set(gca, 'LooseInset', max(get(gca,'TightInset'), 0.02));

print(gcf, 'SC_FC_Trajectories_Compact', '-dpng', '-r300');
set(gcf,'unit','centimeters','position',[6 10 16 11])
set(gca,'Position',[.15 .15 .75 .7]);
switch gender
    case 0
        if coupling_type==1
            saveas(gcf,['../results_SC_strength_FC/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.fig'])
            saveas(gcf,['../results_SC_strength_FC/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.svg'])
        else
            saveas(gcf,['../results_SC_strength_FC/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.fig'])
            saveas(gcf,['../results_SC_strength_FC/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.svg'])
        end
    case 1
        if coupling_type==1
            saveas(gcf,['../results_SC_strength_FC_F/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.fig'])
            saveas(gcf,['../results_SC_strength_FC_F/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.svg'])
        else
            saveas(gcf,['../results_SC_strength_FC_F/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.fig'])
            saveas(gcf,['../results_SC_strength_FC_F/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.svg'])
        end
    otherwise
        if coupling_type==1
            saveas(gcf,['../results_SC_strength_FC_M/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.fig'])
            saveas(gcf,['../results_SC_strength_FC_M/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.svg'])
        else
            saveas(gcf,['../results_SC_strength_FC_M/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.fig'])
            saveas(gcf,['../results_SC_strength_FC_M/roi_',num2str(N_roi),'_1_',scan_dir,'/LH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.svg'])
        end
end

% -------------------------------------------------------------------------
% LH
switch N_roi
    case 100
            c_RH_Vis=mean(sc_fc_c(51:58,:));
            c_RH_SomMot=mean(sc_fc_c(59:66,:));
            c_RH_DorsAttn=mean(sc_fc_c(67:73,:));
            c_RH_SalVentAttn=mean(sc_fc_c(74:78,:));
            c_RH_Limbic=mean(sc_fc_c(79:80,:));
            c_RH_Cont=mean(sc_fc_c(81:89,:));
            c_RH_Default=mean(sc_fc_c(90:100,:));
    case 200
            c_RH_Vis=mean(sc_fc_c(101:115,:));
            c_RH_SomMot=mean(sc_fc_c(116:134,:));
            c_RH_DorsAttn=mean(sc_fc_c(135:147,:));
            c_RH_SalVentAttn=mean(sc_fc_c(148:158,:));
            c_RH_Limbic=mean(sc_fc_c(159:164,:));
            c_RH_Cont=mean(sc_fc_c(165:181,:));
            c_RH_Default=mean(sc_fc_c(182:200,:));
    case 300
            c_RH_Vis=mean(sc_fc_c(151:173,:));
            c_RH_SomMot=mean(sc_fc_c(174:201,:));
            c_RH_DorsAttn=mean(sc_fc_c(202:219,:));
            c_RH_SalVentAttn=mean(sc_fc_c(220:237,:));
            c_RH_Limbic=mean(sc_fc_c(238:247,:));
            c_RH_Cont=mean(sc_fc_c(248:270,:));
            c_RH_Default=mean(sc_fc_c(271:300,:));
    otherwise
            c_RH_Vis=mean(sc_fc_c(201:230,:));
            c_RH_SomMot=mean(sc_fc_c(231:270,:));
            c_RH_DorsAttn=mean(sc_fc_c(271:293,:));
            c_RH_SalVentAttn=mean(sc_fc_c(294:318,:));
            c_RH_Limbic=mean(sc_fc_c(319:331,:));
            c_RH_Cont=mean(sc_fc_c(332:361,:));
            c_RH_Default=mean(sc_fc_c(362:400,:));
        
end

% age
ageGroups = [2.5, 5.5, 8.5, 11.5, 14.5, 19, 23.5, 30, 40]';
ageLabels = {'0–5','3–8','6–11','9–14','12–17','15–23','18–29','24–36','>36'};

networkNames = {'RH Vis','RH SomMot','RH DorsAttn','RH SalVentAttn','RH Limbic','RH Cont','RH Default'};
metrics_all = [
    c_RH_Vis;
    c_RH_SomMot;
    c_RH_DorsAttn;
    c_RH_SalVentAttn;
    c_RH_Limbic;
    c_RH_Cont;
    c_RH_Default
];

% color
colors = [ ...
    0.0000 0.4470 0.7410;   % blue Vis
    0.8500 0.3250 0.0980;   % orange SomMot
    0.9290 0.6940 0.1250;   % yellow DorsAttn
    0.4940 0.1840 0.5560;   % purple SalVentAttn
    0.4660 0.6740 0.1880;   % green Limbic
    0.3010 0.7450 0.9330;   % cyan Cont
    0.6350 0.0780 0.1840];  % red Default

% plot
% figure('Units','centimeters','Position',[5 5 14 10]); 
figure
hold on;
hLines = gobjects(7,1);

for i = 1:7
    y = metrics_all(i,:)';
    x = ageGroups;
    rValue = corr(x, y); 
    % linear regression fit
    mdl = fitlm(x, y);
    ageRange = linspace(min(x), max(x), 100)';
    [predVals, ciMat] = predict(mdl, ageRange, 'Alpha', 0.05);

    pValue = mdl.Coefficients.pValue(2); % p-value
    
    %rSquared = mdl.Rsquared.Ordinary; % R-squared value
    
    
      % print CI and p-value
    fprintf('%s: r = %.4f, 95%% CI = [%.4f, %.4f], p-value = %.4f\n', ...
        networkNames{i}, rValue, ciMat(1,1), ciMat(1,2), pValue);
    % confidence interval
    fill([ageRange; flipud(ageRange)], [ciMat(:,1); flipud(ciMat(:,2))], ...
        colors(i,:), 'FaceAlpha', 0.1, 'EdgeColor', 'none');

    % scatter and fitting
    scatter(x, y, 40, 'filled', 'MarkerFaceColor', colors(i,:), 'MarkerFaceAlpha', 0.8);
    hLines(i) = plot(ageRange, predVals, 'Color', colors(i,:), 'LineWidth', 2);
end

%
set(gca, 'XTick', ageGroups, 'XTickLabel', ageLabels);
xlabel('Month','fontname','times');
if coupling_type==1
    ylabel('Spearman','fontname','times');
else
    ylabel('Pearson','fontname','times');
end
switch gender
    case 0
        title(['ROI=',num2str(N_roi),', RH'],'fontname','times');
    case 1
        title(['Female',', ROI=',num2str(N_roi),', RH',scan_dir],'fontname','times');
    otherwise
        title(['Male',', ROI=',num2str(N_roi),', RH',scan_dir],'fontname','times');
end
        
legend(hLines, networkNames, 'Location', 'best', 'Box', 'off');
grid on;
set(gca, 'FontSize', 11,'fontname','times');

% y-axis
y_min = min(metrics_all(:)); %
y_max = max(metrics_all(:)); % 
ylim([y_min - 0.05, y_max + 0.05]); 


ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset;
ax.Position = [outerpos(1)+ti(1)*0.8, outerpos(2)+ti(2)*0.8, ...
               outerpos(3)-ti(1)-ti(3)-0.02, outerpos(4)-ti(2)-ti(4)-0.02];

%set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 14 10]);
set(gca, 'LooseInset', max(get(gca,'TightInset'), 0.02));

print(gcf, 'SC_FC_Trajectories_Compact', '-dpng', '-r300');
set(gcf,'unit','centimeters','position',[6 10 16 11])
set(gca,'Position',[.15 .15 .75 .7]);
switch gender
    case 0
        if coupling_type==1
            saveas(gcf,['../results_SC_strength_FC/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.fig'])
            saveas(gcf,['../results_SC_strength_FC/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.svg'])
        else
            saveas(gcf,['../results_SC_strength_FC/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.fig'])
            saveas(gcf,['../results_SC_strength_FC/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.svg'])
        end
    case 1
        if coupling_type==1
            saveas(gcf,['../results_SC_strength_FC_F/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.fig'])
            saveas(gcf,['../results_SC_strength_FC_F/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.svg'])
        else
            saveas(gcf,['../results_SC_strength_FC_F/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.fig'])
            saveas(gcf,['../results_SC_strength_FC_F/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.svg'])
        end
    otherwise
        if coupling_type==1
            saveas(gcf,['../results_SC_strength_FC_M/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.fig'])
            saveas(gcf,['../results_SC_strength_FC_M/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_spearman.svg'])
        else
            saveas(gcf,['../results_SC_strength_FC_M/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.fig'])
            saveas(gcf,['../results_SC_strength_FC_M/roi_',num2str(N_roi),'_1_',scan_dir,'/RH/SC_FC_coupling_7_network_',scan_dir,'_age_pearson.svg'])
        end
end

% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
