clear all;
clc;

% load 'PDmats/accMagn.mat';
% load 'PDmats/rvelMagn.mat';
% load 'PDmats/accSumDiff.mat';
% load 'PDmats/rvelAmp.mat';

load 'OHmats/accMagn.mat';
load 'OHmats/rvelMagn.mat';
load 'OHmats/accSumDiff.mat';
load 'OHmats/rvelAmp.mat';

% right = [accMagn(:,[1 3]) rvelMagn(:,[1 3]) accSumDiff(:,[1 3]) rvelAmp(:,[1 3])];
% left = [accMagn(:,[2 4]) rvelMagn(:,[2 4]) accSumDiff(:,[2 4]) rvelAmp(:,[2 4])];
accMagnR=accMagn(:,[1 3]);
accMagnL=accMagn(:,[2 4]);
rvelMagnR=rvelMagn(:,[1 3]);
rvelMagnL=rvelMagn(:,[2 4]);
accSumDiffR=accSumDiff(:,[1 3]);
accSumDiffL=accSumDiff(:,[2 4]);
rvelAmpR=rvelAmp(:,[1 3]);
rvelAmpL=rvelAmp(:,[2 4]);

right = [sum(accMagnR,2) sum(rvelMagnR,2) sum(accSumDiffR,2) sum(rvelAmpR,2)];
left = [sum(accMagnL,2) sum(rvelMagnL,2) sum(accSumDiffL,2) sum(rvelAmpL,2)];

% tagRE={'Rest','Extension'};
tagM={'accMagn','rvelMagn','accSumDiff','rvelAmp'};

% i=0;
% for k=1:8
%     k;
%     i=i+mod(k,2);
%     j=mod(k,2);
%     if mod(k,2)==0
%         j=2;
%     end
%     mw(right(:,k), left(:,k), strcat(tagRE{j},'_',tagM{i}));
%     fprintf('\n---------\n');
% end

i=0;
for k=1:4
    mw(right(:,k), left(:,k), tagM{k});
    fprintf('\n---------\n');
end
