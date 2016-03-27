function compRvelVec

clear all;
clc;

load 'OHmats/pData.mat';
% load 'PDmats/pData.mat';
% load 'PDmats/pComMetrics';
% Both structures are alphabetically ordered

%find names with both UPDRS and iPhone measurement
% [comNames pInd uInd]=intersect(pData(:,1),pComMetrics(:,1));

%keep only common names, patients with both UPDRS and iPhone measurements
% pComData=pData(pInd,:);

pComData=pData;

rvelMagnVec=cell(length(pComData), 4);
for i=1:length(pComData)
    m=1;
    flag=0;
    for j=2:2:8
        
        
        if (~isempty(pComData{i,j})) %checking if there is effort 1
            denom=1;
            tempMat=pComData{i,j};
            rvelMat=tempMat(:,4:6);
            
            %signal power metric
            
            rvelMagn=(rvelMat(:,1).^2+rvelMat(:,2).^2+rvelMat(:,3).^2);
                        
            flag=1;
            m=m+1;
        else
            fprintf(strcat('Empty pComData cell', pComData{i,1}, '_',num2str(j),'\n'));
        end
        
        if (~isempty(pComData{i,j+1})) %checking if there is effort 2
            
            tempMat=pComData{i,j+1};
            rvelMat=tempMat(:,4:6);
            
            rvelMagn=rvelMagn+ (rvelMat(:,1).^2+rvelMat(:,2).^2+rvelMat(:,3).^2);
            
            denom=2;
            if (flag==0) %there was no effort 1
                m=m+1;
                denom=1;
            end
        else
            fprintf(strcat('Empty pComData cell', pComData{i,1}, '_',num2str(j+1),'\n'));
        end
        rvelMagnVec{i,floor(j/2)}=rvelMagn./denom;
    end
end
save 'rvelMagnVec.mat' 'rvelMagnVec';
% save 'PDmats/pComData.mat' 'pComData';
return;