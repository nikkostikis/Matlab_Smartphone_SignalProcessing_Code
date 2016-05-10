% requires to be called from parRunner

% figure(700);
disp(nikCell{1});
for i = 2:10
    x = nikCell{i};
    t = nikCell_t{i};
    if t(end)>100 %happens only for non-table times
        t = t./1000; % convert time to seconds - not for table feedback
    end
    [t ind] = unique(t); %a problem only for the i4
    x = x(ind);
    fss = min(Fs/2, 12);
    
    [pxx, f] = plomb(x, t, fss); %set fmax to 12 Hz
    [pks, locs] = findpeaks(pxx);
    pkslocs = sortrows([pks locs], -1);
%     subplot(3,3,i-1);
    fpeaks = f(pkslocs(1:3,2));
    pkspks = pkslocs(1:3,1);
%     plot(f, pxx, fpeaks, pkspks, 'or');
    i
    pxxrms = rms(pxx)
    par1 = pkspks(1)^2/pxxrms
    par2 = pkspks(2)^2/pxxrms
    par3 = pkspks(3)^2/pxxrms
end