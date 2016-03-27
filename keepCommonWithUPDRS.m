load 'pMetrics.mat';
load 'uMetrics.mat';
%pMetrics and uMetrics are alphabetically ordered

%find names with both UPDRS and iPhone measurement
[comNames pInd uInd]=intersect(pMetrics(:,1),uMetrics(:,1));

%find Ximitidou in both cells
XindP=find(strcmp(pMetrics(:,1),'Ximitidou'));
XindU=find(strcmp(uMetrics(:,1),'Ximitidou'));

%remove Ximitidou from indices' vectors
pInd=pInd(pInd~=XindP);
uInd=uInd(uInd~=XindU);

%keep only common names, patients with both UPDRS and iPhone measurements
pComMetrics=pMetrics(pInd,:);
uComMetrics=uMetrics(uInd,:);

save 'pComMetrics.mat' 'pComMetrics';
save 'uComMetrics.mat' 'uComMetrics';