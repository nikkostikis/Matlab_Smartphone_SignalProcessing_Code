function prepareDataforNN

load 'OHmats/pMetrics.mat'

metricsCellOH = pMetrics(:, 2:end);
RR_OH = metricsCellOH(:,1);
RL_OH = metricsCellOH(:,2);
ER_OH = metricsCellOH(:,3);
EL_OH = metricsCellOH(:,4);

for i = 1:20
    RR_OH{i} = cell2mat(RR_OH{i});
    RL_OH{i} = cell2mat(RL_OH{i});
    ER_OH{i} = cell2mat(ER_OH{i});
    EL_OH{i} = cell2mat(EL_OH{i});
end

RR_OH = cell2mat(RR_OH);
RL_OH = cell2mat(RL_OH);
ER_OH = cell2mat(ER_OH);
EL_OH = cell2mat(EL_OH);

% keyboard;


load 'PDmats/pComMetrics.mat'

metricsCellPD = pComMetrics(:, 2:end);
RR_PD = metricsCellPD(:,1);
RL_PD = metricsCellPD(:,2);
ER_PD = metricsCellPD(:,3);
EL_PD = metricsCellPD(:,4);

for i = 1:23
    RR_PD{i} = cell2mat(RR_PD{i});
    RL_PD{i} = cell2mat(RL_PD{i});
    ER_PD{i} = cell2mat(ER_PD{i});
    EL_PD{i} = cell2mat(EL_PD{i});
end

RR_PD = cell2mat(RR_PD);
RL_PD = cell2mat(RL_PD);
ER_PD = cell2mat(ER_PD);
EL_PD = cell2mat(EL_PD);

% Unify arrays per Move/Hand
RR = [RR_OH; RR_PD];
RL = [RL_OH; RL_PD];
ER = [ER_OH; ER_PD];
EL = [EL_OH; EL_PD];

% keyboard;

% Unify arrays per Metric
AM_OH = [RR_OH(:,1) RL_OH(:,1) ER_OH(:,1) EL_OH(:,1)];
RM_OH = [RR_OH(:,2) RL_OH(:,2) ER_OH(:,2) EL_OH(:,2)];
RA_OH = [RR_OH(:,3) RL_OH(:,3) ER_OH(:,3) EL_OH(:,3)];
ASD_OH = [RR_OH(:,4) RL_OH(:,4) ER_OH(:,4) EL_OH(:,4)];

AM_PD = [RR_PD(:,1) RL_PD(:,1) ER_PD(:,1) EL_PD(:,1)];
RM_PD = [RR_PD(:,2) RL_PD(:,2) ER_PD(:,2) EL_PD(:,2)];
RA_PD = [RR_PD(:,3) RL_PD(:,3) ER_PD(:,3) EL_PD(:,3)];
ASD_PD = [RR_PD(:,4) RL_PD(:,4) ER_PD(:,4) EL_PD(:,4)];

AM = [AM_OH; AM_PD];
RM = [RM_OH; RM_PD];
RA = [RA_OH; RA_PD];
ASD = [ASD_OH; ASD_PD];

% keyboard;

target2043 = ones(43,1);
target2043(1:20,1) = 0;

keyboard;