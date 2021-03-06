function Hd = Bandpass_3_9_IIR_Butterworth
%BANDPASS_3_9_IIR_BUTTERWORTH Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 8.1 and the Signal Processing Toolbox 6.19.
% Generated on: 17-Mar-2015 14:24:34

% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 20;  % Sampling Frequency

Fstop1 = 1.8;         % First Stopband Frequency
Fpass1 = 2.1;         % First Passband Frequency
Fpass2 = 9;           % Second Passband Frequency
Fstop2 = 9.1;         % Second Stopband Frequency
Astop1 = 10;          % First Stopband Attenuation (dB)
Apass  = 1;           % Passband Ripple (dB)
Astop2 = 10;          % Second Stopband Attenuation (dB)
match  = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
                      Astop2, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);

% [EOF]
