% MANIP Individual modularity for fMRI
% Age range 0-5,3-8,6-11,9-14,12-17,15-23,18-29,24-36,>36
% Parameters:  scan, positive, N_roi, resolution
%
% Version 1.0
% 6-July-2023
% Copyright (c) 2023, Lingbin Bian

clear
clc
close all

% -------------------------------------------------------------------------
% AP or PA
% scan=1; % 1: AP, 2: PA
%scan=1;
% -------------------------------------------------------------------------
% number of ROI
%N_roi=100;
% -------------------------------------------------------------------------
% LH or RH
% H: 1 LR, 2 RH
%H=1;
% -------------------------------------------------------------------------
% FC: positive or full connectivity
% 1: positive connectivity, 0: full connectivity
positive=1; 


% -------------------------------------------------------------------------
for N_roi=400:100:400
for scan=2:2
    for H=1:2
        for resolution=1.01:0.01:1.4  % modularity parameters      
            fprintf('Resolution: %d\n',resolution)
            individual(scan,positive,N_roi,resolution,H);
        end
    end
end
end     
% -------------------------------------------------------------------------
% nested function
function individual(scan,positive,N_roi,resolution,H)
    N_window=9;
    if scan==1
        scan_dir='AP';
        load('subj_info_ap.mat');
    else
        scan_dir='PA';
        load('subj_info_pa.mat');
    end

    
    N_subj=length(subj_info); % number of all scans
    adj_group=cell(N_subj,N_window); % 9 age windows
    age_group=cell(N_subj,N_window);
    id_group=cell(N_subj,N_window);
    label=cell(N_subj,N_window);
    modularity_Q=cell(N_subj,N_window);
    
    count=ones(1,N_window);
    
    for i=1:N_subj
        if subj_info{i,2}==0.5
            month='0_5';
        else
            month=num2str(subj_info{i,2});
        end
      
        if positive==1
            load(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/data_fMRI/',num2str(N_roi),'FC_1_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
            if H==1
                FC=FC(1:N_roi/2,1:N_roi/2);
            else
                FC=FC(N_roi/2+1:end,N_roi/2+1:end);
            end
        else
           
            load(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/data_fMRI/',num2str(N_roi),'FC_',scan_dir,'/',subj_info{i,4},'BCP',subj_info{i,1},'_',month,'mo_',scan_dir,'.mat'])
            if H==1
                FC=FC(1:N_roi/2,1:N_roi/2);
            else
                FC=FC(N_roi/2+1:end,N_roi/2+1:end);
            end
        end
 

        if subj_info{i,2}<=5
            adj_group{count(1,1),1}=FC;
            age_group{count(1,1),1}=subj_info{i,2};
            id_group{count(1,1),1}=subj_info{i,1};
            count(1,1)=count(1,1)+1;
        end
           
        if 3<=subj_info{i,2}&&subj_info{i,2}<=8
            adj_group{count(1,2),2}=FC;
            age_group{count(1,2),2}=subj_info{i,2};
            id_group{count(1,2),2}=subj_info{i,1};
            count(1,2)=count(1,2)+1;
        end
          
        if 6<=subj_info{i,2}&&subj_info{i,2}<=11
            adj_group{count(1,3),3}=FC;
            age_group{count(1,3),3}=subj_info{i,2};
            id_group{count(1,3),3}=subj_info{i,1};
            count(1,3)=count(1,3)+1;
        end
       
        if 9<=subj_info{i,2}&&subj_info{i,2}<=14 
            adj_group{count(1,4),4}=FC;
            age_group{count(1,4),4}=subj_info{i,2};
            id_group{count(1,4),4}=subj_info{i,1};
            count(1,4)=count(1,4)+1;
        end
          
        if 12<=subj_info{i,2}&&subj_info{i,2}<=17       
            adj_group{count(1,5),5}=FC;
            age_group{count(1,5),5}=subj_info{i,2};
            id_group{count(1,5),5}=subj_info{i,1};
            count(1,5)=count(1,5)+1;
        end
         
        if 15<=subj_info{i,2}&&subj_info{i,2}<=23   
            adj_group{count(1,6),6}=FC;
            age_group{count(1,6),6}=subj_info{i,2};
            id_group{count(1,6),6}=subj_info{i,1};
            count(1,6)=count(1,6)+1;
        end
           
        if 18<=subj_info{i,2}&&subj_info{i,2}<=29     
            adj_group{count(1,7),7}=FC;
            age_group{count(1,7),7}=subj_info{i,2};
            id_group{count(1,7),7}=subj_info{i,1};
            count(1,7)=count(1,7)+1;
        end
          
        if 24<=subj_info{i,2}&&subj_info{i,2}<=36      
            adj_group{count(1,8),8}=FC;
            age_group{count(1,8),8}=subj_info{i,2};
            id_group{count(1,8),8}=subj_info{i,1};
            count(1,8)=count(1,8)+1;
        end
       
        if subj_info{i,2}>36
            adj_group{count(1,9),9}=FC;
            age_group{count(1,9),9}=subj_info{i,2};
            id_group{count(1,9),9}=subj_info{i,1};
            count(1,9)=count(1,9)+1;
        end
         
    end
    
    count_subj=count-ones(1,N_window);
    
    % individual modularity
    for j=1:N_window
        fprintf('State: %d\n',j)
        
        for i=1:count_subj(1,j)
            
            [label{i,j},modularity_Q{i,j}] =modularity_und(adj_group{i,j},resolution);
        end
    end
    
    % label switching
    group_labels=zeros(N_roi/2,N_subj);
    
    c=1;
    for j=1:N_window  
        for i=1:count_subj(1,j)
           group_labels(:,c)=label{i,j};   
           c=c+1;
        end
    end
    fprintf('Label switching ...')
    group_labels=labelswitch(group_labels);
    fprintf('Label switching ends\n')
    c=1;
    for j=1:N_window
        for i=1:count_subj(1,j)
           label{i,j}=group_labels(:,c); 
           c=c+1;
        end
    end
    
    % Save the results of individual-level modelling
    
    data_path = fileparts(mfilename('fullpath'));
 
    if positive==1
        if H==1
            group_path=fullfile(data_path,['../results_fMRI/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
        else
            group_path=fullfile(data_path,['../results_fMRI/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
       
        end
        
    else
        if H==1
            group_path=fullfile(data_path,['../results_fMRI/','roi_',num2str(N_roi),'_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
        else
            group_path=fullfile(data_path,['../results_fMRI/','roi_',num2str(N_roi),'_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
       
      
        end
    end

    
    save(group_path);


end





