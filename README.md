Robust probabilistic measurement of structural-functional module consistency in infant brain development

Version 1.0
23-Oct-2025
Copyright (c) 2025, Lingbin Bian
---------------------------------------------------------------------------

Under the directory Script_control:

1.Manipulate the BOLD time series of the subjects

copy_ap_pa.sh
MANIP_signal_txt2mat.m

The .txt format of the BOLD time series is store under the directory data_fMRI (e.g. Schaefer_100Parcels_7Networks)
Use copy_ap_pa.sh to divide the data into AP and PA categories (e.g. Schaefer_100Parcels_7Networks_AP and Schaefer_100Parcels_7Networks_PA).
Use the MANIP_signal_txt2mat.m to convert the .txt format of BOLD time series to .mat format, and under the directories such as 100ROI_AP and 100ROI_AP...
---------------------------------------------------------------------------

2.Create tables of fMRI (AP and PA) containing the information about subject id, age, gender, and site

MANIP_subj_info_MRI.m

the created results: subj_info_ap.mat and subj_info_ap.mat for AP and PA respectively
---------------------------------------------------------------------------
3.Construct functional connectivity

MANIP_roi2fc.m

---------------------------------------------------------------------------
4.Create tables of DTI containing the information about subject id, age, gender, and site
NOTE: before using MANIP_subj_info_dti.m, under the directory data_DTI, use the command: find . -name '.DS_Store' -type f -delete

MANIP_subj_info_dti.m

the created results:subj_info_dti.mat

Then, convert the subj_info_dti.mat to a table named subj_info_dti_long.tsv by using

MANIP_transfer_dti_info.m

DTI (structural connectivity) is stored under the directory data_DTI
---------------------------------------------------------------------------
5.Plot the longitudinal rs-fMRI samples with AP and PA

DEMO_longi_plot_fmri.m
---------------------------------------------------------------------------
6.Plot the longitudinal DTI samples versus rs-fMRI (same number of samples of AP and PA in DTI)

DEMO_longi_fmri_vs_dti.m
---------------------------------------------------------------------------
7.Plot the histogram of rs-fMRI and DTI samples

DEMO_age_histogram.m
---------------------------------------------------------------------------
8.Individual-level modelling of functional connectivity using modularity

MANIP_individual_model_fMRI.m
---------------------------------------------------------------------------
9.Individual-level modelling of structural connectivity using modularity

MANIP_individual_model_dti.m
---------------------------------------------------------------------------
10.Numer of modules versus the modularity resolution

DEMO_module_number.m
---------------------------------------------------------------------------
11.Calculate structural-functional consistency

DEMO_struc_func_consistency.m
---------------------------------------------------------------------------
12.Averaged structural-functional consistency across ROIs within each of 7 typical brain networks

MANIP_average_C.m
---------------------------------------------------------------------------
10.Structural-functional consistency versus the modularity resolution

MANIP_c_gamma.m
---------------------------------------------------------------------------
11.Calculate DVARS from ROI-wise time series to evaluate the motion

MANIP_DVARS.m
---------------------------------------------------------------------------
12.categorize DVARS, age, gender, and site into different age ranges

MANIP_individual_DVARS.m
---------------------------------------------------------------------------
13. Regression for DVARS

MANIP_DVARS_regression_real.m
---------------------------------------------------------------------------
14. Data stratification with respect to gender

fMRI:
MANIP_divide_fMRI_F_M.m
MANIP_subj_info_fMRI_F_M.m

DTI:
MANIP_divide_DTI_F_M.m
MANIP_subj_info_dti.m
MANIP_subj_info_dti_gender.m

15.Correlation analysis for structural-functional consistency (c vs age)

DEMO_correlation_c_age.m

16. Comparision between structural-functional consistency and the conventional structural-functional coupling (using Pearson's correlation and Spearman correlation)

Group averaged structural connectivity
MANIP_SC_average.m

Group averaged functional connectivity
MANIP_FC_average.m

