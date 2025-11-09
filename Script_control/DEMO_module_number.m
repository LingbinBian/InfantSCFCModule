% DEMON number of modules versus resolution
%
% Version 1.0
% 18-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc
close all

data_type=2; % 1:fMRI, 2:DTI
scan=1; % 1:AP 2:PA
N_roi=100; % number of ROIs
N_window=9;  % number of age range
H=1; % H: 1 LH, 2 RH
res=1.01:0.01:1.4;  % modularity resolutions
N_res=40;  % number of modularity resolutions

K_indi_longi=cell(N_window,1); % longitudinal individual number of modules


for n=1:N_window
    if data_type==1
        [K_indi_longi{n,1}]=number_commu_fMRI(scan,H,N_roi,res,N_res,n);
    else
        [K_indi_longi{n,1}]=number_commu_dti(scan,H,N_roi,res,N_res,n);
    end
end

colorvector=[1,1,0;0.78,0.38,0.08;0,0,1;1,0,0;0,1,0;0,0.5,0;0.5,0.5,0;1,0.5,0.5];

for j=1:N_res
    count_K=tabulate(K_indi_longi{1,1}(:,j)); % first age range
    count_K_og=count_K;
    count_K(count_K(:,2)==0,:)=[];
    scatter(res(j),count_K(:,1),5*count_K(:,2),'filled')
    alpha(0.6)
    hold on
end

hold on

%set(gca,'fontsize',16)
set(gca,'box','on')
set(gca, 'linewidth', 1.2, 'fontsize', 12, 'fontname', 'times')
if scan==1
    if H==1
        title(['AP',', ROI=',num2str(N_roi),', LH'],'fontsize', 16)
    else
        title(['AP',', ROI=',num2str(N_roi),', RH'],'fontsize', 16)
    end
else
    if H==1
        title(['PA',', ROI=',num2str(N_roi),', LH'],'fontsize', 16)
    else
        title(['PA',', ROI=',num2str(N_roi),', RH'],'fontsize', 16)
    end
end
xlabel('\gamma','fontsize',16)
ylabel('K','fontsize',16)
set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
xlim([1,1.4]); % range of x
set(gcf,'unit','centimeters','position',[6 10 14 12])
set(gca,'Position',[.22 .2 .65 .65]);
data_path = fileparts(mfilename('fullpath'));


if data_type==1
    if scan==1
    
        saveas(gcf,['../figure/','roi_',num2str(N_roi),'_AP','_number_communities_fMRI.fig'])
        saveas(gcf,['../figure_paper/','roi_',num2str(N_roi),'_AP','_number_communities_fMRI.svg'])
    elseif scan==2
    
        saveas(gcf,['../figure/','roi_',num2str(N_roi),'_PA','_number_communities_fMRI.fig'])
        saveas(gcf,['../figure_paper/','roi_',num2str(N_roi),'_PA','_number_communities_fMRI.svg'])
    end
else
    if scan==1
    
        saveas(gcf,['../figure/','roi_',num2str(N_roi),'_AP','_number_communities_dti.fig'])
        saveas(gcf,['../figure_paper/','roi_',num2str(N_roi),'_AP','_number_communities_dti.svg'])
    elseif scan==2
    
        saveas(gcf,['../figure/','roi_',num2str(N_roi),'_PA','_number_communities_dti.fig'])
        saveas(gcf,['../figure_paper/','roi_',num2str(N_roi),'_PA','_number_communities_dti.svg'])
    end
end

% -------------------------------------------------------------------------
% nested function
function [K_indi]=number_commu_fMRI(scan,H,N_roi,res,N_res,age_window)
% scan: 1 AP, 2 PA
% N_roi: number of ROIs
% N_res: number of modularity resolutions    
% N_window: number of age range

    label_res=cell(1,N_res); % a struct containing individual module labels
   
    if scan==1     
        if H==1
            for j=1:N_res
                label_res{j}=load(['../results_fMRI/','roi_',num2str(N_roi),'_1_','AP','/','LH','/',num2str(res(j)),'/grouplevel_data_AP.mat']);
            end
        else
            for j=1:N_res
                label_res{j}=load(['../results_fMRI/','roi_',num2str(N_roi),'_1_','AP','/','RH','/',num2str(res(j)),'/grouplevel_data_AP.mat']);
            end

        end
    else

        if H==1
            for j=1:N_res
                label_res{j}=load(['../results_fMRI/','roi_',num2str(N_roi),'_1_','PA','/','LH','/',num2str(res(j)),'/grouplevel_data_PA.mat']);
            end
        else
            for j=1:N_res
                label_res{j}=load(['../results_fMRI/','roi_',num2str(N_roi),'_1_','PA','/','RH','/',num2str(res(j)),'/grouplevel_data_PA.mat']);
            end
        end
    end
    K_indi=zeros(label_res{1,1}.count_subj(1,age_window),N_res); % number of modules of individual FC
    for j=1:N_res
        for i=1:label_res{1,1}.count_subj(1,age_window)
            K_indi(i,j)=max(label_res{1,j}.label{i,age_window});
        end
    end
end


function [K_indi]=number_commu_dti(scan,H,N_roi,res,N_res,age_window)
% scan: 1 AP, 2 PA
% N_roi: number of ROIs
% N_res: number of modularity resolutions    
% N_window: number of age range

    label_res=cell(1,N_res); % a struct containing individual module labels
   
    if scan==1     
        if H==1
            for j=1:N_res
                label_res{j}=load(['../results_DTI_strength/','roi_',num2str(N_roi),'_1_','AP','/','LH','/',num2str(res(j)),'/grouplevel_data_AP.mat']);
            end
        else
            for j=1:N_res
                label_res{j}=load(['../results_DTI_strength/','roi_',num2str(N_roi),'_1_','AP','/','RH','/',num2str(res(j)),'/grouplevel_data_AP.mat']);
            end

        end
    else

        if H==1
            for j=1:N_res
                label_res{j}=load(['../results_DTI_strength/','roi_',num2str(N_roi),'_1_','PA','/','LH','/',num2str(res(j)),'/grouplevel_data_PA.mat']);
            end
        else
            for j=1:N_res
                label_res{j}=load(['../results_DTI_strength/','roi_',num2str(N_roi),'_1_','PA','/','RH','/',num2str(res(j)),'/grouplevel_data_PA.mat']);
            end
        end
    end
    K_indi=zeros(label_res{1,1}.count_subj(1,age_window),N_res); % number of modules of individual FC
    for j=1:N_res
        for i=1:label_res{1,1}.count_subj(1,age_window)
            K_indi(i,j)=max(label_res{1,j}.label{i,age_window});
        end
    end
end





