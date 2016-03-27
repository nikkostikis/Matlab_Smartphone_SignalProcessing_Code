% its eR gives a nice 21-2, 10-1 classification, AUC=0.95257
% its eL gives a whooping 22-1, 11-0 classification, AUC=0.97628
% the SVM based classification is of very low quality even at the aforementioned cases

clear all;
clc;

load 'PDmats/accMagn.mat';
pd=accMagn;
load 'OHmats/accMagn.mat';
h=accMagn;

tag={'rR','rL','eR','eL'};

for i=1:4
    ROC_out=roc_old([pd(:,i), ones(length(pd),1); h(:,i), zeros(length(h),1)],0,0.01,1,'accMagn',tag{i});
    fnamecell=feval('strcat', 'ROCmats/ROC_out_accMagn_', tag(i), '.mat');
    fname=fnamecell{1};
    save(fname,'ROC_out');
%     pause;
end

% rating = [ones(length(pd),1) ; zeros(length(h),1)];
% 
% features_rR = [pd(:,1) ; h(:,1)]; %rR
% features_rL = [pd(:,2) ; h(:,2)]; %rL
% features_eR = [pd(:,3) ; h(:,3)]; %eR
% features_eL = [pd(:,4) ; h(:,4)]; %eL
% 
% % features = features_rR;
% % features = features_rL;
% % features = features_eR;
% features = features_eL;
% 
% svmStruct = svmtrain(features, rating, 'showplot', true);
% % SVMModel = fitcsvm(features,rating,'KernelFunction','linear','Standardize',true,'ClassNames',{'1','0'});
% groups= svmclassify(svmStruct, features);
% test=[groups rating];