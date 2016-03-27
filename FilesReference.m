Files Reference

pData --> iPhone data. Cell
%30 patients, 9 columns for each:
% (1)Name, 
% (2)RestR1[500,6], 
% (3)RestR2[500,6], 
% (4)RestL1[500,6], 
% (5)RestL2[500,6], 
% (6)ExtR1[500,6], 
% (7)ExtR2[500,6], 
% (8)ExtL1[500,6], 
% (9)ExtL2[500,6]

pMetrics --> iPhone data. Cell
%30 patients, 5 columns for each:
% (1)Name, 
% (2)RestR{1,4}, 
% (3)RestL{1,4},
% (4)ExtR{1,4},
% (5)ExtL{1,4}, 

|^|^|^|^|
%one column for each metric - now I have four, 
%(1) accMagn & 
%(2) rvelMagn, 
%(3) rvelAmp
%(4) accSumDiff

uMetrics --> UPDRS data. Cell
%26 patients, 6 columns for each:
% (1)Name, 
% (2)RestR (scalar), 
% (3)RestL (scalar), 
% (4)ExtR (scalar), 
% (5)ExtL (scalar), 
% (6)HoehnYahr (scalar, NaN if nonexistent) 

pComMetrics --> iPhone data. Same as pMetrics but only common rows with uMetrics
%23 patients, 5 columns for each:
% (1)Name, 
% (2)RestR{1,4}, 
% (3)RestL{1,4}, 
% (4)ExtR{1,4}, 
% (5)ExtL{1,4}, 

|^|^|^|^|
%one column for each metric - now I have four, 
%(1) accMagn & 
%(2) rvelMagn, 
%(3) rvelAmp,
%(4) accSumDiff

uComMetrics --> UPDRS data. Same as uMetrics but only common rows with pMetrics
%23 patients, 6 columns for each:
% (1)Name, 
% (2)RestR (scalar), 
% (3)RestL (scalar), 
% (4)ExtR (scalar), 
% (5)ExtL (scalar), 
% (6)HoehnYahr (scalar, NaN if nonexistent) 

rvelMagn --> rvelMagn metric for all loaded
rvelAmp --> rvelAmp metric for all loaded
accMagn --> accMagn metric for all loaded
accSumDiff --> accSumDiff metric for all loaded
%num of people loaded, 4 columns for each:
%(1) rR
%(2) eR
%(3) rL
%(4) eL

compMetrics.m
%loads pData.mat, 
%calculates and saves pMetrics, 
%deletes pComMetrics and uComMetrics

createSeparateFiles.m
%opens wrapper.txt, 
%creates and saves separate UPDRS txt files, 

nikfft.m
%called like amp=nikfft(sig, L, Fs, figure), 
%calculates and returns amp - single-sided amplitude spectrum 

readScale.m
%loads pData.mat, 
%calculates and saves pMetrics, 
%deletes pComMetrics and uComMetrics

saveSignals.m
%called like saveSignals(folder), where folder is a subject's name 
%calculates and saves pData

correlation.m
%loads pComMetrics.mat and uComMetrics.mat, 
%calculates correlation,
%doesn't save anything

GensiosStudy.m
%loads pMetrics.mat and finds the two row regarding Gensios
%isolates his metrics

keepCommonWithUPDRS.m
%loads pMetrics.mat and uMetrics.mat, 
%calculates their intersection and removes Ximitidou who is lacking the left hand iPhone metrics 
%saves pComMetrics.mat and uComMetrics.mat

periodogram_analysis.m
%loads pData.mat row for Blika, 
%plots the periodogram (pwelch)

runner.m
%deletes pData.mat, 
%saves pData.mat empty,
%calls saveSignals.m for every subject
%sorts aphabetically pData.mat

saveMetricsMats.m
%loads pMetrics.mat OR pComMetrics.mat, 
%calculates and saves separate mats for every metric

untitled.m
%testbed

*ROC.m
%load corresponding metric mat from both PD and OH folders
%calculate ROC curves

ROCmats folder
%output from calculation of ROC curves for each metric, each posture (should be 4-metrics x 4-postures x 2-healthcodes)

prepareDataforNN.m
%loads data (pMetrics.mat) for both OH and PD populations, removes the
%names (first column) and puts them in a unified cell like {OH;PD} of size
%20+?x4, where the 4 stands for:
%(1)RestR{1,4}, 
%(2)RestL{1,4},
%(3)ExtR{1,4},
%(4)ExtL{1,4},
% and within these 4 cells:
% one column for each metric - now I have four, 
%(1) accMagn & 
%(2) rvelMagn, 
%(3) rvelAmp,
%(4) accSumDiff

