function amp=nikfft(sig, L, Fs, figure)
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(sig,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
% Plot single-sided amplitude spectrum.
amp=2*abs(Y(1:NFFT/2+1));

if figure==1    
    plot(f,amp); 
    title('Single-Sided Amplitude Spectrum of y(t)');
    xlabel('Frequency (Hz)');
    ylabel('|Y(f)|');
end

