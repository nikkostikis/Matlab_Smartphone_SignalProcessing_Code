clear all;
clc;

%load alphabetically ordered and with common first column -names- cell
%arrays for iPhone and UPDRS
load 'PDmats/pComMetrics.mat';
load 'PDmats/uComMetrics.mat';

people=length(pComMetrics);

testMat=zeros(people,9);
testMat(:,1:5)=cell2mat(uComMetrics(1:people,2:6)); %RestR, RestL, ExtR, ExtL, HY

tempcell=pComMetrics(:,2:5); %RestR, RestL, ExtR, ExtL
rvelMagn=zeros(people,4);
rvelAmp=zeros(people,4);
accMagn=zeros(people,4);
accSumDiff=zeros(people,4);
for i=1:people
    for j=1:4
        accMagn(i,j)=tempcell{i,j}{1,1};%change {1,1} for other pMetric
        rvelMagn(i,j)=tempcell{i,j}{1,2};%change {1,2} for other pMetric
%         rvelPeak(i,j)=tempcell{i,j}{1,3}(1,3);%change (1,3) for x y z axes
        rvelAmp(i,j)=tempcell{i,j}{1,3};
        accSumDiff(i,j)=tempcell{i,j}{1,4};
    end
end
% testMat(:,6:9)=accMagn;
testMat(:,6:9)=rvelMagn;
% testMat(:,6:9)=rvelAmp;
% testMat(:,6:9)=accSumDiff;

% testMat=[testMat(1:17,:) ; testMat(19:people,:)]; %remove outlier -Ntavela (18th)

[r p]=corrcoef(testMat,'rows','pairwise');

% [rS pS]=corr(testMat,'type','Spearman');

ptriu=triu(p); %obtain upper triangle of p
rtriu=triu(r); %obtain upper triangle of r

[i j] = find(ptriu<0.01 & ptriu~=0);

indx = [i j]

iup = find ( indx(:,1) < 6 & indx(:,2) > 5);

indy = indx(iup, :)

[n,m] = size(indy);
linearIndy = zeros(1,n);
for niki = 1:n
    linearIndy(niki) = sub2ind( [9,9], indy(niki,1), indy(niki,2) );
end

pindy = p([linearIndy])'
rindy = r([linearIndy])'

% Uncomment to plot 

% [ii,jj]=deal(2,7); %Correlation for RestL-I'm assigning indices to access col 2 and 7 in testMat, corresponding to rL for uComMetrics and pComMetrics
% % [ii,jj]=deal(1,6); %Correlation for RestR
% 
% %The plot works nicely only for the rvelAmp metric. It needs adjustments
% %for the other metrics
% 
% x=testMat(:,ii); %1-5 {RestR, RestL, ExtR, ExtL, HY}, mainly 1-2 (only rest)
% y=testMat(:,jj); %6-9 {RestR, RestL, ExtR, ExtRL}, mainly 6-7 (only rest)
% a=r(ii,jj)*(std(y)/std(x));
% figure(1);
% hold on;
% %According to the values of the metric-these are for rvelAmp
% axis([-1 4.5 -10 33]);
% xlabel('UPDRS');
% ylabel('Metric-rvelAmp');
% title('Correlation Analysis for Rest/Left component');
% scatter(x,y,'b');
% %According to the values of the metric
% xline=linspace(-5,20,10);
% yline=a*xline;
% plot(xline,yline,'g');
% % pause;


