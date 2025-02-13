% Synthetic structural & functional labels
%
% Version 1.0
% 1-Jun-2024
% Copyright (c) 2024, Lingbin Bian
% -------------------------------------------------------------------------
clear
clc
close all
% -------------------------------------------------------------------------
% Load data
% Data type
N_roi=100;
N_subj=100;
syn_FC_z=zeros(N_roi,N_subj);
syn_SC_z=zeros(N_roi,N_subj);
alpha_FC=[2,6,15];
alpha_SC=[6,5,8];

for j=1:N_subj
    syn_FC_z(:,j)=latent_generator(N_roi,3,alpha_FC);
    syn_SC_z(:,j)=latent_generator(N_roi,3,alpha_SC);
end

% Label switching
group_labels=zeros(N_roi,N_subj*2);
group_labels(:,1:N_subj)=syn_SC_z;
group_labels(:,N_subj+1:end)=syn_FC_z;
group_labels=labelswitch(group_labels);
syn_SC_z=group_labels(:,1:N_subj);
syn_FC_z=group_labels(:,N_subj+1:end);

% Save the results of structural and functional labels

data_path = fileparts(mfilename('fullpath'));

group_path=fullfile(data_path,'../results_synthetic/grouplevel_data');
  
save(group_path);


% Visualize latent label vectors ------------------------------------------


figure

imagesc(syn_SC_z)
colormap(color_type(syn_SC_z));
colorbar_community_K(unique(syn_SC_z))
title('Structural labels','fontsize',16)
xlabel('Subject','fontsize',16)
ylabel('Node','fontsize',16)
set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.35]);
saveas(gcf,'../results_synthetic/structrual_labels.fig')


figure

imagesc(syn_FC_z)
colormap(color_type(syn_FC_z));
colorbar_community_K(unique(syn_FC_z))
title('Functional labels','fontsize',16)
xlabel('Subject','fontsize',16)
ylabel('Node','fontsize',16)
set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')
set(gcf,'unit','normalized','position',[0.3,0.2,0.15,0.35]);
saveas(gcf,'../results_synthetic/functional_labels.fig')









