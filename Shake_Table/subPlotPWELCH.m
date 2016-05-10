% nikCell_t = andro_js_t_normalized; nikCell = andro_js; Fs = 20;
% nikCell_t = i4_js_t_normalized; nikCell = i4_js; Fs = 20;
% nikCell_t = i4s_js_t_normalized; nikCell = i4s_js; Fs = 60;
% nikCell_t = i6_js_t_normalized; nikCell = i6_js; Fs = 60;

% nikCell_t = andro_ntv_t_normalized; nikCell = andro_ntv; Fs = 100;
% nikCell_t = i4_ntv_t_normalized; nikCell = i4_ntv; Fs = 100;
nikCell_t = i4s_ntv_t_normalized; nikCell = i4s_ntv; Fs = 100;
% nikCell = table; Fs = 800;

figure(500);
for i = 2:10
    x = nikCell{i};
%     t = nikCell_t{i};
    [pxx, f] = pwelch(x, 500, 300, 500, Fs);
    
    %try spectrogram
    
    subplot(3,3,i-1);
    plot(f, 10*log10(pxx));
end