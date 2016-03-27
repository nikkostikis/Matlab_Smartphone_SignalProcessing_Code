clear all;
clc;

load 'PDmats/accSumDiff.mat';
pd=accSumDiff;

load 'OHmats/accSumDiff.mat';
h=accSumDiff;

tag={'rR','rL','eR','eL'};

for i=1:4
    ROC_out=roc_old([pd(:,i), ones(length(pd),1); h(:,i), zeros(length(h),1)],0,0.01,1,'accSumDiff',tag{i});
    fnamecell=feval('strcat', 'ROCmats/ROC_out_accSumDiff_', tag(i), '.mat');
    fname=fnamecell{1};
    save(fname,'ROC_out');
%     pause;
end