
% Some are used for training, others for prediction
% Four features - each metric
clear all;
% clc;
close all;

% load wavDetCoefsPower_All which is 46x32:
% 20/OH + 26/PD x (4/HM x 8 DWT levels)
% HM goes like: EL/ER/RL/RR
load 'wavDetCoefsPower_All.mat';
createTags_HM_Level;

[m n] = size(wavDetCoefsPower_All);

OH = 20;
PD =26;
% if sizetrain == OH||PD all for train and all for prediction
sizetrainOH = OH
sizetrainPD = PD
pOH = OH - sizetrainOH;
pPD = PD - sizetrainPD;
pOH = OH;
pPD = PD;


% random indices to remove for training & prediction
dataOH = wavDetCoefsPower_All(1:OH, :);
randpermOH = randperm(OH);
trainIndOH = randpermOH(1:sizetrainOH);
% slice
trainOH = dataOH(trainIndOH, :);

dataPD = wavDetCoefsPower_All(OH+1:end, :);
randpermPD = randperm(PD);
trainIndPD = randpermPD(1:sizetrainPD);
% slice
trainPD = dataPD(trainIndPD, :);

% setup training array
train = [trainOH; trainPD];
ratingtrain = [zeros(sizetrainOH,1) ; ones(sizetrainPD,1)];
rating_celltrain=num2str(ratingtrain);
rating_celltrain=cellstr(rating_celltrain);


% setup prediction array
if (sizetrainOH~=OH && sizetrainPD~=PD)
    predIndOH = randpermOH(sizetrainOH+1:end);
    predOH = dataOH(predIndOH, :);
    predIndPD = randpermPD(sizetrainPD+1:end);
    predPD = dataPD(predIndPD, :);
    pred = [predOH; predPD];
    ratingpred = [zeros(pOH,1) ; ones(pPD,1)];
    rating_cellpred=num2str(ratingpred);
    rating_cellpred=cellstr(rating_cellpred);
elseif ( (sizetrainOH~=OH && sizetrainPD==PD) || ...
        (sizetrainOH==OH && sizetrainPD~=PD) )
    disp('Each class must have training and prediction instances');
else
    pred = train;
    ratingpred = [zeros(sizetrainOH,1) ; ones(sizetrainPD,1)];
    rating_cellpred=num2str(ratingpred);
    rating_cellpred=cellstr(rating_cellpred);
end
% keyboard;


nTrees = 1000


% b = TreeBagger(nTrees, features, rating, 'oobvarimp', 'on', 'oobpred', 'on');
b = TreeBagger(nTrees, train, ratingtrain, 'Method' , 'classification', 'oobpred', 'on', 'oobvarimp', 'on');
% [Yfit, Sfit] = b.predict(pred);
% [conf classorder] = confusionmat(rating_cellpred, Yfit);
% disp(dataset({conf, classorder{:}}, 'obsnames', classorder));
[Yfit, Sfit] = oobPredict(b);
[conf classorder] = confusionmat(rating_celltrain, Yfit);
disp(dataset({conf, classorder{:}}, 'obsnames', classorder));
[XX,YY,TT,AUC,optrocpt]=perfcurve(rating_celltrain, Sfit(:,2), classorder{2});
AUC


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
negativeFeatures = find(OOBPVDE < 0)
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