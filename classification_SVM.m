clear all;
clc;

load 'PDmats/rvelAmp.mat';
pd1 = rvelAmp;
load 'OHmats/rvelAmp.mat';
h1 = rvelAmp;

load 'PDmats/rvelMagn.mat';
pd2 = rvelMagn;
load 'OHmats/rvelMagn.mat';
h2 = rvelMagn;

load 'PDmats/accMagn.mat';
pd3 = accMagn;
load 'OHmats/accMagn.mat';
h3 = accMagn;

load 'PDmats/accSumDiff.mat';
pd4 = accSumDiff;
load 'OHmats/accSumDiff.mat';
h4 = accSumDiff;

tag={'rR','rL','eR','eL'};

rating = [ones(length(pd1),1) ; zeros(length(h1),1)];
rating_cell=num2str(rating);
rating_cell=cellstr(rating_cell);

features_rR = [pd1(:,1) pd2(:,1) pd3(:,1) pd4(:,1) ; h1(:,1) h2(:,1) h3(:,1) h4(:,1)]; %rR
features_rL = [pd1(:,2) pd2(:,2) pd3(:,2) pd4(:,2) ; h1(:,2) h2(:,2) h3(:,2) h4(:,2)]; %rL
features_eR = [pd1(:,3) pd2(:,3) pd3(:,3) pd4(:,3) ; h1(:,3) h2(:,3) h3(:,3) h4(:,3)]; %eR
features_eL = [pd1(:,4) pd2(:,4) pd3(:,4) pd4(:,4) ; h1(:,4) h2(:,4) h3(:,4) h4(:,4)]; %eL

features = features_rR;
% features = features_rL;
% features = features_eR;
% features = features_eL;

svmStruct = svmtrain(features, rating, 'showplot', true);
% SVMModel = fitcsvm(features,rating,'KernelFunction','linear','Standardize',true,'ClassNames',{'1','0'});
groups= svmclassify(svmStruct, features);
test=[groups rating];
% b = TreeBagger(nTrees, features, rating, 'oobvarimp', 'on', 'oobpred', 'on'); 
% [oobPredictions, oobScores] = oobPredict(b);
% [conf classorder] = confusionmat(rating_cell, oobPredictions);
% disp(dataset({conf, classorder{:}}, 'obsnames', classorder));
pause;