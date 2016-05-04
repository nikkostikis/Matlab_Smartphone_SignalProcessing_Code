% nikCell = andro_js_t; Fs = 20;
% nikCell = i4_js_t; Fs = 20;
% nikCell = i4s_js_t; Fs = 60;
% nikCell = i6_js_t; Fs = 60;

% nikCell = andro_ntv_t; Fs = 100;
% nikCell = i4_ntv_t; Fs = 100;
% nikCell = i4s_ntv_t; Fs = 100;

figure(100);
for i = 2:10
    x = nikCell{i};
    [pxx, f] = plomb(x, Fs);
    subplot(3,3,i-1);
    plot(f, pxx);
end