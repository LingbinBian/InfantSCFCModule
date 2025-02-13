% MANIP Individual modularity for DTI
% Age range 0-5,3-8,6-11,9-14,12-17,15-23,18-29,24-36,>36
% Parameters:  scan, positive, N_roi, resolution
%
% Version 1.0
% 1-Jun-2024
% Copyright (c) 2024, Lingbin Bian

clear
clc
close all
% -------------------------------------------------------------------------
% AP or PA
% scan=1; % 1: AP, 2: PA
%scan=2;

% -------------------------------------------------------------------------
% number of ROI
%N_roi=200;
% -------------------------------------------------------------------------
% LH or RH
% H: 1 LR, 2 RH
%H=2;
% -------------------------------------------------------------------------
% SC: strength or count
% 1: strength, 2: count
type=1; 
% -------------------------------------------------------------------------
% FC: positive or full connectivity
% 1: positive connectivity, 0: full connectivity
positive=1; 

% -------------------------------------------------------------------------
for N_roi=400:100:400
for scan=2:2
    for H=1:2
        for resolution=1.01:0.01:1.4
        
            fprintf('Resolution: %d\n',resolution)
            individual(scan,type,positive,N_roi,resolution,H);
        end
    end
end
end
          
       
% -------------------------------------------------------------------------
% 
function individual(scan,type,positive,N_roi,resolution,H)
    if scan==1
        scan_dir='AP';
    else
        scan_dir='PA';
    end
    load('subj_info_dti.mat');
    N_window=9;
    N_scan=391;
    N_subj=length(subj_info); % number of subjects
    adj_group=cell(N_scan,N_window); % 9 age windows
    age_group=cell(N_scan,N_window);
    id_group=cell(N_scan,N_window);
    label=cell(N_scan,N_window);
    modularity_Q=cell(N_scan,N_window);
    
    count=ones(1,N_window);
    
    for i=1:N_subj
       for j=1:length(subj_info{i,2}) 
       
        if scan==1
            if type==1
                SC_ori=readmatrix(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/data_DTI/Connectome/',subj_info{i,1},'/',subj_info{i,2}{1,j},'/','connectome_strength_ap_s_',num2str(N_roi),'_7','.csv']);  
            else
                SC_ori=readmatrix(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/data_DTI/Connectome/',subj_info{i,1},'/',subj_info{i,2}{1,j},'/','connectome_ap_s_',num2str(N_roi),'_7','.csv']);  
            end
            if H==1
                SC=SC_ori(2:N_roi/2+1,2:N_roi/2+1);
            else
                SC=SC_ori(N_roi/2+2:end,N_roi/2+2:end);
            end
          
            %load(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/data_DTI/Connectome/','MNBCP116056','/','3mo','/','connectome_ap_s_','100','_7','.csv']);   
     
        else
            if type==1
                SC_ori=readmatrix(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/data_DTI/Connectome/',subj_info{i,1},'/',subj_info{i,2}{1,j},'/','connectome_strength_pa_s_',num2str(N_roi),'_7','.csv']);
            else
                SC_ori=readmatrix(['/Users/lingbinbian/Documents/BCP_fMRI_sMRI/data_DTI/Connectome/',subj_info{i,1},'/',subj_info{i,2}{1,j},'/','connectome_pa_s_',num2str(N_roi),'_7','.csv']);
            end
            if H==1
                SC=SC_ori(2:N_roi/2+1,2:N_roi/2+1);
            else
                SC=SC_ori(N_roi/2+2:end,N_roi/2+2:end);
            end
        end
       
        if subj_info{i,2}{1,j}(end)=='k' % check whether the age unit is 'wk'
            age=0.5;
        else
            age=str2double(subj_info{i,2}{1,j}(1:end-2));
        end
        if age<=5
            adj_group{count(1,1),1}=SC;
            age_group{count(1,1),1}=age;
            id_group{count(1,1),1}=subj_info{i,1};
            count(1,1)=count(1,1)+1;
        end
           
        if 3<=age&&age<=8
            adj_group{count(1,2),2}=SC;
            age_group{count(1,2),2}=age;
            id_group{count(1,2),2}=subj_info{i,1};
            count(1,2)=count(1,2)+1;
        end
          
        if 6<=age&&age<=11
            adj_group{count(1,3),3}=SC;
            age_group{count(1,3),3}=age;
            id_group{count(1,3),3}=subj_info{i,1};
            count(1,3)=count(1,3)+1;
        end
       
        if 9<=age&&age<=14 
            adj_group{count(1,4),4}=SC;
            age_group{count(1,4),4}=age;
            id_group{count(1,4),4}=subj_info{i,1};
            count(1,4)=count(1,4)+1;
        end
          
        if 12<=age&&age<=17       
            adj_group{count(1,5),5}=SC;
            age_group{count(1,5),5}=age;
            id_group{count(1,5),5}=subj_info{i,1};
            count(1,5)=count(1,5)+1;
        end
         
        if 15<=age&&age<=23   
            adj_group{count(1,6),6}=SC;
            age_group{count(1,6),6}=age;
            id_group{count(1,6),6}=subj_info{i,1};
            count(1,6)=count(1,6)+1;
        end
           
        if 18<=age&&age<=29     
            adj_group{count(1,7),7}=SC;
            age_group{count(1,7),7}=age;
            id_group{count(1,7),7}=subj_info{i,1};
            count(1,7)=count(1,7)+1;
        end
          
        if 24<=age&&age<=36      
            adj_group{count(1,8),8}=SC;
            age_group{count(1,8),8}=age;
            id_group{count(1,8),8}=subj_info{i,1};
            count(1,8)=count(1,8)+1;
        end
       
        if age>36
            adj_group{count(1,9),9}=SC;
            age_group{count(1,9),9}=age;
            id_group{count(1,9),9}=subj_info{i,1};
            count(1,9)=count(1,9)+1;
        end
       end   
    end
    
    count_subj=count-ones(1,N_window);

    % individual modularity
    for j=1:N_window
        fprintf('Age window: %d\n',j)

        for i=1:count_subj(1,j)

            [label{i,j},modularity_Q{i,j}] =modularity_und(adj_group{i,j},resolution);
        end
    end
    % 
    % label switching
    group_labels=zeros(N_roi/2,N_scan);

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
    for j=1:9
        for i=1:count_subj(1,j)
           label{i,j}=group_labels(:,c); 
           c=c+1;
        end
    end
    % 
    % Save the results of individual-level modelling

    data_path = fileparts(mfilename('fullpath'));
  
            if positive==1
                if type==1
                    if H==1
                        group_path=fullfile(data_path,['../results_DTI_strength/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
                    else
                        group_path=fullfile(data_path,['../results_DTI_strength/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
                   
                    end
                else
                    if H==1
                        group_path=fullfile(data_path,['../results_DTI_count/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
                    else
                        group_path=fullfile(data_path,['../results_DTI_count/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
                
                    end
                end
            else
                if type==1
                    if H==1
                        group_path=fullfile(data_path,['../results_DTI_strength/','roi_',num2str(N_roi),'_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
                    else
                        group_path=fullfile(data_path,['../results_DTI_strength/','roi_',num2str(N_roi),'_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
                 
                    end
                else
                    if H==1
                        group_path=fullfile(data_path,['../results_DTI_count/','roi_',num2str(N_roi),'_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
                    else
                        group_path=fullfile(data_path,['../results_DTI_count/','roi_',num2str(N_roi),'_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_',scan_dir]);
                
                    end
                end
            end


    save(group_path);

end





