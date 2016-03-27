%%
% HM = 'EL';
% HM = 'ER';
% HM = 'RL';
HM = 'RR';

plotting = 0;

Y = load(strcat('pDataROT_PerHandMove/rotAll',HM,'.mat'));% load signal
YfieldNames = fieldnames(Y);
X = Y.(YfieldNames{1});

[nbSIG,nbVAL] = size(X); %size of signal

% simple plot--------------------------
plot(X','r'); % make the plot
axis tight;
title('Original Data: 46 patients');
xlabel('Samples 1-500');
%%


% surface plot -------------------------
surf(X);
shading interp;
axis tight;
title('Original Data: 46 volunteers, 20*OH & 26*PD');
xlabel('Samples 1-500','Rotation',15);
ylabel('Patients 1-46','Rotation',-30);
ax = gca;
ax.View = [-13.5 48];

%%
% Decomposition
dirDec = 'r';         % Direction of decomposition
wname  = 'sym4';      % Near symmetric wavelet
level  = wmaxlev(nbVAL, wname);           % Level of decomposition
% level = 1;
decROW = mdwtdec(dirDec,X,level,wname);

%%
% Reconstruction
A7_ROW  = mdwtrec(decROW,'a',level);
if plotting == 1
    subplot(2,1,1);
    plot(X(:,:)','r');
    title('Original Data');
    axis tight
    subplot(2,1,2);
    plot(A7_ROW(:,:)','b');
    axis tight
    title(strcat('Corresponding approximations at level ', level));
end

%%
% Denoising
dirDec = 'r';         % Direction of decomposition
level  = 3;           % Level of decomposition
wname  = 'sym4';      % Near symmetric wavelet
decROW = mdwtdec(dirDec,X,level,wname);

[XD,decDEN] = mswden('den',decROW,'sqtwolog','mln');
Residuals = X-XD;
if plotting == 1
    subplot(3,1,1);
    plot(X','r');
    axis tight
    title('Original Data: 46 volunteers');
    subplot(3,1,2);
    plot(XD','b');
    axis tight
    title('Denoised Data: 46 volunteers');
    subplot(3,1,3);
    plot(Residuals','k');
    axis tight
    title('Residuals');
    xlabel('Samples 1-500');
end
%%
% Compressing
dirDec = 'r';         % Direction of decomposition
level  = wmaxlev(nbVAL, wname);  % Level of decomposition
wname  = 'sym4';      % Near symmetric wavelet
decROW = mdwtdec(dirDec,X,level,wname);

[XC,decCMP,THRESH] = mswcmp('cmp',decROW,'L2_perf',99);

if plotting == 1
    subplot(3,1,1);
    plot(X','r');
    axis tight
    title('Original Data: 46 volunteers');
    subplot(3,1,2);
    plot(XC','b');
    axis tight
    title('Compressed Data: 46 volunteers');
    subplot(3,1,3);
    plot((X-XC)','k');
    axis tight
    title('Residuals');
    xlabel('Samples 1-500');
end
%%
% Compression performance
cfs = cat(2,[decCMP.cd{:},decCMP.ca]);
cfs = sparse(cfs);
perf = zeros(1,nbSIG);
for k = 1:nbSIG
    perf(k) = 100*nnz(cfs(k,:))/nbVAL;
end

if plotting == 1
    figure('Color','w')
    plot(perf,'r-*');
    title('Percentages of nonzero coefficients for the 46 volunteers');
    xlabel('Signal indices');
    ylabel('% of nonzero coefficients');
end
% %%
% % 
% Stats_TBX_Flag = isstatstbxinstalled;
% if ~Stats_TBX_Flag
%     WarnStr = isstatstbxinstalled('msg');
%     uiwait(msgbox(WarnStr,...
%         'Using clustering tools','warn','modal'));
%     msg = {...
%     'Denoising, compression and clustering using wavelets are very efficient'
%     'tools. The capacity of wavelet representations to concentrate signal'
%     'energy in few coefficients is the key of efficiency.'
%     'In addition, clustering offers a convenient procedure to summarize a'
%     'large set of signals using sparse wavelet representations.'
%     };
%     uiwait(msgbox(msg,...
%         'Using clustering tools','warn','modal'));
% 
%     return
% end
%%
% Clustering


P1 = mdwtcluster(decROW,'lst2clu',{'s',strcat('ca', num2str(level))},'wname',wname,'maxclust',10);
P2 = mdwtcluster(decDEN,'lst2clu',{'s'},'wname',wname,'maxclust',10);

Clusters = [P1.IdxCLU P2.IdxCLU];


EqualPART = isequal(max(diff(Clusters,[],2)),[0 0])

figure('Color','w')
stem(Clusters(:,1),'filled','b:');
hold on;
stem(Clusters(:,2),'filled','xr:');
hold on;
stem(Clusters(:,3),'g:');
hold off;
title('The two clusters of the original 46 volunteers');
xlabel('Signal indices');
ylabel('Index of cluster');
ax = gca;
xlim([1 46]);
ylim([0.5 11.1]);
ax.YTick = 1:2;