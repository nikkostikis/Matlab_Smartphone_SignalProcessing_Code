% nikCell_t = andro_js_t_normalized; nikCell = andro_js; Fs = 20;
% nikCell_t = i4_js_t_normalized; nikCell = i4_js; Fs = 20;
% nikCell_t = i4s_js_t_normalized; nikCell = i4s_js; Fs = 60;
% nikCell_t = i6_js_t_normalized; nikCell = i6_js; Fs = 60;

% nikCell_t = andro_ntv_t_normalized; nikCell = andro_ntv; Fs = 100;
% nikCell_t = i4_ntv_t_normalized; nikCell = i4_ntv; Fs = 100;
nikCell_t = i4s_ntv_t_normalized; nikCell = i4s_ntv; Fs = 100;

% nikCell_t = table_t; nikCell = table; Fs = 800;

figure300 = figure(300);
axes1 = axes('Parent',figure300);
hold(axes1,'on');

for i = 2:10
    x = nikCell{i};
    t = nikCell_t{i};
    t = t./1000; % convert time to seconds - not for table feedback
    
    [t ind] = unique(t);
    x = x(ind);
    
    fss = min(Fs/2, 12);
    
    [pxx, f] = plomb(x, t, fss); %set fmax to 12 Hz
    [pks, locs] = findpeaks(pxx);
%     pkslocs = [pks locs];
    pkslocs = sortrows([pks locs], -1);
%     subplot(3,3,i-1);
    fpeaks = f(pkslocs(1:3,2));
    pkspks = pkslocs(1:3,1);
    hold all;
    plot(f, pxx, fpeaks, pkspks, 'or', 'LineWidth', 2);
end
set(axes1,'FontSize',16);