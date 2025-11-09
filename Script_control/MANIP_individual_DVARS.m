% MANIP categorize DVARS, age, gender, and site into different age ranges
% Age range 0-5,3-8,6-11,9-14,12-17,15-23,18-29,24-36,>36
% Parameters:  scan, N_roi
%
% Version 1.0
% 21-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc
close all

% -------------------------------------------------------------------------
% AP or PA
% scan=1; % 1: AP, 2: PA
scan=2;
% -------------------------------------------------------------------------
% number of ROI
N_roi=400;
% -------------------------------------------------------------------------
% LH or RH
% H: 1 LH, 2 RH
H=1;
% -------------------------------------------------------------------------
     
N_window=9;
if scan==1
    scan_dir='AP';
    load('subj_info_ap.mat');
else
    scan_dir='PA';
    load('subj_info_pa.mat');
end

N_subj=length(subj_info); % number of all scans

DVARS_Global=cell(N_subj,N_window);
DVARS_Global_mean=cell(N_subj,N_window);
DVARS_ROI=cell(N_subj,N_window);
mean_DVARS_ROI=cell(N_subj,N_window);
AGE=cell(N_subj,N_window);
GENDER=cell(N_subj,N_window);
SITE=cell(N_subj,N_window);



count=ones(1,N_window);

for i=1:N_subj
    if subj_info{i,2}==0.5
        month='0_5';
    else
        month=num2str(subj_info{i,2});
    end
  
    load(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/data_fMRI/',num2str(N_roi),'DVARS_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])

    if subj_info{i,2}<=5
        DVARS_Global{count(1,1),1}=DVARS_global;
        DVARS_Global_mean{count(1,1),1}=DVARS_global_mean;
        DVARS_ROI{count(1,1),1}=DVARS_roi;
        mean_DVARS_ROI{count(1,1),1}=mean_DVARS_roi;
        AGE{count(1,1),1}=subj_info{i,2};
        GENDER{count(1,1),1}=subj_info{i,3};
        SITE{count(1,1),1}=subj_info{i,4};
        count(1,1)=count(1,1)+1;
    end
       
    if 3<=subj_info{i,2}&&subj_info{i,2}<=8
        DVARS_Global{count(1,2),2}=DVARS_global;
        DVARS_Global_mean{count(1,2),2}=DVARS_global_mean;
        DVARS_ROI{count(1,2),2}=DVARS_roi;
        mean_DVARS_ROI{count(1,2),2}=mean_DVARS_roi;
        AGE{count(1,2),2}=subj_info{i,2};
        GENDER{count(1,2),2}=subj_info{i,3};
        SITE{count(1,2),2}=subj_info{i,4};
        count(1,2)=count(1,2)+1;
    end
      
    if 6<=subj_info{i,2}&&subj_info{i,2}<=11
        DVARS_Global{count(1,3),3}=DVARS_global;
        DVARS_Global_mean{count(1,3),3}=DVARS_global_mean;
        DVARS_ROI{count(1,3),3}=DVARS_roi;
        mean_DVARS_ROI{count(1,3),3}=mean_DVARS_roi;
        AGE{count(1,3),3}=subj_info{i,2};
        GENDER{count(1,3),3}=subj_info{i,3};
        SITE{count(1,3),3}=subj_info{i,4};
        count(1,3)=count(1,3)+1;
    end
   
    if 9<=subj_info{i,2}&&subj_info{i,2}<=14 
        DVARS_Global{count(1,4),4}=DVARS_global;
        DVARS_Global_mean{count(1,4),4}=DVARS_global_mean;
        DVARS_ROI{count(1,4),4}=DVARS_roi;
        mean_DVARS_ROI{count(1,4),4}=mean_DVARS_roi;
        AGE{count(1,4),4}=subj_info{i,2};
        GENDER{count(1,4),4}=subj_info{i,3};
        SITE{count(1,4),4}=subj_info{i,4};
        count(1,4)=count(1,4)+1;
    end
      
    if 12<=subj_info{i,2}&&subj_info{i,2}<=17       
        DVARS_Global{count(1,5),5}=DVARS_global;
        DVARS_Global_mean{count(1,5),5}=DVARS_global_mean;
        DVARS_ROI{count(1,5),5}=DVARS_roi;
        mean_DVARS_ROI{count(1,5),5}=mean_DVARS_roi;
        AGE{count(1,5),5}=subj_info{i,2};
        GENDER{count(1,5),5}=subj_info{i,3};
        SITE{count(1,5),5}=subj_info{i,4};
        count(1,5)=count(1,5)+1;
    end
     
    if 15<=subj_info{i,2}&&subj_info{i,2}<=23   
        DVARS_Global{count(1,6),6}=DVARS_global;
        DVARS_Global_mean{count(1,6),6}=DVARS_global_mean;
        DVARS_ROI{count(1,6),6}=DVARS_roi;
        mean_DVARS_ROI{count(1,6),6}=mean_DVARS_roi;
        AGE{count(1,6),6}=subj_info{i,2};
        GENDER{count(1,6),6}=subj_info{i,3};
        SITE{count(1,6),6}=subj_info{i,4};
        count(1,6)=count(1,6)+1;
    end
       
    if 18<=subj_info{i,2}&&subj_info{i,2}<=29     
        DVARS_Global{count(1,7),7}=DVARS_global;
        DVARS_Global_mean{count(1,7),7}=DVARS_global_mean;
        DVARS_ROI{count(1,7),7}=DVARS_roi;
        mean_DVARS_ROI{count(1,7),7}=mean_DVARS_roi;
        AGE{count(1,7),7}=subj_info{i,2};
        GENDER{count(1,7),7}=subj_info{i,3};
        SITE{count(1,7),7}=subj_info{i,4};
        count(1,7)=count(1,7)+1;
    end
      
    if 24<=subj_info{i,2}&&subj_info{i,2}<=36      
        DVARS_Global{count(1,8),8}=DVARS_global;
        DVARS_Global_mean{count(1,8),8}=DVARS_global_mean;
        DVARS_ROI{count(1,8),8}=DVARS_roi;
        mean_DVARS_ROI{count(1,8),8}=mean_DVARS_roi;
        AGE{count(1,8),8}=subj_info{i,2};
        GENDER{count(1,8),8}=subj_info{i,3};
        SITE{count(1,8),8}=subj_info{i,4};
        count(1,8)=count(1,8)+1;
    end
   
    if subj_info{i,2}>36
        DVARS_Global{count(1,9),9}=DVARS_global;
        DVARS_Global_mean{count(1,9),9}=DVARS_global_mean;
        DVARS_ROI{count(1,9),9}=DVARS_roi;
        mean_DVARS_ROI{count(1,9),9}=mean_DVARS_roi;
        AGE{count(1,9),9}=subj_info{i,2};
        GENDER{count(1,9),9}=subj_info{i,3};
        SITE{count(1,9),9}=subj_info{i,4};
        count(1,9)=count(1,9)+1;
    end
end

count_subj=count-ones(1,N_window);

% Save the results of individual-level modelling

data_path = fileparts(mfilename('fullpath'));

group_path=fullfile(data_path,['../results_fMRI/','roi_',num2str(N_roi),'_1_',scan_dir,'/DVARS_',scan_dir]);
            
save(group_path);



