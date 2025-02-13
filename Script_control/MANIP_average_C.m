% MANIP Averaging C coefficient

%
% Version 1.0
% 1-Jun-2024
% Copyright (c) 2024, Lingbin Bian
clear
clc
close all

type=1; % 1 DTI strength, 2 DTI count
N_roi=400;
N_window=9;
scan_dir='PA';
N_res=40;
c_group_LH=cell(N_res,1);
c_group_RH=cell(N_res,1);

% -------------------------------------------------------------------------
% LH or RH
% H: 1 LR, 2 RH


resolution=1.01:0.01:1.4;
for n=1:N_res 
    load(['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','LH/',num2str(resolution(n)),'/SC_FC_results'])
    c_group_LH{n}=c_SC_FC;
end

for n=1:N_res
    load(['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/','RH/',num2str(resolution(n)),'/SC_FC_results'])
    c_group_RH{n}=c_SC_FC;
end

c_mean=zeros(N_roi,N_window);

c_temporal=zeros(N_res,1);

% calculate the mean of c across resolution
for j=1:N_window
    for i=1:N_roi/2
        for n=1:N_res
           c_temporal(n)=c_group_LH{n}(i,j);
        end
        c_mean(i,j)=mean(c_temporal);
        c_temporal=zeros(N_res,1);
    end
end

for j=1:N_window
    for i=1:N_roi/2
        for n=1:N_res
           c_temporal(n)=c_group_LH{n}(i,j);
        end
        c_mean(N_roi/2+i,j)=mean(c_temporal);
        c_temporal=zeros(N_res,1);
    end
end

% visualize the mean c

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

       figure
       imagesc(c_mean(:,j))
       colormap(jet)
       colorbar
       title(['C',' ',age],'fontsize',16) 
       set(gcf,'unit','normalized','position',[0.3,0.2,0.06,0.33]);
       if type==1
         
           saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/C_mean_SC_FC_',scan_dir,'_',num2str(j),'.fig'])
   
       else 
          
           saveas(gcf,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/C_mean_SC_FC_',scan_dir,'_',num2str(j),'.fig'])
     
       end
end


data_path = fileparts(mfilename('fullpath'));
if type==1  
    SC_FC_results_path=fullfile(data_path,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/c_mean_SC_FC_results']);
else 
    SC_FC_results_path=fullfile(data_path,['../','results_SC_count_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/c_mean_SC_FC_results']);
end
save(SC_FC_results_path,'c_mean');



% Plot the LH
figure

if N_roi==100
    c_LH_Vis=mean(c_mean(1:9,:));
    c_LH_SomMot=mean(c_mean(10:15,:));
    c_LH_DorsAttn=mean(c_mean(16:23,:));
    c_LH_SalVentAttn=mean(c_mean(24:30,:));
    c_LH_Limbic=mean(c_mean(31:33,:));
    c_LH_Cont=mean(c_mean(34:37,:));
    c_LH_Default=mean(c_mean(40:50,:));
elseif N_roi==200
    c_LH_Vis=mean(c_mean(1:14,:));
    c_LH_SomMot=mean(c_mean(15:30,:));
    c_LH_DorsAttn=mean(c_mean(31:43,:));
    c_LH_SalVentAttn=mean(c_mean(44:54,:));
    c_LH_Limbic=mean(c_mean(55:60,:));
    c_LH_Cont=mean(c_mean(61:73,:));
    c_LH_Default=mean(c_mean(74:100,:));
elseif N_roi==300
    c_LH_Vis=mean(c_mean(1:24,:));
    c_LH_SomMot=mean(c_mean(25:53,:));
    c_LH_DorsAttn=mean(c_mean(54:69,:));
    c_LH_SalVentAttn=mean(c_mean(70:85,:));
    c_LH_Limbic=mean(c_mean(86:95,:));
    c_LH_Cont=mean(c_mean(96:112,:));
    c_LH_Default=mean(c_mean(113:150,:));
elseif N_roi==400
    c_LH_Vis=mean(c_mean(1:31,:));
    c_LH_SomMot=mean(c_mean(32:68,:));
    c_LH_DorsAttn=mean(c_mean(69:91,:));
    c_LH_SalVentAttn=mean(c_mean(92:113,:));
    c_LH_Limbic=mean(c_mean(114:126,:));
    c_LH_Cont=mean(c_mean(127:148,:));
    c_LH_Default=mean(c_mean(149:200,:));
end

plot(1:9,c_LH_Vis(1,:),'-r',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','red',...
'MarkerFaceColor','red');
hold on

plot(1:9,c_LH_SomMot(1,:),'-g',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','green',...
'MarkerFaceColor','green');
hold on

plot(1:9,c_LH_DorsAttn(1,:),'-b',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','blue',...
'MarkerFaceColor','blue');
hold on

plot(1:9,c_LH_SalVentAttn(1,:),'-c',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','cyan',...
'MarkerFaceColor','cyan');
hold on

plot(1:9,c_LH_Limbic(1,:),'-m',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','magenta',...
'MarkerFaceColor','magenta');
hold on

plot(1:9,c_LH_Cont(1,:),'y',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','yellow',...
'MarkerFaceColor','yellow');
hold on

plot(1:9,c_LH_Default(1,:),'k',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','black',...
'MarkerFaceColor','black');
hold on


legend('LH Vis', ...
    'LH SomMot',...
    'LH DorsAttn',...
    'LH SalVentAttn',...
    'LH Limbic',...
    'LH Cont',...
    'LH Default','fontsize', 12,'location','southwest')

title({['ROI ',num2str(N_roi),' LH']},'fontsize',16)
set(gca,'box','on')
set(gca,'fontsize',16)
set(gca,'xticklabel',{'0-5', '3-8', '6-11','9-14','12-17','15-23','18-29','24-36','>36'},'FontSize',12);    

xlabel('Month','fontsize',16)
ylabel('c','fontsize',16)

set(gcf,'unit','centimeters','position',[6 10 16 11])
set(gca,'Position',[.15 .15 .75 .7]);

set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')

xlim([1,9]);    
ylim([0,1]) 

saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/LH','/C_mean_SC_FC_7_network_LH',scan_dir,'.fig'])

    

% Plot the RH
figure
if N_roi==100
    c_RH_Vis=mean(c_mean(51:58,:));
    c_RH_SomMot=mean(c_mean(59:66,:));
    c_RH_DorsAttn=mean(c_mean(67:73,:));
    c_RH_SalVentAttn=mean(c_mean(74:78,:));
    c_RH_Limbic=mean(c_mean(79:80,:));
    c_RH_Cont=mean(c_mean(81:89,:));
    c_RH_Default=mean(c_mean(90:100,:));
elseif N_roi==200
    c_RH_Vis=mean(c_mean(101:115,:));
    c_RH_SomMot=mean(c_mean(116:134,:));
    c_RH_DorsAttn=mean(c_mean(135:147,:));
    c_RH_SalVentAttn=mean(c_mean(148:158,:));
    c_RH_Limbic=mean(c_mean(159:164,:));
    c_RH_Cont=mean(c_mean(165:181,:));
    c_RH_Default=mean(c_mean(182:200,:));
elseif N_roi==300
    c_RH_Vis=mean(c_mean(151:173,:));
    c_RH_SomMot=mean(c_mean(174:201,:));
    c_RH_DorsAttn=mean(c_mean(202:219,:));
    c_RH_SalVentAttn=mean(c_mean(220:237,:));
    c_RH_Limbic=mean(c_mean(238:247,:));
    c_RH_Cont=mean(c_mean(248:270,:));
    c_RH_Default=mean(c_mean(271:300,:));
elseif N_roi==400
    c_RH_Vis=mean(c_mean(201:230,:));
    c_RH_SomMot=mean(c_mean(231:270,:));
    c_RH_DorsAttn=mean(c_mean(271:293,:));
    c_RH_SalVentAttn=mean(c_mean(294:318,:));
    c_RH_Limbic=mean(c_mean(319:331,:));
    c_RH_Cont=mean(c_mean(332:361,:));
    c_RH_Default=mean(c_mean(362:400,:));
end

plot(1:9,c_RH_Vis(1,:),'-r',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','red',...
'MarkerFaceColor','red');
hold on

plot(1:9,c_RH_SomMot(1,:),'-g',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','green',...
'MarkerFaceColor','green');
hold on

plot(1:9,c_RH_DorsAttn(1,:),'-b',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','blue',...
'MarkerFaceColor','blue');
hold on

plot(1:9,c_RH_SalVentAttn(1,:),'-c',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','cyan',...
'MarkerFaceColor','cyan');
hold on

plot(1:9,c_RH_Limbic(1,:),'-m',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','magenta',...
'MarkerFaceColor','magenta');
hold on

plot(1:9,c_RH_Cont(1,:),'y',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','yellow',...
'MarkerFaceColor','yellow');
hold on

plot(1:9,c_RH_Default(1,:),'k',...
'LineWidth',1.2,...
'MarkerSize',7,...
'MarkerEdgeColor','black',...
'MarkerFaceColor','black');
hold on


legend('RH Vis', ...
    'RH SomMot',...
    'RH DorsAttn',...
    'RH SalVentAttn',...
    'RH Limbic',...
    'RH Cont',...
    'RH Default','fontsize', 12,'location','southwest')

title({['ROI ',num2str(N_roi),' RH']},'fontsize',16)
set(gca,'box','on')
set(gca,'fontsize',16)
set(gca,'xticklabel',{'0-5', '3-8', '6-11','9-14','12-17','15-23','18-29','24-36','>36'},'FontSize',12);    

xlabel('Month','fontsize',16)
ylabel('c','fontsize',16)

set(gcf,'unit','centimeters','position',[6 10 16 11])
set(gca,'Position',[.15 .15 .75 .7]);

set(gca, 'linewidth', 1.2, 'fontsize', 16, 'fontname', 'times')

xlim([1,9]);    
ylim([0,1]) 

saveas(gcf,['../','results_SC_strength_FC','/','roi_',num2str(N_roi),'_1_',scan_dir,'/RH','/C_mean_SC_FC_7_network_',scan_dir,'.fig'])








