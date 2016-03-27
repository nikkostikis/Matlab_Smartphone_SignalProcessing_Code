function RotVel_DWT_PerSignal

HM = 'EL';
% HM = 'ER';
% HM = 'RL';
% HM = 'RR';

% ax = 'X';
% ax = 'Y';
% ax = XxY;
ax = 'XORY';

plotting = 0;
% plotting = 1;


Y = load(strcat('pDataROT_PerHandMove/rotAll_X_Y_',HM,'.mat'));
YfieldNames = fieldnames(Y);
X = Y.(YfieldNames{1});
[m n] = size(X);

xx = X(:, 1:500);
xy = X(:, 501:1000);
xxy = sqrt(xx.^2 + xy.^2);

% each person will be represented by the axis on which he shows
% the max rotational velocity energy. Artificially but correct
% experimentally, it cannot be z
xORy = zeros(m, 500);
for i = 1:m
    concatXY0 = [xx(i,:)' xy(i,:)' zeros(1,500)'];
    maxAX = printSignalEnergyPerAxis_NoFile('', concatXY0, '');
    xORy(i,:) = concatXY0(:,maxAX);
end

% choose signal axis
if (ax == 'X')
    x = xx;
    'X'
elseif (ax == 'Y')
    x = xy;
    'Y'
elseif (strcmp(ax, 'XxY') == 1)
    x = xxy;
    'XxY'
else % decide dynamically
    x = xORy;
    'xORy'
end

[m n] = size(x); %size of signal
level = wmaxlev(n, 'haar');

% the following loop is equivalent to the mdwtdec command
% that follows. i only kept it for the L vector which gives me
% the sizes of each level's coef vector
CTot = zeros(m,502);
for i = 1:m
    [C L] = wavedec(x(i,:), level, 'haar');
    CTot(i,:) = C;
end

% actual decomposition for max level
decROW = mdwtdec('r',x,level,'haar');
wmaxlev(500, 'haar')
scal2frq(linspace(1,level,level), 'haar', 1/20)

coefsPower = ones(m,level);
coefsCell = decROW.cd;
for j = 1:level
    ar = coefsCell{j};
    for k = 1:46
        % L vector contains the lengths of the coefs vectors
        coefsPower(k, j) = (norm(ar(k,:))^2) / L(level+2 - j);
    end
end
% save the sum of coefficients for levels 3-6
coefsPower3_6 = coefsPower(:,3)+coefsPower(:,4)+coefsPower(:,5)+coefsPower(:,6);
varName = strcat('wavDetCoefsPower_3_6_', HM);
eval(strcat(varName, ' = coefsPower3_6;'));
fileName = strcat(varName, '.mat');
eval(['save', ' ', fileName, ' ', varName]);

coefsPower;
varName = strcat('wavDetCoefsPower_', HM);
eval(strcat(varName, ' = coefsPower;'));
fileName = strcat(varName, '.mat');
eval(['save', ' ', fileName, ' ', varName]);