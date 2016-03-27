clc;
close all;
clear all;

n=0:300000;
delay = 10000;
wc=.2*pi;
w0=.4*pi;

hLP=(wc/pi)*sinc((wc/pi)*(n-delay));
hBP=2*cos(n*w0).*hLP;
% [Happrox,W]=freqz(hBP,1);

N = 500; % 200 points in frequency vector
Fs = 100; % 100 Hz sample rate
[Happrox,W]=freqz(hBP,1, N, Fs);

plot(W,abs(Happrox));
xlabel('frequency'); 
ylabel('magnitude');
title('Band pass Filter');