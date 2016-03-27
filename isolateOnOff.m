load 'PDmats/uMetrics.mat';

idxon = find(strcmp(uMetrics(:,1), 'Gensioson'));
idxoff = find(strcmp(uMetrics(:,1), 'Gensiosoff'));
idyon = find(strcmp(uMetrics(:,1), 'Papadopoulouon'));
idyoff = find(strcmp(uMetrics(:,1), 'Papadopoulouoff'));

uMetricsOnOff = uMetrics([idxon idxoff idyon idyoff],:);

fold = '../Data/PD_per_person/';

pDataOnOff=cell(4,9);

save 'pDataOnOff.mat' pDataOnOff;

saveSignalsOnOff('Gensioson', fold);
saveSignalsOnOff('Gensiosoff', fold);
saveSignalsOnOff('Papadopoulouon', fold);
saveSignalsOnOff('Papadopoulouoff', fold);

load 'pDataOnOff.mat';
uMetricsOnOff=sortrows(uMetricsOnOff,[1]);
pDataOnOff=sortrows(pDataOnOff,[1]);
save 'pDataOnOff.mat' 'pDataOnOff';
save 'uMetricsOnOff.mat' 'uMetricsOnOff';
compMetricsOnOff; %to calculate the four metrics from the pData.mat