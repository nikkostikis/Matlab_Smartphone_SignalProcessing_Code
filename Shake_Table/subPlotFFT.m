function subPlotFFT(nikCell, Fs)
figure(100);
for i = 2:10
    x = nikCell{i};
    [amp, f] = nikfft(x, length(x), Fs, 0);
    subplot(3,3,i-1);
    plot(f, amp);
end