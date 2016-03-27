% Call it per health status - uncomment the appropriate pM definition

% load alphabetically ordered cell array for iPhone signals - only the
% patients with matching UPDRS evaluation
% load 'pComMetrics.mat'; % run this or doubleclick the desired mat prior to running

% pM=pComMetrics;

% load alphabetically ordered cell array for iPhone signals - not only the
% patients with matching UPDRS evaluation, but all - the correct choice for
% OH population
% load 'pMetrics.mat'; % run this or doubleclick the desired mat prior to running

pM=pMetrics;

people=length(pM);

tempcell=pM(:,2:5); %RestR, RestL, ExtR, ExtL
rvelMagn=zeros(people,4); 
rvelAmp=zeros(people,4);
accMagn=zeros(people,4);
accSumDiff=zeros(people,4);

for i=1:people
    for j=1:4
        accMagn(i,j)=tempcell{i,j}{1,1};
        rvelMagn(i,j)=tempcell{i,j}{1,2};
        rvelAmp(i,j)=tempcell{i,j}{1,3};
        accSumDiff(i,j)=tempcell{i,j}{1,4};
    end
end
save 'rvelMagn.mat' 'rvelMagn'
save 'rvelAmp.mat' 'rvelAmp'
save 'accMagn.mat' 'accMagn'
save 'accSumDiff.mat' 'accSumDiff'