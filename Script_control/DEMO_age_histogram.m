% DEMO the histogram of scans against age
% Version 1.0
% 11-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc
close all

scan=1;

if scan==1
    T_fMRI=loadSubjectData('subj_info_ap.mat');
else
    T_fMRI=loadSubjectData('subj_info_pa.mat');
end

T_DTI=loadDTIData('subj_info_dti_long.tsv');

% age range
age_bins = [0.5, 1:36]; % 0.5, 1, 2, ..., 36
n_bins = numel(age_bins) + 1; % add another bin (>36)

% initialization
fMRI_counts = zeros(1, n_bins);
DTI_counts = zeros(1, n_bins);

% number of scans
% fMRI
for i = 1:length(age_bins)
    in_bin_fMRI = T_fMRI.AgeMonth == age_bins(i);
    fMRI_counts(i) = sum(in_bin_fMRI);
end
fMRI_counts(end) = sum(T_fMRI.AgeMonth > 36); % for >36

% DTI counts
for i = 1:length(age_bins)
    in_bin_DTI = T_DTI.AgeMonth == age_bins(i);
    DTI_counts(i) = sum(in_bin_DTI);
end
DTI_counts(end) = sum(T_DTI.AgeMonth > 36); % for >36

% plot histogram
figure('Position', [100, 100, 1200, 250]); 
bar(1:n_bins, [fMRI_counts; DTI_counts]', 'grouped', 'BarWidth', 0.7); 
set(gca, 'XTick', 1:n_bins, 'XTickLabel', [arrayfun(@num2str, age_bins, 'UniformOutput', false), {'>36'}]);
xlabel('Months', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('Number of Scans', 'FontSize', 12, 'FontName', 'Times New Roman');
title('Number of fMRI and DTI Scans', 'FontSize', 12, 'FontName', 'Times New Roman');
if scan==1
   legend({'fMRI (AP)', 'DTI'}, 'Location', 'northeast', 'FontSize', 10, 'FontName', 'Times New Roman');
else
   legend({'fMRI (PA)', 'DTI'}, 'Location', 'northeast', 'FontSize', 10, 'FontName', 'Times New Roman');
end
grid on;

ylim([0 40]); 

% number of scans
for i = 1:n_bins
    text(i - 0.15, fMRI_counts(i)+2 , num2str(fMRI_counts(i)), 'FontSize', 9, 'FontName', 'Times New Roman', 'Color', 'k', 'HorizontalAlignment', 'center'); 
    text(i + 0.15, DTI_counts(i)+2, num2str(DTI_counts(i)), 'FontSize', 9, 'FontName', 'Times New Roman', 'Color', 'k', 'HorizontalAlignment', 'center'); 
end

% destination file
pic_path='/Users/lingbinbian/Documents/BCP_fMRI_sMRI/figure';

if scan==1
    saveas(gcf,[pic_path,'/fmri_ap_dti.svg'])
else
    saveas(gcf,[pic_path,'/fmri_pa_dti.svg'])
end


% nested function
% ------------------------------------------------------------------------
function T = loadSubjectData(filename)
    S = load(filename);
    if ~isfield(S,'subj_info')
        error('In %s, no subj_info variable', filename);
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
