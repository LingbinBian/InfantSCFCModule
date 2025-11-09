% MANIP Calculate DVARS from ROI-wise BOLD signals
%
% Version 1.0
% 21-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc
close all

scan=2; % 1:AP, 2:PA
N_roi=400;   % number of ROI

if scan==1
    scan_dir='AP';
    list=dir('../data_fMRI/100ROI_AP/*.mat');
else
    scan_dir='PA';
    list=dir('../data_fMRI/100ROI_PA/*.mat');
end
N_sub=length(list);   % number of subjects
DVARS_name=cell(N_sub,1);

for i=1:N_sub
    fprintf('subject = %d\n',i);
    struct_ROI=load(['../data_fMRI/',num2str(N_roi),'ROI_',scan_dir,'/',list(i).name]);
    ROI_name = fieldnames(struct_ROI);
    Brain_ROISignal = getfield(struct_ROI, ROI_name{1}); 
    [DVARS_roi, mean_DVARS_roi, DVARS_global]=computeDVARS(Brain_ROISignal);
    DVARS_global_mean=mean(DVARS_global);
    DVARS_name{i,1}=ROI_name{1,1}(1:end-10);
    save_path=fullfile(['../data_fMRI/',num2str(N_roi),'DVARS_',scan_dir,'/',DVARS_name{i,1}]);
    save(save_path,'DVARS_global_mean','DVARS_global','DVARS_roi','mean_DVARS_roi');
end




      
  


   