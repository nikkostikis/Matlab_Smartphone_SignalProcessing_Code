% its eL gives a nice 19-3, 10-1 classification
clear all;
clc;

load 'PDmats/rvelAmp.mat';
pd=rvelAmp;

load 'OHmats/rvelAmp.mat';
h=rvelAmp;

tag={'rR','rL','eR','eL'};

for i=1:4
    ROC_out=roc_old([pd(:,i), ones(length(pd),1); h(:,i), zeros(length(h),1)],0,0.01,1,'rvelAmp',tag{i});
    fnamecell=feval('strcat', 'ROCmats/ROC_out_rvelAmp_', tag(i), '.mat');
    fname=fnamecell{1};
    save(fname,'ROC_out');
%     pause;
end