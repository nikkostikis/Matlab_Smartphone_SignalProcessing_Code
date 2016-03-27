clear all;
clc;

% load 'PDmats/rvelMagnVec.mat';

load 'OHmats/rvelMagnVec.mat';

people=length(rvelMagnVec);
p=zeros(people,1);
for i=1:people
    i
    rR=rvelMagnVec{i,1};
    rL=rvelMagnVec{i,2};
    eR=rvelMagnVec{i,3};
    eL=rvelMagnVec{i,4};
    sumR=rR+eR;
    sumL=rL+eL;
%     mw(rR, rL, 'rest');
%     mw(rR, rL, 'extension');
    p(i)=mw(sumR,sumL,strcat('Patient: |__', num2str(i)));
end