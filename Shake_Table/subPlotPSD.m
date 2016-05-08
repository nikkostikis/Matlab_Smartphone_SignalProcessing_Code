% nikCell_t = andro_js_t_normalized; nikCell = andro_js; Fs = 20;
% nikCell_t = i4_js_t_normalized; nikCell = i4_js; Fs = 20;
nikCell_t = i4s_js_t_normalized; nikCell = i4s_js; Fs = 60;
% nikCell_t = i6_js_t_normalized; nikCell = i6_js; Fs = 60;

% nikCell_t = andro_ntv_t_normalized; nikCell = andro_ntv; Fs = 100;
% nikCell_t = i4_ntv_t_normalized; nikCell = i4_ntv; Fs = 100;
% nikCell_t = i4s_ntv_t_normalized; nikCell = i4s_ntv; Fs = 100;

figure(300);
for i = 2:10
    x = nikCell{i};
    t = nikCell_t{i};
%     [pxx, f] = plomb(x, Fs);
%     [pxx, f] = plomb(x, t);
    [pxx, f] = plomb(x, t, 0.012); %set fmax to 12 Hz
    
    %try spectrogram
    
    subplot(3,3,i-1);
    plot(f.*1000, pxx);
end