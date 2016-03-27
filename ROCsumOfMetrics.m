clear all;
clc;

load 'PDmats/rvelAmp.mat';
pd = rvelAmp;
load 'OHmats/rvelAmp.mat';
h = rvelAmp;


load 'PDmats/rvelMagn.mat';
pd = pd + rvelMagn;
load 'OHmats/rvelMagn.mat';
h = h + rvelMagn;


load 'PDmats/accMagn.mat';
pd = pd + accMagn;
load 'OHmats/accMagn.mat';
h = h + accMagn;


load 'PDmats/accSumDiff.mat';
pd = pd + accSumDiff;
load 'OHmats/accSumDiff.mat';
h = h + accSumDiff;

tag = {'rR','rL','eR','eL'};

for i=1:4
    ROC_out=roc_old([pd(:,i), ones(length(pd),1); h(:,i), zeros(length(h),1)],0,0.01,1,'SumOfMetrics',tag{i});
    fnamecell=feval('strcat', 'ROCmats/ROC_out_SumOfMetrics', tag(i), '.mat');
    fname=fnamecell{1};
    save(fname,'ROC_out');
end