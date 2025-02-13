% This script saves all the pictures in a single destination file

% Version 1.0
% 21-Aug-2024
% Copyright (c) 2024, Lingbin Bian

clear
clc
close all

% destination file
pic_path='/Users/lingbinbian/Documents/BCP_fMRI_sMRI/figure/roi_100_1_AP/RH';
  
% save test sampling parameters
cd '../results_SC_strength_FC/roi_100_1_AP/RH/1.2';

open('SC_posterior_alpha_AP_1.fig')
saveas(gcf,[pic_path,'/SC_posterior_alpha_AP_1.svg'])
close all
open('SC_posterior_alpha_AP_2.fig')
saveas(gcf,[pic_path,'/SC_posterior_alpha_AP_2.svg'])
close all
open('SC_posterior_alpha_AP_3.fig')
saveas(gcf,[pic_path,'/SC_posterior_alpha_AP_3.svg'])
close all
open('SC_posterior_alpha_AP_4.fig')
saveas(gcf,[pic_path,'/SC_posterior_alpha_AP_4.svg'])
close all
open('SC_posterior_alpha_AP_5.fig')
saveas(gcf,[pic_path,'/SC_posterior_alpha_AP_5.svg'])
close all
open('SC_posterior_alpha_AP_6.fig')
saveas(gcf,[pic_path,'/SC_posterior_alpha_AP_6.svg'])
close all
open('SC_posterior_alpha_AP_7.fig')
saveas(gcf,[pic_path,'/SC_posterior_alpha_AP_7.svg'])
close all
open('SC_posterior_alpha_AP_8.fig')
saveas(gcf,[pic_path,'/SC_posterior_alpha_AP_8.svg'])
close all
open('SC_posterior_alpha_AP_9.fig')
saveas(gcf,[pic_path,'/SC_posterior_alpha_AP_9.svg'])
close all

open('SC_labels_AP1.fig')
saveas(gcf,[pic_path,'/SC_labels_AP1.svg'])
close all
open('SC_labels_AP2.fig')
saveas(gcf,[pic_path,'/SC_labels_AP2.svg'])
close all
open('SC_labels_AP3.fig')
saveas(gcf,[pic_path,'/SC_labels_AP3.svg'])
close all
open('SC_labels_AP4.fig')
saveas(gcf,[pic_path,'/SC_labels_AP4.svg'])
close all
open('SC_labels_AP5.fig')
saveas(gcf,[pic_path,'/SC_labels_AP5.svg'])
close all
open('SC_labels_AP6.fig')
saveas(gcf,[pic_path,'/SC_labels_AP6.svg'])
close all
open('SC_labels_AP7.fig')
saveas(gcf,[pic_path,'/SC_labels_AP7.svg'])
close all
open('SC_labels_AP8.fig')
saveas(gcf,[pic_path,'/SC_labels_AP8.svg'])
close all
open('SC_labels_AP9.fig')
saveas(gcf,[pic_path,'/SC_labels_AP9.svg'])
close all


open('SC_assignment_probability_AP_1.fig')
saveas(gcf,[pic_path,'/SC_assignment_probability_AP_1.svg'])
close all
open('SC_assignment_probability_AP_2.fig')
saveas(gcf,[pic_path,'/SC_assignment_probability_AP_2.svg'])
close all
open('SC_assignment_probability_AP_3.fig')
saveas(gcf,[pic_path,'/SC_assignment_probability_AP_3.svg'])
close all
open('SC_assignment_probability_AP_4.fig')
saveas(gcf,[pic_path,'/SC_assignment_probability_AP_4.svg'])
close all
open('SC_assignment_probability_AP_5.fig')
saveas(gcf,[pic_path,'/SC_assignment_probability_AP_5.svg'])
close all
open('SC_assignment_probability_AP_6.fig')
saveas(gcf,[pic_path,'/SC_assignment_probability_AP_6.svg'])
close all
open('SC_assignment_probability_AP_7.fig')
saveas(gcf,[pic_path,'/SC_assignment_probability_AP_7.svg'])
close all
open('SC_assignment_probability_AP_8.fig')
saveas(gcf,[pic_path,'/SC_assignment_probability_AP_8.svg'])
close all
open('SC_assignment_probability_AP_9.fig')
saveas(gcf,[pic_path,'/SC_assignment_probability_AP_9.svg'])
close all



open('FC_posterior_alpha_AP_1.fig')
saveas(gcf,[pic_path,'/FC_posterior_alpha_AP_1.svg'])
close all
open('FC_posterior_alpha_AP_2.fig')
saveas(gcf,[pic_path,'/FC_posterior_alpha_AP_2.svg'])
close all
open('FC_posterior_alpha_AP_3.fig')
saveas(gcf,[pic_path,'/FC_posterior_alpha_AP_3.svg'])
close all
open('FC_posterior_alpha_AP_4.fig')
saveas(gcf,[pic_path,'/FC_posterior_alpha_AP_4.svg'])
close all
open('FC_posterior_alpha_AP_5.fig')
saveas(gcf,[pic_path,'/FC_posterior_alpha_AP_5.svg'])
close all
open('FC_posterior_alpha_AP_6.fig')
saveas(gcf,[pic_path,'/FC_posterior_alpha_AP_6.svg'])
close all
open('FC_posterior_alpha_AP_7.fig')
saveas(gcf,[pic_path,'/FC_posterior_alpha_AP_7.svg'])
close all
open('FC_posterior_alpha_AP_8.fig')
saveas(gcf,[pic_path,'/FC_posterior_alpha_AP_8.svg'])
close all
open('FC_posterior_alpha_AP_9.fig')
saveas(gcf,[pic_path,'/FC_posterior_alpha_AP_9.svg'])
close all



open('FC_labels_AP1.fig')
saveas(gcf,[pic_path,'/FC_labels_AP1.svg'])
close all
open('FC_labels_AP2.fig')
saveas(gcf,[pic_path,'/FC_labels_AP2.svg'])
close all
open('FC_labels_AP3.fig')
saveas(gcf,[pic_path,'/FC_labels_AP3.svg'])
close all
open('FC_labels_AP4.fig')
saveas(gcf,[pic_path,'/FC_labels_AP4.svg'])
close all
open('FC_labels_AP5.fig')
saveas(gcf,[pic_path,'/FC_labels_AP5.svg'])
close all
open('FC_labels_AP6.fig')
saveas(gcf,[pic_path,'/FC_labels_AP6.svg'])
close all
open('FC_labels_AP7.fig')
saveas(gcf,[pic_path,'/FC_labels_AP7.svg'])
close all
open('FC_labels_AP8.fig')
saveas(gcf,[pic_path,'/FC_labels_AP8.svg'])
close all
open('FC_labels_AP9.fig')
saveas(gcf,[pic_path,'/FC_labels_AP9.svg'])
close all



open('FC_assignment_probability_AP_1.fig')
saveas(gcf,[pic_path,'/FC_assignment_probability_AP_1.svg'])
close all
open('FC_assignment_probability_AP_2.fig')
saveas(gcf,[pic_path,'/FC_assignment_probability_AP_2.svg'])
close all
open('FC_assignment_probability_AP_3.fig')
saveas(gcf,[pic_path,'/FC_assignment_probability_AP_3.svg'])
close all
open('FC_assignment_probability_AP_4.fig')
saveas(gcf,[pic_path,'/FC_assignment_probability_AP_4.svg'])
close all
open('FC_assignment_probability_AP_5.fig')
saveas(gcf,[pic_path,'/FC_assignment_probability_AP_5.svg'])
close all
open('FC_assignment_probability_AP_6.fig')
saveas(gcf,[pic_path,'/FC_assignment_probability_AP_6.svg'])
close all
open('FC_assignment_probability_AP_7.fig')
saveas(gcf,[pic_path,'/FC_assignment_probability_AP_7.svg'])
close all
open('FC_assignment_probability_AP_8.fig')
saveas(gcf,[pic_path,'/FC_assignment_probability_AP_8.svg'])
close all
open('FC_assignment_probability_AP_9.fig')
saveas(gcf,[pic_path,'/FC_assignment_probability_AP_9.svg'])
close all









