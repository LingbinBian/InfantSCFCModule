% Table of subject information (DTI)
% under the directory data_DTI, use the command: find . -name '.DS_Store' -type f -delete

clear
clc

subj_list=dir("../data_DTI/Connectome");

subj=cell(214,2);
for i=1:214
   subj{i,1}=subj_list(i+2).name;
   month_list=dir(['../data_DTI/Connectome/',subj{i,1}]);

   subj{i,2}=month_list(3:end);
end

subj_info=cell(214,2);

c=0;
for i=1:214
    subj_info{i,1}=subj{i,1};

    L=length(subj{i,2});
    month_info=cell(1,L);
    for j=1:L
        month_info{1,j}=subj{i,2}(j).name;
        c=c+1;
    end
    subj_info{i,2}=month_info;

end

save_path=fullfile('subj_info_dti');
save(save_path,'subj_info');






