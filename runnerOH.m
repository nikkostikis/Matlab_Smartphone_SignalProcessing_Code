delete 'pData.mat';

% After this you must run saveMetricsMats with caution

%11 (why not 20?) volunteers 9 columns for each:
% (1)Name, 
% (2)RestR1[500,6], 
% (3)RestR2[500,6], 
% (4)RestL1[500,6], 
% (5)RestL2[500,6], 
% (6)ExtR1[500,6], 
% (7)ExtR2[500,6], 
% (8)ExtL1[500,6], 
% (9)ExtL2[500,6]
pData=cell(20,9);

save 'pData.mat' pData;

fold = '../Data/OH_per_person/';

saveSignals('Alexandropoulou', fold);
saveSignals('Gialamas', fold);
saveSignals('Katos', fold);
saveSignals('Katsouli', fold);
saveSignals('Kostikis', fold);
saveSignals('Manika', fold);
saveSignals('Manikas', fold);
saveSignals('Stefanidis', fold);
saveSignals('Vatamos', fold);
saveSignals('Kouzis', fold);
saveSignals('xKostiki', fold);
saveSignals('Karipidis', fold);
saveSignals('Mandas', fold);
saveSignals('Alexandridou', fold);
saveSignals('Panousi', fold);
saveSignals('Kogiou', fold);
saveSignals('Balta', fold);
saveSignals('Karatasiou', fold);
saveSignals('Blekas', fold);
saveSignals('Kalogianni', fold);

load 'pData.mat';
pData=sortrows(pData,[1]);
save 'pData.mat' 'pData';
compMetrics; %to calculate the four metrics from the pData.mat

