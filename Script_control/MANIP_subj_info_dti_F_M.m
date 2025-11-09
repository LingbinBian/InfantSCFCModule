% MANIP create subj_info_dti_F_M for Female and Male

% Version 1.0
% 25-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc
close all

N_AP_F=107;
N_AP_M=106;

subj_info_dti_F=cell(N_AP_F,2);
subj_info_dti_M=cell(N_AP_M,2);

load('subj_info_dti.mat')
subj_info_age=subj_info;
load('subj_info_dti_gender.mat')
subj_info_gender=subj_info;

N_subj=length(subj_info_gender);
c_F=1;
c_M=1;
for i=1:N_subj
    if subj_info_gender{i,3}=='F'
        subj_info_dti_F{c_F,1}=subj_info_age{i,1};
        subj_info_dti_F{c_F,2}=subj_info_age{i,2};
   
        c_F=c_F+1;

    elseif subj_info{i,3}=='M'
        subj_info_dti_M{c_M,1}=subj_info_age{i,1};
        subj_info_dti_M{c_M,2}=subj_info_age{i,2};

        c_M=c_M+1;
    end

end

save_path=fullfile('../Script_control/subj_info_dti_F');
save(save_path,'subj_info_dti_F');

save_path=fullfile('../Script_control/subj_info_dti_M');
save(save_path,'subj_info_dti_M');
