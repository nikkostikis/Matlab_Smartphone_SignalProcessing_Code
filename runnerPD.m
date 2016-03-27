delete 'pData.mat';

% After this you must run saveMetricsMats with caution

%30 patients 9 columns for each:
% (1)Name, 
% (2)RestR1[500,6], 
% (3)RestR2[500,6], 
% (4)RestL1[500,6], 
% (5)RestL2[500,6], 
% (6)ExtR1[500,6], 
% (7)ExtR2[500,6], 
% (8)ExtL1[500,6], 
% (9)ExtL2[500,6]

pData=cell(30,9);
% pData=cell(34,9); % Uncomment this to include On-Off

save 'pData.mat' pData;

fold = '../Data/PD_per_person/';

saveSignals('Pasiapalini', fold);
saveSignals('Anastasiadou', fold);
saveSignals('Iliadis', fold);
saveSignals('Poutsiki', fold);
saveSignals('Maronitis', fold);
saveSignals('Elanidou', fold);
saveSignals('Kalianidis', fold);
saveSignals('Fourkioti', fold);
saveSignals('Moulaimeri', fold);
saveSignals('Vasileiadou', fold);
saveSignals('Bogdakis', fold);
saveSignals('Galiota', fold);
saveSignals('Bilika', fold);
saveSignals('Efthimiou', fold);
saveSignals('Ntavela', fold);
saveSignals('Stokas', fold);
saveSignals('Ximitidou', fold);
saveSignals('Chatzi', fold);
saveSignals('Panidis', fold);
saveSignals('Delias', fold);
saveSignals('Chatzipavlidis', fold);
saveSignals('Koukouli', fold);
saveSignals('Karipidou', fold);
saveSignals('Myoglou', fold);
saveSignals('Papadopoulou', fold);
saveSignals('Andreadis', fold);
saveSignals('Ermidis', fold);
saveSignals('Dadios', fold);
saveSignals('Alexiou', fold);
saveSignals('Nikolaides', fold);

% saveSignals('Gensioson', fold);
% saveSignals('Gensiosoff', fold);
% saveSignals('Papadopoulouon', fold);
% saveSignals('Papadopoulouoff', fold);

load 'pData.mat';
pData=sortrows(pData,[1]);
save 'pData.mat' 'pData';

readScale; %to read the UPDRS from the combined file
compMetrics; %to calculate the four metrics from the pData.mat
keepCommonWithUPDRS;
% correlation; %to explore the correlation
