
% Some are used for training, others for prediction
% Four features - each metric
clear all;
% clc;
close all;

OH = 20;
PD =26;
sizetrain = 12;
pOH = OH - sizetrain;
pPD = PD - sizetrain;

% load wavDetCoefsPower_All which is 46x32:
% 20/OH + 26/PD x (4/HM x 8 DWT levels)
% HM goes like: EL/ER/RL/RR
load 'wavDetCoefsPower_All.mat';
createTags_HM_Level;

[m n] = size(wavDetCoefsPower_All);

% random indices to remove for prediction
dataOH = wavDetCoefsPower_All(1:OH, :);
randpermOH = randperm(OH);
trainIndOH = randpermOH(1:sizetrain);
predIndOH = randpermOH(sizetrain+1:end);
% slice
trainOH = dataOH(trainIndOH, :);
predOH = dataOH(predIndOH, :);

dataPD = wavDetCoefsPower_All(OH+1:end, :);
randpermPD = randperm(PD);
trainIndPD = randpermPD(1:sizetrain);
predIndPD = randpermPD(sizetrain+1:end);
% slice
trainPD = dataPD(trainIndPD, :);
predPD = dataPD(predIndPD, :);

train = [trainOH; trainPD];
ratingtrain = [zeros(sizetrain,1) ; ones(sizetrain,1)];
rating_celltrain=num2str(ratingtrain);
rating_celltrain=cellstr(rating_celltrain);

pred = [predOH; predPD];
ratingpred = [zeros(pOH,1) ; ones(pPD,1)];
rating_cellpred=num2str(ratingpred);
rating_cellpred=cellstr(rating_cellpred);

% keyboard;


nTrees = 700;


% b = TreeBagger(nTrees, features, rating, 'oobvarimp', 'on', 'oobpred', 'on');
b = TreeBagger(nTrees, train, ratingtrain, 'Method' , 'classification', 'oobpred', 'on', 'oobvarimp', 'on');
[Yfit, Sfit] = b.predict(pred);
[conf classorder] = confusionmat(rating_cellpred, Yfit);
disp(dataset({conf, classorder{:}}, 'obsnames', classorder));
TpTn = diag(conf);
disp({'TN:', num2str(TpTn(1)/pOH), 'TP:', num2str(TpTn(2)/pPD)});

figure(100)
plot(oobError(b));
xlabel 'Number of Grown Trees';
ylabel 'Out-of-Bag Mean Squared Error';

figure(10);
hold on;
% bar(abs(b.OOBPermutedVarDeltaError));
OOBPVDE = b.OOBPermutedVarDeltaError;
positiveFeatures = find(OOBPVDE >= 0);
negativeFeatures = find(OOBPVDE < 0);
% plot positive blue
OOBPVDE_pos = OOBPVDE;
OOBPVDE_pos(negativeFeatures) = 0;
bar(OOBPVDE_pos, 'b');

OOBPVDE_neg = OOBPVDE;
OOBPVDE_neg(positiveFeatures) = 0;
bar(abs(OOBPVDE_neg), 'r');
hold off;

xlabel 'Feature Number' ;
ylabel 'Out-of-Bag Feature Importance';

idxvar = find(abs(b.OOBPermutedVarDeltaError)>0.2)
labels(idxvar)