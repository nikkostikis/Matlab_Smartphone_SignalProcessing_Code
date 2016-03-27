function unifySignalsAll

numOfPeople = 46; %20/OH, 26/PD

load('OHmats/pData.mat');
pDataOH = pData;
load('PDmats/pData.mat');
pDataPD = pData;

pDataAll = [pDataOH; pDataPD];
% 50x9 where:
% col 1: names
% col 2: Rest Right 1
% col 3: Rest Right 2
% col 4: Rest Left 1
% col 5: Rest Left 2
% col 6: Extension Right 1
% col 7: Extension Right 2
% col 8: Extension Left 1
% col 9: Extension Left 2
% Each cell has a 500x6 array where:
% -col 1-3: acceleration x, y, z
% -col 4-6: rotational velocity x, y, z

% Remove Ximitidou
pDataAll = pDataAll(1:end-1, :);

% Remove Efthimiou
indEfthimiou = find(strcmp(pDataAll(:,1), 'Efthimiou'));
pDataAll = pDataAll([1:indEfthimiou-1, indEfthimiou+1:end],:);

% Remove Ntavela
indNtavela = find(strcmp(pDataAll(:,1), 'Ntavela'));
pDataAll = pDataAll([1:indNtavela-1, indNtavela+1:end],:);

% Remove Papadopoulou
indPapadopoulou = find(strcmp(pDataAll(:,1), 'Papadopoulou'));
pDataAll = pDataAll([1:indPapadopoulou-1, indPapadopoulou+1:end],:);

% % Remove Poutsiki
% indPoutsiki = find(strcmp(pDataAll(:,1), 'Poutsiki'));
% pDataAll = pDataAll([1:indPoutsiki-1, indPoutsiki+1:end],:);

% % Remove Kalianidis
% indKalianidis = find(strcmp(pDataAll(:,1), 'Kalianidis'));
% pDataAll = pDataAll([1:indKalianidis-1, indKalianidis+1:end],:);



% cells numOfPeoplex2 where:
% col 1: names
% col 2: 500x6 signal, where:
% -col 1-3: acceleration x, y, z
% -col 4-6: rotational velocity x, y, z
pDataAllRR = pDataAll(:, 1:2);
pDataAllRL = pDataAll(:, [1,4]);
pDataAllER = pDataAll(:, [1,6]);
pDataAllEL = pDataAll(:, [1,8]);

% Reset file of energies per axis
fid = fopen('energyPerAxis.txt', 'w');
c = fix(clock);
fprintf(fid, '%i-%i-%i-%i-%i-%i', c);
fclose(fid);
% construct an array numOfPeoplex500 with the RR rotational velocity 
% signals with XYZ combined
rotAllRR = zeros(numOfPeople, 500);
rotAll_X_Y_RR = zeros(numOfPeople, 1000);
for i = 1:numOfPeople
    rot_X_RR = [pDataAllRR{i,2}(:,4)]';
    rot_Y_RR = [pDataAllRR{i,2}(:,5)]';
    rot_Z_RR = [pDataAllRR{i,2}(:,6)]';
    printSignalEnergyPerAxis(pDataAll{i,1}, [pDataAllRR{i,2}(:,4:6)], 'RR')
    rot_XYZ_RR = sqrt(rot_X_RR.^2 + rot_Y_RR.^2 + rot_Z_RR.^2);
    % save X & Y axes on All_X_Y_E/R+R/L like 46x1000 to 
    % facilitate plotting
    rotAll_X_Y_RR(i,:) = [rot_X_RR rot_Y_RR];
    rotAllRR(i,:) = rot_XYZ_RR;
end
% keyboard;
% construct an array numOfPeoplex500 with the RL rotational velocity 
% signals with XYZ combined
rotAllRL = zeros(numOfPeople, 500);
rotAll_X_Y_RL = zeros(numOfPeople, 1000);
for i = 1:numOfPeople
    rot_X_RL = [pDataAllRL{i,2}(:,4)]';
    rot_Y_RL = [pDataAllRL{i,2}(:,5)]';
    rot_Z_RL = [pDataAllRL{i,2}(:,6)]';
    printSignalEnergyPerAxis(pDataAll{i,1}, [pDataAllRL{i,2}(:,4:6)], 'RL')
    rot_XYZ_RL = sqrt(rot_X_RL.^2 + rot_Y_RL.^2 + rot_Z_RL.^2);
    % save X & Y axes on All_X_Y_E/R+R/L like 46x1000 to 
    % facilitate plotting
    rotAll_X_Y_RL(i,:) = [rot_X_RL rot_Y_RL];
    rotAllRL(i,:) = rot_XYZ_RL;
end

% construct an array numOfPeoplex500 with the ER rotational velocity 
% signals with XYZ combined
rotAllER = zeros(numOfPeople, 500);
rotAll_X_Y_ER = zeros(numOfPeople, 1000);
for i = 1:numOfPeople
    rot_X_ER = [pDataAllER{i,2}(:,4)]';
    rot_Y_ER = [pDataAllER{i,2}(:,5)]';
    rot_Z_ER = [pDataAllER{i,2}(:,6)]';
    printSignalEnergyPerAxis(pDataAll{i,1}, [pDataAllER{i,2}(:,4:6)], 'ER')
    rot_XYZ_ER = sqrt(rot_X_ER.^2 + rot_Y_ER.^2 + rot_Z_ER.^2);
    % save X & Y axes on All_X_Y_E/R+R/L like 46x1000 to 
    % facilitate plotting
    rotAll_X_Y_ER(i,:) = [rot_X_ER rot_Y_ER];
    rotAllER(i,:) = rot_XYZ_ER;
end

% construct an array numOfPeoplex500 with the EL rotational velocity 
% signals with XYZ combined
rotAllEL = zeros(numOfPeople, 500);
rotAll_X_Y_EL = zeros(numOfPeople, 1000);
for i = 1:numOfPeople
    rot_X_EL = [pDataAllEL{i,2}(:,4)]';
    rot_Y_EL = [pDataAllEL{i,2}(:,5)]';
    rot_Z_EL = [pDataAllEL{i,2}(:,6)]';
    printSignalEnergyPerAxis(pDataAll{i,1}, [pDataAllEL{i,2}(:,4:6)], 'EL')
    rot_XYZ_EL = sqrt(rot_X_EL.^2 + rot_Y_EL.^2 + rot_Z_EL.^2);
    % save X & Y axes on All_X_Y_E/R+R/L like 46x1000 to 
    % facilitate plotting
    rotAll_X_Y_EL(i,:) = [rot_X_EL rot_Y_EL];
    rotAllEL(i,:) = rot_XYZ_EL;
end

keyboard;