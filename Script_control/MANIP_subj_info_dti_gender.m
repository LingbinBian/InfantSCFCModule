% MANIP Read MRI .csv file of DTI for gender 

% Version 1.0
% 24-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc
close all

filename_MRI='/Users/lingbinbian/Documents/BCP_fMRI_sMRI/psychometrics/table/image03.csv';  % read MRI imaging table
MRI_table=readtable(filename_MRI);
MRI_info=table2cell(MRI_table);
[N_MRI_info,L_MRI_info]=size(MRI_info);   % N_MRI_info: the number of scans in the MRI imaging table

filename_id='/Users/lingbinbian/Documents/BCP_fMRI_sMRI/Script_control/subj_id_dti.txt';    % subjects of ap

subj_idtable=readtable(filename_id);
subj_id=table2cell(subj_idtable);
[N,L]=size(subj_id);     % N: number of subjects

subj_info=cell(N,4);    % 1: subject ID  2: gender, 3: site

for i=1:N
    subj_info{i,1}=subj_id{i,1}(6:end);
    subj_info{i,2}=1;
    for j=1:N_MRI_info
        if str2num(subj_info{i,1})==MRI_info{j,5}
            subj_info{i,3}=MRI_info{j,8};
        end
    end
    subj_info{i,4}=subj_id{i,1}(1:2);
end

save_path=fullfile('../Script_control/subj_info_dti_gender');
save(save_path,'subj_info');



