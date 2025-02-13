% MANIP Structural and functional similarity
% Age range 0-5,3-8,6-11,9-14,12-17,15-23,18-29,24-36,>36
%
% Version 1.0
% 3-Jun-2024
% Copyright (c) 2024, Lingbin Bian

clear
clc
close all

N_window=9;

%N_roi=100;

%scan=2;   % 1: AP, 2: PA
type=1;

%H=2;
for N_roi=100:100:100
for scan=1:1
    for H=1:1
        for resolution=1.2:1.2
            fprintf('Resolution: %d\n',resolution)
            SC_FC_similarity_measure(type,N_window,N_roi,scan,resolution,H)
            close all    
        end
    end
end
end
% -------------------------------------------------------------------------

function SC_FC_similarity_measure(type,N_window,N_roi,scan,resolution,H)
    if scan==1
        scan_dir='AP';
        if type==1
            if H==1
                load(['../','results_DTI_strength','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_AP.mat']);
            else
                load(['../','results_DTI_strength','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_AP.mat']);
          
            end
        else
            if H==1
                load(['../','results_DTI_count','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_AP.mat'])
            else
                load(['../','results_DTI_count','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_AP.mat'])
          
            end
        end
    else
        scan_dir='PA';
        if type==1
            if H==1
                load(['../','results_DTI_strength','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_PA.mat']);
            else
                load(['../','results_DTI_strength','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_PA.mat']);
         
            end
        else
            if H==1
                load(['../','results_DTI_count','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_PA.mat']);
            else
                load(['../','results_DTI_count','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_PA.mat']);
       
            end
        end
    end
    label_DTI=label;
    subj_info_DTI=subj_info;
    age_group_DTI=age_group;
    count_subj_DTI=count_subj;
    
    if scan==1
        scan_dir='AP';
        if H==1
            load(['../','results_fMRI','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_AP.mat']);
        else
            load(['../','results_fMRI','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_AP.mat']);
       
        end
    else
        
        scan_dir='PA';
        if H==1
            load(['../','results_fMRI','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/grouplevel_data_PA.mat']);
        else
            load(['../','results_fMRI','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/grouplevel_data_PA.mat']);
  
        end
    end
      
    label_fMRI=label;
    subj_info_fMRI=subj_info;
    age_group_fMRI=age_group;
    count_subj_fMRI=count_subj;
    % 
    % label_fMRI=cell(N_scan,N_window);
    % for j=1:N_window
    %     for i=1:count_subj_fMRI(1,j)
    %         label_fMRI{i,j}=label{i,j}(1:N_roi/2);
    %     end
    % end

    % label switching between SC and FC
    
    K=zeros(1,N_window);
    K_SC=zeros(1,N_window);

    for j=1:N_window  
        c=1;
        group_labels=zeros(N_roi/2,count_subj_DTI(1,j)+count_subj_fMRI(1,j));
        for i=1:count_subj_DTI(1,j)
            group_labels(:,c)=label_DTI{i,j};
            c=c+1;
        end
        for i=1:count_subj_fMRI(1,j)
            group_labels(:,c)=label_fMRI{i,j};
            c=c+1;
        end
        group_labels=labelswitch(group_labels);
        c=1;
        for i=1:count_subj_DTI(1,j)
            label_DTI{i,j}=group_labels(:,c);
            c=c+1;
        end
        for i=1:count_subj_fMRI(1,j)
            label_fMRI{i,j}=group_labels(:,c);
            c=c+1;
        end
        K(1,j)=max(max(group_labels));
        K_SC(1,j)=max(max(group_labels(:,1:count_subj_DTI(1,j))));
    end
    
    
    % Visualize latent label vectors ------------------------------------------
    
    for j=1:N_window
     switch j
        case 1
            age='0-5';
        case 2
            age='3-8';
        case 3
            age='6-11';
        case 4
            age='9-14';
        case 5
            age='12-17';
        case 6
            age='15-23';
        case 7
            age='18-29';
        case 8
            age='24-36';
        otherwise
            age='>36';
     end
        mat_labels=zeros(N_roi/2,count_subj_DTI(1,j)+count_subj_fMRI(1,j));
        
        for i=1:count_subj_DTI(1,j)   
            mat_labels(:,i)=label_DTI{i,j};  
        end
        for i=1:count_subj_fMRI(1,j)
            mat_labels(:,count_subj_DTI(1,j)+i)=label_fMRI{i,j}; 
    
        end
        figure
        imagesc(mat_labels(:,1:count_subj_DTI(1,j)))
        colormap(color_type(mat_labels(:,1:count_subj_DTI(1,j))));
        colorbar_community_K(unique(mat_labels(:,1:count_subj_DTI(1,j))))

        title(['SC ',age,'month'],'fontsize',16)
        xlabel('Subject (scans)','fontsize',16)
        ylabel('Node','fontsize',16)
        set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
        set(gcf,'unit','normalized','position',[0.3,0.2,0.05+0.002*count_subj_DTI(1,j),0.25]);
        if type==1
            if H==1
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/SC_labels_',scan_dir,num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/SC_labels_',scan_dir,num2str(j),'.fig'])

            end

        else
            if H==1
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/SC_labels_',scan_dir,num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/SC_labels_',scan_dir,num2str(j),'.fig'])

            end
        end
        figure
        imagesc(mat_labels(:,count_subj_DTI(1,j)+1:end))
        colormap(color_type(mat_labels(:,count_subj_DTI(1,j)+1:end)))
        colorbar_community_K(unique(mat_labels(:,count_subj_DTI(1,j)+1:end)))


        title(['FC ',age,'month'],'fontsize',16)
        xlabel('Subject (scans)','fontsize',16)
        ylabel('Node','fontsize',16)
        set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
        set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.35]);
        set(gcf,'unit','normalized','position',[0.3,0.2,0.05+0.002*count_subj_fMRI(1,j),0.25]);

        if type==1
            if H==1
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/FC_labels_',scan_dir,num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/FC_labels_',scan_dir,num2str(j),'.fig'])

            end

        else
            if H==1
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/FC_labels_',scan_dir,num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/FC_labels_',scan_dir,num2str(j),'.fig'])

            end
        end
    end
    
    
    
    R_esti_DTI=cell(1,N_window);   % label assignment probability
    R_esti_fMRI=cell(1,N_window);
    
    Aphla_post_DTI=cell(1,N_window);
    Aphla_post_fMRI=cell(1,N_window);
    
    N_simu=1000; % number of samples drawn from posterior
    
    % Estimate assignment probability & calculate posterior alpha
    for j=1:N_window
       fprintf('State: %d\n',j)
       mat_labels_DTI=zeros(N_roi/2,count_subj_DTI(1,j));
       for n=1:count_subj_DTI(1,j)
            mat_labels_DTI(:,n)=label_DTI{n,j};
       end
       [R_esti_DTI{1,j},Aphla_post_DTI{1,j}]=assign_esti(mat_labels_DTI,K(1,j),N_simu);
    
       mat_labels_fMRI=zeros(N_roi/2,count_subj_fMRI(1,j));
       for n=1:count_subj_fMRI(1,j)
            mat_labels_fMRI(:,n)=label_fMRI{n,j};
       end
       [R_esti_fMRI{1,j},Aphla_post_fMRI{1,j}]=assign_esti(mat_labels_fMRI,K(1,j),N_simu);
       
    end
    
    
    % Visualize alpha
    
    for j=1:N_window
        switch j
            case 1
                age='0-5';
            case 2
                age='3-8';
            case 3
                age='6-11';
            case 4
                age='9-14';
            case 5
                age='12-17';
            case 6
                age='15-23';
            case 7
                age='18-29';
            case 8
                age='24-36';
            otherwise
                age='>36';
        end
    
        % SC assignment probability
        figure
        imagesc(R_esti_DTI{j})
        colormap(sky);
        colorbar
        title(['SC r',' ',age],'fontsize',16) 
        xlabel('k','fontsize',16) 
        ylabel('Node','fontsize',16)      
        set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
        set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.25]);   
        if type==1
            if H==1
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/SC_assignment_probability_',scan_dir,'_',num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/SC_assignment_probability_',scan_dir,'_',num2str(j),'.fig'])
          
            end
        else
            if H==1
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/SC_assignment_probability_',scan_dir,'_',num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/SC_assignment_probability_',scan_dir,'_',num2str(j),'.fig'])
          
            end
        end
        % FC assignment probability
        figure
        imagesc(R_esti_fMRI{j})
        colormap(flip(pink));
        colorbar
        title(['FC r',' ',age],'fontsize',16) 
        xlabel('k','fontsize',16) 
        ylabel('Node','fontsize',16)      
        set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
        set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.25]);  
        if type==1
            if H==1
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/FC_assignment_probability_',scan_dir,'_',num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/FC_assignment_probability_',scan_dir,'_',num2str(j),'.fig'])
         
            end
        else
            if H==1
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/FC_assignment_probability_',scan_dir,'_',num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/FC_assignment_probability_',scan_dir,'_',num2str(j),'.fig'])
         
            end
        end
        % SC alpha
        figure
        imagesc(Aphla_post_DTI{j})
        colormap(flip(hot));
        colorbar
        title(['SC \alpha',' ',age],'fontsize',16) 
        xlabel('k','fontsize',16) 
        ylabel('Node','fontsize',16)      
        set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
        set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.25]);   
        if type==1
            if H==1
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/SC_posterior_alpha_',scan_dir,'_',num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/SC_posterior_alpha_',scan_dir,'_',num2str(j),'.fig'])
         
            end
        else
            if H==1
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/SC_posterior_alpha_',scan_dir,'_',num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/SC_posterior_alpha_',scan_dir,'_',num2str(j),'.fig'])
         
            end
        end

        % FC alpha
        figure
        imagesc(Aphla_post_fMRI{j})
        colormap(flip(gray));
        colorbar
        title(['FC \alpha',' ',age],'fontsize',16) 
        xlabel('k','fontsize',16) 
        ylabel('Node','fontsize',16)      
        set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
        set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.25]);  
        if type==1
            if H==1
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/FC_posterior_alpha_',scan_dir,'_',num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/FC_posterior_alpha_',scan_dir,'_',num2str(j),'.fig'])
         
            end
        else
            if H==1
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/FC_posterior_alpha_',scan_dir,'_',num2str(j),'.fig'])
            else
                saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/FC_posterior_alpha_',scan_dir,'_',num2str(j),'.fig'])
         
            end
        end
    end
    
    % chernoff
    
    c_SC_FC=zeros(N_roi/2,N_window);
    
    for j=1:N_window
        switch j
            case 1
                age='0-5';
            case 2
                age='3-8';
            case 3
                age='6-11';
            case 4
                age='9-14';
            case 5
                age='12-17';
            case 6
                age='15-23';
            case 7
                age='18-29';
            case 8
                age='24-36';
            otherwise
                age='>36';
       end
       fprintf('State: %d\n',j)
       for i=1:N_roi/2
           c_SC_FC(i,j)=corr(Aphla_post_DTI{j}(i,:)',Aphla_post_fMRI{j}(i,:)');
       end
       figure
       imagesc(c_SC_FC(:,j))
       colormap(jet)
       colorbar
       title(['C',' ',age],'fontsize',16) 
       set(gcf,'unit','normalized','position',[0.3,0.2,0.08,0.25]);
       if type==1
           if H==1
               saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/C_SC_FC_',scan_dir,'_',num2str(j),'.fig'])
           else
               saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/C_SC_FC_',scan_dir,'_',num2str(j),'.fig'])
         
           end
       else 
           if H==1
               saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/C_SC_FC_',scan_dir,'_',num2str(j),'.fig'])
           else
               saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/C_SC_FC_',scan_dir,'_',num2str(j),'.fig'])
         
           end
       end
    end
    
    data_path = fileparts(mfilename('fullpath'));
    if type==1
        if H==1
            SC_FC_results_path=fullfile(data_path,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/SC_FC_results']);
        else
            SC_FC_results_path=fullfile(data_path,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/SC_FC_results']);
    
        end
    else 
        if H==1
            SC_FC_results_path=fullfile(data_path,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution),'/SC_FC_results']);
        else
            SC_FC_results_path=fullfile(data_path,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution),'/SC_FC_results']);
    
        end
    end
    save(SC_FC_results_path,'label_DTI','label_fMRI','R_esti_DTI','R_esti_fMRI','Aphla_post_DTI','Aphla_post_fMRI','c_SC_FC');

end









