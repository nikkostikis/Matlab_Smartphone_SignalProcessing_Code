%%
% clear all

% load('/Users/nikmac/Desktop/Thesis/Accelerometer_gig/UPDRS_iPhone Correlation_iPhone signal management_ROC/PDmats/pData.mat')
x = pData{4, 3}; %choose Bilika who is very typical

ampx = nikfft(x(:,5), 500, 20, 1);
%%

y = x(:,5);

ampy = nikfft(y, 500, 20, 1);

%%
hdLow = Lowpass_10_FIR_Equiriple;
yLow = filter(hdLow, y);

%%
plot(yLow);
hold on;
plot(y,'r');

%%
hold off;
ampyLow = nikfft_Color(yLow, 500, 20, 1, 'b');
hold on;
ampy = nikfft_Color(y, 500, 20, 1, 'r');

%%
hdBand = Bandpass_2_9_IIR_Butterworth;
yBand = filter(hdBand, yLow);
% yBand = filter(hdBand, y);
hold off;
ampyBand = nikfft_Color(yBand, 500, 20, 1, 'b');
% hold on;
% ampy = nikfft_Color(y, 500, 20, 1, 'r');

