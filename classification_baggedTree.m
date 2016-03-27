%%
% All are used for training and prediction
% Four features - each metric

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

nTrees = 500;

features_rR = [pd1(:,1) pd2(:,1) pd3(:,1) pd4(:,1) ; h1(:,1) h2(:,1) h3(:,1) h4(:,1)]; %rR
features_rL = [pd1(:,2) pd2(:,2) pd3(:,2) pd4(:,2) ; h1(:,2) h2(:,2) h3(:,2) h4(:,2)]; %rL
features_eR = [pd1(:,3) pd2(:,3) pd3(:,3) pd4(:,3) ; h1(:,3) h2(:,3) h3(:,3) h4(:,3)]; %eR
features_eL = [pd1(:,4) pd2(:,4) pd3(:,4) pd4(:,4) ; h1(:,4) h2(:,4) h3(:,4) h4(:,4)]; %eL

% features = features_rR;
% features = features_rL;
% features = features_eR;
features = features_eL;

% b = TreeBagger(nTrees, features, rating, 'oobvarimp', 'on', 'oobpred', 'on');
b = TreeBagger(nTrees, features, rating, 'Method' , 'classification', 'oobpred', 'on', 'oobvarimp', 'on');
[Yfit, Sfit] = b.oobPredict;
[conf classorder] = confusionmat(rating_cell, Yfit);
disp(dataset({conf, classorder{:}}, 'obsnames', classorder));

[X,Y,T,AUC]=perfcurve(rating_cell, Sfit(:,1), classorder{2});
plot(X,Y);
pause;

% mapRatings = ordinal(rating_cell, [], b.ClassNames);
% mapRatings = double(mapRatings);

%%
% Some are used for training, others for prediction
% Four features - each metric
clear all;
clc;

sizetrain = 15;

load 'PDmats/rvelAmp.mat';
pd1train = rvelAmp(1:sizetrain,:);
pd1pred = rvelAmp(sizetrain+1:23,:);
load 'OHmats/rvelAmp.mat';
h1train = rvelAmp(1:sizetrain,:);
h1pred = rvelAmp(sizetrain+1:20,:);

load 'PDmats/rvelMagn.mat';
pd2train = rvelMagn(1:sizetrain,:);
pd2pred = rvelMagn(sizetrain+1:23,:);
load 'OHmats/rvelMagn.mat';
h2train = rvelMagn(1:sizetrain,:);
h2pred = rvelMagn(sizetrain+1:20,:);

load 'PDmats/accMagn.mat';
pd3train = accMagn(1:sizetrain,:);
pd3pred = accMagn(sizetrain+1:23,:);
load 'OHmats/accMagn.mat';
h3train = accMagn(1:sizetrain,:);
h3pred = accMagn(sizetrain+1:20,:);

load 'PDmats/accSumDiff.mat';
pd4train = accSumDiff(1:sizetrain,:);
pd4pred = accSumDiff(sizetrain+1:23,:);
load 'OHmats/accSumDiff.mat';
h4train = accSumDiff(1:sizetrain,:);
h4pred = accSumDiff(sizetrain+1:20,:);

tag={'rR','rL','eR','eL'};

nTrees = 50;

features_rR = [pd1train(:,1) pd2train(:,1) pd3train(:,1) pd4train(:,1) ; h1train(:,1) h2train(:,1) h3train(:,1) h4train(:,1)]; %rR
features_rL = [pd1train(:,2) pd2train(:,2) pd3train(:,2) pd4train(:,2) ; h1train(:,2) h2train(:,2) h3train(:,2) h4train(:,2)]; %rL
features_eR = [pd1train(:,3) pd2train(:,3) pd3train(:,3) pd4train(:,3) ; h1train(:,3) h2train(:,3) h3train(:,3) h4train(:,3)]; %eR
features_eL = [pd1train(:,4) pd2train(:,4) pd3train(:,4) pd4train(:,4) ; h1train(:,4) h2train(:,4) h3train(:,4) h4train(:,4)]; %eL

% features = features_rR;
features = features_rL;
% features = features_eR;
% features = features_eL;

predict_rR = [pd1pred(:,1) pd2pred(:,1) pd3pred(:,1) pd4pred(:,1) ; h1pred(:,1) h2pred(:,1) h3pred(:,1) h4pred(:,1)]; %rR
predict_rL = [pd1pred(:,2) pd2pred(:,2) pd3pred(:,2) pd4pred(:,2) ; h1pred(:,2) h2pred(:,2) h3pred(:,2) h4pred(:,2)]; %rL
predict_eR = [pd1pred(:,3) pd2pred(:,3) pd3pred(:,3) pd4pred(:,3) ; h1pred(:,3) h2pred(:,3) h3pred(:,3) h4pred(:,3)]; %eR
predict_eL = [pd1pred(:,4) pd2pred(:,4) pd3pred(:,4) pd4pred(:,4) ; h1pred(:,4) h2pred(:,4) h3pred(:,4) h4pred(:,4)]; %eL

% predict_vec = predict_rR;
predict_vec = predict_rL;
% predict_vec = predict_eR;
% predict_vec = predict_eL;

ratingtrain = [ones(length(pd1train),1) ; zeros(length(h1train),1)];
rating_celltrain=num2str(ratingtrain);
rating_celltrain=cellstr(rating_celltrain);

ratingpred = [ones(size(pd1pred),1) ; zeros(size(h1pred),1)];
rating_cellpred=num2str(ratingpred);
rating_cellpred=cellstr(rating_cellpred);

% b = TreeBagger(nTrees, features, rating, 'oobvarimp', 'on', 'oobpred', 'on');
b = TreeBagger(nTrees, features, ratingtrain, 'Method' , 'classification', 'oobpred', 'on', 'oobvarimp', 'on');
[Yfit, Sfit] = b.predict(predict_vec);
[conf classorder] = confusionmat(rating_cellpred, Yfit);
disp(dataset({conf, classorder{:}}, 'obsnames', classorder));

% figure
% plot(oobError(b));
% xlabel 'Number of Grown Trees';
% ylabel 'Out-of-Bag Mean Squared Error';

figure
bar(b.OOBPermutedVarDeltaError);
xlabel 'Feature Number' ;
ylabel 'Out-of-Bag Feature Importance';
idxvar = find(b.OOBPermutedVarDeltaError>0.5)


%%
% All metrics and all postures are used as features
% Some are used for training, others for prediction
clear all;
clc;

sizetrain = 17;

load 'PDmats/rvelAmp.mat';
pd1train = rvelAmp(1:sizetrain,:);
pd1pred = rvelAmp(sizetrain+1:23,:);
load 'OHmats/rvelAmp.mat';
h1train = rvelAmp(1:sizetrain,:);
h1pred = rvelAmp(sizetrain+1:20,:);

load 'PDmats/rvelMagn.mat';
pd2train = rvelMagn(1:sizetrain,:);
pd2pred = rvelMagn( sizetrain+1:23,:);
load 'OHmats/rvelMagn.mat';
h2train = rvelMagn(1:sizetrain,:);
h2pred = rvelMagn(sizetrain+1:20,:);

load 'PDmats/accMagn.mat';
pd3train = accMagn(1:sizetrain,:);
pd3pred = accMagn(sizetrain+1:23,:);
load 'OHmats/accMagn.mat';
h3train = accMagn(1:sizetrain,:);
h3pred = accMagn(sizetrain+1:20,:);

load 'PDmats/accSumDiff.mat';
pd4train = accSumDiff(1:sizetrain,:);
pd4pred = accSumDiff(sizetrain+1:23,:);
load 'OHmats/accSumDiff.mat';
h4train = accSumDiff(1:sizetrain,:);
h4pred = accSumDiff(sizetrain+1:20,:);

tag={'rR','rL','eR','eL'};

nTrees = 1000;

% features matrix is [2Xsizetrain x 16] with columns:
% rvelAmp_rR rvelAmp_rL rvelAmp_eR rvelAmp_eL rvelMagnX4 accMagnX4 accSumDiffX4
features = [pd1train(:,1) pd1train(:,2) pd1train(:,3) pd1train(:,4)...
    pd2train(:,1) pd2train(:,2) pd2train(:,3) pd2train(:,4)...
    pd3train(:,1) pd3train(:,2) pd3train(:,3) pd3train(:,4)...
    pd4train(:,1) pd4train(:,2) pd4train(:,3) pd4train(:,4);...
    h1train(:,1) h1train(:,2) h1train(:,3) h1train(:,4)...
    h2train(:,1) h2train(:,2) h2train(:,3) h2train(:,4)...
    h3train(:,1) h3train(:,2) h3train(:,3) h3train(:,4)...
    h4train(:,1) h4train(:,2) h4train(:,3) h4train(:,4)];

predict_vec = [pd1pred(:,1) pd1pred(:,2) pd1pred(:,3) pd1pred(:,4)...
    pd2pred(:,1) pd2pred(:,2) pd2pred(:,3) pd2pred(:,4)...
    pd3pred(:,1) pd3pred(:,2) pd3pred(:,3) pd3pred(:,4)...
    pd4pred(:,1) pd4pred(:,2) pd4pred(:,3) pd4pred(:,4);...
    h1pred(:,1) h1pred(:,2) h1pred(:,3) h1pred(:,4)...
    h2pred(:,1) h2pred(:,2) h2pred(:,3) h2pred(:,4)...
    h3pred(:,1) h3pred(:,2) h3pred(:,3) h3pred(:,4)...
    h4pred(:,1) h4pred(:,2) h4pred(:,3) h4pred(:,4)];

ratingtrain = [ones(length(pd1train),1) ; zeros(length(h1train),1)];
rating_celltrain=num2str(ratingtrain);
rating_celltrain=cellstr(rating_celltrain);

ratingpred = [ones(size(pd1pred),1) ; zeros(size(h1pred),1)];
rating_cellpred=num2str(ratingpred);
rating_cellpred=cellstr(rating_cellpred);

b = TreeBagger(nTrees, features, ratingtrain, 'Method' , 'classification', 'oobpred', 'on', 'oobvarimp', 'on');
[Yfit, Sfit] = b.predict(predict_vec);
[conf classorder] = confusionmat(rating_cellpred, Yfit);
disp(dataset({conf, classorder{:}}, 'obsnames', classorder));

% figure
% plot(oobError(b));
% xlabel 'Number of Grown Trees';
% ylabel 'Out-of-Bag Mean Squared Error';

figure
bar(b.OOBPermutedVarDeltaError);
xlabel 'Feature Number' ;
ylabel 'Out-of-Bag Feature Importance';
idxvar = find(b.OOBPermutedVarDeltaError>0.3)


%%
% All metrics and all postures are used as features
% All training and all prediction
clear all;
clc;



load 'PDmats/rvelAmp.mat';
pd1train = rvelAmp;
pd1pred = rvelAmp;
load 'OHmats/rvelAmp.mat';
h1train = rvelAmp;
h1pred = rvelAmp;

load 'PDmats/rvelMagn.mat';
pd2train = rvelMagn;
pd2pred = rvelMagn;
load 'OHmats/rvelMagn.mat';
h2train = rvelMagn;
h2pred = rvelMagn;

load 'PDmats/accMagn.mat';
pd3train = accMagn;
pd3pred = accMagn;
load 'OHmats/accMagn.mat';
h3train = accMagn;
h3pred = accMagn;

load 'PDmats/accSumDiff.mat';
pd4train = accSumDiff;
pd4pred = accSumDiff;
load 'OHmats/accSumDiff.mat';
h4train = accSumDiff;
h4pred = accSumDiff;

tag={'rR','rL','eR','eL'};

nTrees = 500;

% features matrix is [2Xsizetrain x 16] with columns:
% rvelAmp_rR rvelAmp_rL rvelAmp_eR rvelAmp_eL rvelMagnX4 accMagnX4 accSumDiffX4
features = [pd1train(:,1) pd1train(:,2) pd1train(:,3) pd1train(:,4)...
    pd2train(:,1) pd2train(:,2) pd2train(:,3) pd2train(:,4)...
    pd3train(:,1) pd3train(:,2) pd3train(:,3) pd3train(:,4)...
    pd4train(:,1) pd4train(:,2) pd4train(:,3) pd4train(:,4);...
    h1train(:,1) h1train(:,2) h1train(:,3) h1train(:,4)...
    h2train(:,1) h2train(:,2) h2train(:,3) h2train(:,4)...
    h3train(:,1) h3train(:,2) h3train(:,3) h3train(:,4)...
    h4train(:,1) h4train(:,2) h4train(:,3) h4train(:,4)];

predict_vec = [pd1pred(:,1) pd1pred(:,2) pd1pred(:,3) pd1pred(:,4)...
    pd2pred(:,1) pd2pred(:,2) pd2pred(:,3) pd2pred(:,4)...
    pd3pred(:,1) pd3pred(:,2) pd3pred(:,3) pd3pred(:,4)...
    pd4pred(:,1) pd4pred(:,2) pd4pred(:,3) pd4pred(:,4);...
    h1pred(:,1) h1pred(:,2) h1pred(:,3) h1pred(:,4)...
    h2pred(:,1) h2pred(:,2) h2pred(:,3) h2pred(:,4)...
    h3pred(:,1) h3pred(:,2) h3pred(:,3) h3pred(:,4)...
    h4pred(:,1) h4pred(:,2) h4pred(:,3) h4pred(:,4)];

ratingtrain = [ones(length(pd1train),1) ; zeros(length(h1train),1)];
rating_celltrain=num2str(ratingtrain);
rating_celltrain=cellstr(rating_celltrain);

ratingpred = [ones(size(pd1pred),1) ; zeros(size(h1pred),1)];
rating_cellpred=num2str(ratingpred);
rating_cellpred=cellstr(rating_cellpred);

b = TreeBagger(nTrees, features, ratingtrain, 'Method' , 'classification', 'oobpred', 'on', 'oobvarimp', 'on');
[Yfit, Sfit] = b.predict(predict_vec);
[conf classorder] = confusionmat(rating_cellpred, Yfit);
disp(dataset({conf, classorder{:}}, 'obsnames', classorder));
% 
% [X,Y,T,AUC]=perfcurve(rating_cellpred, Sfit(:,1), classorder{2});
% figure(1);
% plot(X,Y);


figure(2);
bar(b.OOBPermutedVarDeltaError);
xlabel 'Feature Number' ;
ylabel 'Out-of-Bag Feature Importance';
idxvar = find(b.OOBPermutedVarDeltaError>0.4)


%%
% Minimized metrics and postures - only 1 2 3 4 6
% All training and all prediction
clear all;
clc;


load 'PDmats/rvelAmp.mat';
pd1train = rvelAmp;
pd1pred = rvelAmp;
load 'OHmats/rvelAmp.mat';
h1train = rvelAmp;
h1pred = rvelAmp;

load 'PDmats/rvelMagn.mat';
pd2train = rvelMagn;
pd2pred = rvelMagn;
load 'OHmats/rvelMagn.mat';
h2train = rvelMagn;
h2pred = rvelMagn;

load 'PDmats/accMagn.mat';
pd3train = accMagn;
pd3pred = accMagn;
load 'OHmats/accMagn.mat';
h3train = accMagn;
h3pred = accMagn;

load 'PDmats/accSumDiff.mat';
pd4train = accSumDiff;
pd4pred = accSumDiff;
load 'OHmats/accSumDiff.mat';
h4train = accSumDiff;
h4pred = accSumDiff;

tag={'rR','rL','eR','eL'};

nTrees = 500;

% features matrix is [2Xsizetrain x 16] with columns:
% rvelAmp_rR rvelAmp_rL rvelAmp_eR rvelAmp_eL rvelMagnX4 accMagnX4 accSumDiffX4
features = [pd1train(:,1) pd1train(:,2) pd1train(:,3) pd1train(:,4)...
    pd2train(:,1) pd2train(:,2) pd2train(:,3) pd2train(:,4)...
    pd3train(:,1) pd3train(:,2) pd3train(:,3) pd3train(:,4)...
    pd4train(:,1) pd4train(:,2) pd4train(:,3) pd4train(:,4);...
    h1train(:,1) h1train(:,2) h1train(:,3) h1train(:,4)...
    h2train(:,1) h2train(:,2) h2train(:,3) h2train(:,4)...
    h3train(:,1) h3train(:,2) h3train(:,3) h3train(:,4)...
    h4train(:,1) h4train(:,2) h4train(:,3) h4train(:,4)];
% 
% predict_vec = [pd1pred(:,1) pd1pred(:,2) pd1pred(:,3) pd1pred(:,4)...
%     pd2pred(:,1) pd2pred(:,2) pd2pred(:,3) pd2pred(:,4)...
%     pd3pred(:,1) pd3pred(:,2) pd3pred(:,3) pd3pred(:,4)...
%     pd4pred(:,1) pd4pred(:,2) pd4pred(:,3) pd4pred(:,4);...
%     h1pred(:,1) h1pred(:,2) h1pred(:,3) h1pred(:,4)...
%     h2pred(:,1) h2pred(:,2) h2pred(:,3) h2pred(:,4)...
%     h3pred(:,1) h3pred(:,2) h3pred(:,3) h3pred(:,4)...
%     h4pred(:,1) h4pred(:,2) h4pred(:,3) h4pred(:,4)];

ratingtrain = [ones(length(pd1train),1) ; zeros(length(h1train),1)];
rating_celltrain=num2str(ratingtrain);
rating_celltrain=cellstr(rating_celltrain);
% 
% ratingpred = [ones(size(pd1pred),1) ; zeros(size(h1pred),1)];
% rating_cellpred=num2str(ratingpred);
% rating_cellpred=cellstr(rating_cellpred);
% for i=1:16
%     i
%     featuresi = features(:,i);
% 
%     b = TreeBagger(nTrees, featuresi, ratingtrain, 'Method' , 'classification', 'oobpred', 'on', 'oobvarimp', 'on');
% % [Yfit, Sfit] = b.predict(predict_vec);
%     [Yfit, Sfit] = oobPredict(b);
%     [conf classorder] = confusionmat(rating_celltrain, Yfit);
%     disp(dataset({conf, classorder{:}}, 'obsnames', classorder));
% end

featuresi = features(:,[1 2 4 6]);
X=zeros(50,20);
Y=zeros(50,20);
T=zeros(50,20);
opt=zeros(20,2);
for j=1:20
    j
    b = TreeBagger(nTrees, featuresi, ratingtrain, 'Method' , 'classification', 'oobpred', 'on', 'oobvarimp', 'on');
    % [Yfit, Sfit] = b.predict(predict_vec);
    [Yfit, Sfit] = oobPredict(b);
    [conf classorder] = confusionmat(rating_celltrain, Yfit);
    disp(dataset({conf, classorder{:}}, 'obsnames', classorder));
    [XX,YY,TT,AUC,optrocpt]=perfcurve(rating_celltrain, Sfit(:,1), classorder{2});
    jj=length(XX);
    X(1:jj,j)=XX;
    Y(1:jj,j)=YY;
    T(1:jj,j)=TT;
    opt(j,:)=optrocpt;
    AUC
end



% 
% [X,Y,T,AUC]=perfcurve(rating_celltrain, Sfit(:,1), classorder{2});
% figure(1);
% plot(X,Y);
% 
% 
% figure(2);
% bar(b.OOBPermutedVarDeltaError);
% xlabel 'Feature Number' ;
% ylabel 'Out-of-Bag Feature Importance';
% idxvar = find(b.OOBPermutedVarDeltaError>0.4)
