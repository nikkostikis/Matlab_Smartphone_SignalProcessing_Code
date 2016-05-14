% nikCell_t = andro_js_t_normalized; nikCell = andro_js; Fs = 20; 
% nikCell_t = i4_js_t_normalized; nikCell = i4_js; Fs = 20; 
% nikCell_t = i4s_js_t_normalized; nikCell = i4s_js; Fs = 60; 
% nikCell_t = i6_js_t_normalized; nikCell = i6_js; Fs = 60; 

% nikCell_t = andro_ntv_t_normalized; nikCell = andro_ntv; Fs = 100; 
% nikCell_t = i4_ntv_t_normalized; nikCell = i4_ntv; Fs = 100; 
nikCell_t = i4s_ntv_t_normalized; nikCell = i4s_ntv; Fs = 100;

table_t; table; Fst = 800;

diary 'cor.txt';
diary on;

figure(800);
for i = 2:10
    i
    fss = min(Fs/2, 12);
    tablex = table{i}(1:end-1); tablet = table_t{i}(1:end-1);
    x = nikCell{i}; t = nikCell_t{i};
    [t ind] = unique(t); x = x(ind); [tablet ind] = unique(tablet); tablex = tablex(ind);
    if t(end)>100 %happens only for non-table times
        t = t./1000; % convert time to seconds - not for table feedback
    end
    newtime = t; %use smartphone time to resample table signal
    %keep time points smaller than total duration of table signal
    indx = find(newtime>max(tablet)); 
    if (indx > 0)
        newtime = newtime(10:indx(1)); x = x(10:indx(1));
    end
    
    %convert to timeseries
    ts = timeseries(tablex, tablet);
    %resample the timeseries using dmartphone's time
    newtx = resample(ts, newtime);

    x = x(10:end-10);
    y = newtx.data(10:end-10);
    newtime = newtime(10:end-10);
    
    [smartpxx, smartf] = plomb(x, newtime, fss);
    [newpxx, newf] = plomb(y, newtime, fss);

    [r lg] = xcorr(x, y);
%     A = [x y];
    minlen = min(length(newpxx), length(smartpxx));
    A = [smartpxx(1:minlen), newpxx(1:minlen)];
%     [rr p] = corr(x, y)
    [rr, p] = corrcoef(A)
    subplot(3,3,i-1);
%     plot(newtx.data, 'r');
%     hold on;
%     plot(x, 'b');
    plot(lg, r);
%     hold on;
%     plot(newf, newpxx, 'b');
end