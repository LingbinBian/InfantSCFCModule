% DEMO longitudinal scans of fMRI and DTI

% Version 1.0
% 12-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc
close all

%
colorFMRI = [0.8500 0.3250 0.0980]; % the color of fMRI
colorDTI  = [0.4660 0.6740 0.1880]; % the color of DTI 
offset    = 0.15;                   % offset of dots
markerSize = 20;                    % dot size
maxYTicks = 20;                     % resolution of Y axie

% load the data
T_AP  = loadSubjectData('subj_info_ap.mat');
T_PA  = loadSubjectData('subj_info_pa.mat');
T_DTI = loadDTIData('subj_info_dti_long.tsv');

% subjects
subjects = unique([T_AP.Subject; T_PA.Subject; T_DTI.Subject]);
nSubj = numel(subjects);

% plot
figure('Position',[100 100 1000 500]); hold on;
title('fMRI (AP+PA) and DTI Samples','FontSize', 18, 'FontName', 'Times New Roman');

for i = 1:nSubj
    subj = subjects{i};

    % ---- fMRI (AP+PA) ----
    tp_fmri = [T_AP.AgeMonth(strcmp(T_AP.Subject, subj));
               T_PA.AgeMonth(strcmp(T_PA.Subject, subj))];
    tp_fmri = sort(tp_fmri);
    drawTimepoints(tp_fmri - offset, i, colorFMRI, 'o', markerSize);

    % ---- DTI ----
    tp_dti = sort(T_DTI.AgeMonth(strcmp(T_DTI.Subject, subj)));
    drawTimepoints(tp_dti, i, colorDTI, '^', markerSize);
end

%
xlabel('Month', 'FontSize', 18, 'FontName', 'Times New Roman');
ylabel('Subject Index', 'FontSize', 18, 'FontName', 'Times New Roman');

% X axis

xticks(0:5:80);

step = max(floor(nSubj / maxYTicks),1);
yticks(1:step:nSubj);
yticklabels(1:step:nSubj);
set(gca, 'YDir', 'reverse', 'YLim', [0 nSubj + 1]);
grid on; box on;

ax = gca;
ax.FontSize = 16;
ax.FontName = 'Times New Roman'; 
ax.LineWidth = 1;

% 
h1 = scatter(nan, nan, markerSize, colorFMRI, 'filled');
h2 = scatter(nan, nan, markerSize, colorDTI, '^', 'filled');
legend([h1 h2], {'fMRI (AP+PA)', 'DTI'}, 'Location', 'best', 'FontSize', 12, 'FontName', 'Times New Roman');

% destination file
pic_path='/Users/lingbinbian/Documents/BCP_fMRI_sMRI/figure';

saveas(gcf,[pic_path,'/','fMRI_DTI_samples.svg'])

% nested function ---------------------------------------------------------
function T = loadSubjectData(filename)
    S = load(filename);
    if ~isfield(S,'subj_info')
        error('文件 %s 中未找到 subj_info 变量', filename);
    end
    subj_info = S.subj_info;
    T = cell2table(subj_info, 'VariableNames', {'Subject','AgeMonth','gender','site'});
    if iscell(T.AgeMonth)
        T.AgeMonth = cellfun(@(x) str2double(regexprep(x,'mo','')), T.AgeMonth);
    end
end

function T = loadDTIData(filename)
    T = readtable(filename, 'FileType', 'text', 'Delimiter', '\t', 'ReadVariableNames', false);
    T.Properties.VariableNames = {'Subject', 'AgeMonth', 'site'};
    if isnumeric(T.Subject)
        T.Subject = cellstr(num2str(T.Subject));
    end
end

function drawTimepoints(tp, y, color, marker, msize)
    if isempty(tp), return; end
    yVals = y * ones(size(tp));
    scatter(tp, yVals, msize, color, marker, 'filled', 'MarkerFaceAlpha', 0.5);
    if numel(tp) > 1
        plot(tp, yVals, '-', 'Color', color, 'LineWidth', 0.8);
    end
end


