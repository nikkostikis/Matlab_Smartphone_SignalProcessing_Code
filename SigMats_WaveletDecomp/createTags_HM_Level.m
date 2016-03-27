tags = {'EL', 'ER', 'RL', 'RR'};
levels = linspace(1,8,8);

k = 0;
for i=1:4
    for j=1:8
        k=k+1;
        labels{k} = strcat( tags{i}, num2str(levels(j) ) );
    end
end

% 
% load 'wavDetCoefsPower_EL.mat';
% load 'wavDetCoefsPower_ER.mat';
% load 'wavDetCoefsPower_RL.mat';
% load 'wavDetCoefsPower_RR.mat';
% 
% wavDetCoefsPower_All = [wavDetCoefsPower_EL wavDetCoefsPower_ER ...
%     wavDetCoefsPower_RL wavDetCoefsPower_RR];
% save 'wavDetCoefsPower_All.mat' 'wavDetCoefsPower_All';