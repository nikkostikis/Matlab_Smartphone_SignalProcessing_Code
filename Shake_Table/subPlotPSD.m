function subPlotPSD(nikCell, Fs)
figure(100);
for i = 2:10
    x = nikCell{i};
    [pxx, f] = plomb(x, Fs);
    subplot(3,3,i-1);
    plot(f, pxx);
end