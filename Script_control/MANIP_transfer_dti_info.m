% MANIP transfer dti information

%
% Version 1.0
% 11-Oct-2025
% Copyright (c) 2025, Lingbin Bian

clear
clc
close all


gender=2; % 0: all, 1: female, 2: male
% load the dti data
switch gender
    case 0
        load('subj_info_dti.mat');  % subj_info: {SubjectID, AgeInfo}
    case 1
        load('subj_info_dti_F.mat');  % subj_info: {SubjectID, AgeInfo}
        subj_info=subj_info_dti_F;
    otherwise
        load('subj_info_dti_M.mat');  % subj_info: {SubjectID, AgeInfo}
        subj_info=subj_info_dti_M;
end
        

% initialization
Subject = {};
AgeMonth = [];
Site = {};

% for all subjects
for i = 1:size(subj_info, 1)
    subj_full = subj_info{i, 1};  % e.g. 'MNBCP116056' or 'NCBCP011228'
    
    % extract subject ID
    if startsWith(subj_full, 'MNBCP')
        site = 'MN';
        subj_id = erase(subj_full, 'MNBCP'); % remove MNBCP 
    elseif startsWith(subj_full, 'NCBCP')
        site = 'NC';
        subj_id = erase(subj_full, 'NCBCP'); % remove NCBCP
    else
        site = 'UNK'; % unknown
        subj_id = subj_full; % retain ID
    end

    age_info = subj_info{i, 2};

    % age information
    if iscell(age_info)
        for j = 1:numel(age_info)
            ageNum = parseAge(age_info{j});
            if ~isnan(ageNum)
                Subject{end+1, 1} = subj_id;
                AgeMonth(end+1, 1) = ageNum;
                Site{end+1, 1} = site;
            end
        end
    else
        ageNum = parseAge(age_info);
        if ~isnan(ageNum)
            Subject{end+1, 1} = subj_id;
            AgeMonth(end+1, 1) = ageNum;
            Site{end+1, 1} = site;
        end
    end
end

% create table
T = table(Subject, AgeMonth, Site);

T.Site = categorical(T.Site, {'MN', 'NC', 'UNK'}, 'Ordinal', true);

% sort according to Site
[~, sortIndex] = sort(T.Site);
T = T(sortIndex, :);  
  

% save as TSV
switch gender
    case 0
        writetable(T, 'subj_info_dti_long.tsv', 'FileType', 'text', 'Delimiter', '\t');
    case 1
        writetable(T, 'subj_info_dti_long_F.tsv', 'FileType', 'text', 'Delimiter', '\t');
    otherwise
        writetable(T, 'subj_info_dti_long_M.tsv', 'FileType', 'text', 'Delimiter', '\t');
end


% -------------------------------------------------------------------------
% nested function
function ageNum = parseAge(str)
    str = string(str);
    if contains(str, 'mo')
        ageNum = str2double(erase(str, 'mo'));
    elseif contains(str, 'wk')
        ageNum = str2double(erase(str, 'wk')) / 4;
    elseif contains(str, 'yr')
        ageNum = str2double(erase(str, 'yr')) * 12;
    else
        ageNum = NaN;  % unable to analyze age
    end
end