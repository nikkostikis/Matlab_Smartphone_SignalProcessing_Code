clear all;
clc;

% load 'PDmats/accMagn.mat';
% pd=accMagn;
% load 'OHmats/accMagn.mat';
% h=accMagn;

% load 'PDmats/rvelMagn.mat';
% pd=rvelMagn;
% load 'OHmats/rvelMagn.mat';
% h=rvelMagn;
% 
% load 'PDmats/accSumDiff.mat';
% pd=accSumDiff;
% load 'OHmats/accSumDiff.mat';
% h=accSumDiff;
% 
load 'PDmats/rvelAmp.mat';
pd=rvelAmp;
load 'OHmats/rvelAmp.mat';
h=rvelAmp;


tag={'rR','rL','eR','eL'};

% for i=1:4
% %     mw(pd(:,i), h(:,i), strcat('accMag_',tag{i}));
% %     mw(pd(:,i), h(:,i), strcat('rvelMag_',tag{i}));
% %     mw(pd(:,i), h(:,i), strcat('accSumDiff_',tag{i}));
%     mw(pd(:,i), h(:,i), strcat('rvelAmp_',tag{i}));
% end
% sumpd = sum(pd');
% sumh = sum(h');
% % mw(sumpd, sumh, 'accMagn');
% % mw(sumpd, sumh, 'rvelMagn');
% % mw(sumpd, sumh, 'accSumDiff');
% mw(sumpd, sumh, 'rvelAmp');
PDR=pd(:,1) + pd(:,3);
HR=h(:,1) + h(:,3);
PDL=pd(:,2) + pd(:,4);
HL=h(:,2) + h(:,4);
diffPD = abs(PDR - PDL);
diffH = abs(HR - HL);
p=mw(diffPD, diffH, 'differences between hands');
