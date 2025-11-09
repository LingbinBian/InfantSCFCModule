% MANIP Divide DTI datasets into the categories of female (F) and male (M)
% 
% 
% Version 1.0
% 25-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc
close all

% subj_info 
load('subj_info_dti_gender.mat');

N_scan = length(subj_info);


for i = 1:N_scan
    subjID = subj_info{i,1};
    gender = subj_info{i,3};
    site   = subj_info{i,4};

    % sourse file ../data_DTI/Connectome/MNBCP105040
    srcFolderName = [site, 'BCP', subjID];
    src = fullfile('..', 'data_DTI', 'Connectome', srcFolderName);

   
    if strcmp(gender, 'F')
        dstRoot = fullfile('..', 'data_DTI_F', 'Connectome');
    elseif strcmp(gender, 'M')
        dstRoot = fullfile('..', 'data_DTI_M', 'Connectome');
    else

        continue;
    end

    dst = fullfile(dstRoot, srcFolderName);
    if ~exist(dstRoot, 'dir')
        mkdir(dstRoot);
    end


    if exist(src, 'dir')
       
        status = copyfile(src, dst);

        if status
            fprintf('copied: %s → %s\n', src, dst);
            fprintf(fid, 'successful: %s → %s\n', src, dst);
        else
            warning('fail: %s', src);
            fprintf(fid, 'fail: %s\n', src);
        end
    else
        warning('not existing: %s', src);
        fprintf(fid, 'not existing: %s\n', src);
    end
end

