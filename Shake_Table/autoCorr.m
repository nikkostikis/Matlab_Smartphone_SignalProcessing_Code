table_t; table; Fst = 800;

figure(900);
sumMaxCorrx = 0; % sum of maximum cross-correlations x*y
sumMaxCorry = 0; % sum of maximum auto-correlation x*x

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

    
    x = x(10:end-10) * 3; % for Samsung JS and NTV
%     x = x(10:end-10) * 9.81; % for iPhones NTV
%     x = x(10:end-10); % for iPhones JS
    y = newtx.data(10:end-10);
    newtime = newtime(10:end-10);
    
    [smartpxx, smartf] = plomb(x, newtime, fss);
    [newpxx, newf] = plomb(y, newtime, fss);

    [xr xlg] = xcorr(x, y);
    indx = find(xr == max(xr));
    sumMaxCorrx = sumMaxCorrx + xr(indx(1));
    
    [yr ylg] = xcorr(y);
    indy = find(yr == max(yr));
    sumMaxCorry = sumMaxCorry + yr(indy(1));
    subplot(3,3,i-1);
    plot(ylg, yr, 'r');
    hold on;
    plot(xlg, xr, 'b');
end

meanx = sumMaxCorrx / 9
meany = sumMaxCorry / 9
perc = meanx / meany * 100