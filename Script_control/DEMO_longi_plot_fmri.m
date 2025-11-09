% DEMO longitudinal scans of fMRI (AP and PA)

% Version 1.0
% 11-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc


colorAP  = [0 0.4470 0.7410];      % AP 
colorPA  = [0.8500 0.3250 0.0980];  % PA 
offset   = 0.15;                   % offset of the dot
markerSize = 20;                   % dot size
maxYTicks = 20;                    % 

% load fMRI data
load('subj_info_ap.mat');
T_AP = cell2table(subj_info, 'VariableNames', {'Subject','AgeMonth','gender','site'});
load('subj_info_pa.mat');
T_PA = cell2table(subj_info, 'VariableNames', {'Subject','AgeMonth','gender','site'});

% age
if iscell(T_AP.AgeMonth)
    T_AP.AgeMonth = cellfun(@(x) str2double(regexprep(x, 'mo', '')), T_AP.AgeMonth);
end
if iscell(T_PA.AgeMonth)
    T_PA.AgeMonth = cellfun(@(x) str2double(regexprep(x, 'mo', '')), T_PA.AgeMonth);
end

% load DTI data

T_DTI=loadDTIData('subj_info_dti_long.tsv');

% all subjects including fMRI (AP & PA) and DTI
subjects = unique([T_AP.Subject; T_PA.Subject; T_DTI.Subject]);
nSubj = numel(subjects);

% plot AP vs PA 
figure('Position',[100 100 1000 500]); hold on;

for i = 1:nSubj
    subj = subjects{i};

    % AP
    idx_ap = strcmp(T_AP.Subject, subj);
    tp_ap = sort(T_AP.AgeMonth(idx_ap));
    y_ap = i * ones(size(tp_ap));
    scatter(tp_ap - offset, y_ap, markerSize, colorAP, 'filled', 'MarkerFaceAlpha', 0.7);
    if numel(tp_ap) > 1
        plot(tp_ap - offset, y_ap, '-', 'Color', colorAP, 'LineWidth', 1.2);
    end

    % PA
    idx_pa = strcmp(T_PA.Subject, subj);
    tp_pa = sort(T_PA.AgeMonth(idx_pa));
    y_pa = i * ones(size(tp_pa));
    scatter(tp_pa + offset, y_pa, markerSize, colorPA, 's', 'filled', 'MarkerFaceAlpha', 0.7);
    if numel(tp_pa) > 1
        plot(tp_pa + offset, y_pa, '-', 'Color', colorPA, 'LineWidth', 1.2);
    end
end

xlabel('Month', 'FontSize', 18, 'FontName', 'Times New Roman');
ylabel('Subject Index', 'FontSize', 18, 'FontName', 'Times New Roman');
title('fMRI AP and PA samples','FontSize', 18, 'FontName', 'Times New Roman');

% Y axis
step = max(floor(nSubj / maxYTicks), 1);  %
yticks(1:step:nSubj);
yticklabels(1:step:nSubj);

% X axis

xticks(0:5:80);
% yticklabels(1:step:nSubj);

set(gca, 'YDir', 'reverse'); % first subject at the top
ylim([0 nSubj + 1]);           
grid on; box on;

% legend
h1 = scatter(nan, nan, markerSize, colorAP, 'filled');
h2 = scatter(nan, nan, markerSize, colorPA, 's', 'filled');
legend([h1 h2], {'AP', 'PA'}, 'Location', 'best','FontSize', 12, 'FontName', 'Times New Roman');

%
ax = gca;
ax.FontSize = 16;
ax.FontName = 'Times New Roman'; 
ax.LineWidth = 1;

function T = loadDTIData(filename)
    T = readtable(filename, 'FileType', 'text', 'Delimiter', '\t', 'ReadVariableNames', false);
    T.Properties.VariableNames = {'Subject', 'AgeMonth', 'site'};
    if isnumeric(T.Subject)
        T.Subject = cellstr(num2str(T.Subject));
    end
end

% destination file
pic_path='/Users/lingbinbian/Documents/BCP_fMRI_sMRI/figure';

saveas(gcf,[pic_path,'/','fMRI_AP_PA_samples.svg'])