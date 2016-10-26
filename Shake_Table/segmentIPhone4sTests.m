% you have to load a signal from MATs/ (4sjs)
signal(:, 1) = i4s_js_t_normalized{4};
signal(:, 2) = i4s_js{4};
f = 4;
Fs = 60;

indLow = find(signal(:,1) < 10000);
indHi = find(signal(:,1) > 50000);

sig = signal((indLow(end) + 1):(indHi(1) - 1),:);

i = 1;
j = 1;
wsig = {};
while i < (length(sig))
    to = i + 299;
    to = min(length(sig), to)
    wsig{j} = sig(i:to,:);
    i = i + 300
    j = j + 1;
end

figure(300);
for i = 1:8
    t = wsig{i}(:, 1);
    t = t./1000; % convert time to seconds - not for table feedback
    x = wsig{i}(:, 2);
    
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
    plot(f, pxx, fpeaks, pkspks, 'or');
    
    pause;
end

figure(200);
minimum = zeros(8,1);
maximum = zeros(8,1);
meanval = zeros(8,1);
stdev = zeros(8,1);
for i = 1:8
    t = wsig{i}(:, 1);
%     t = t./1000; % convert time to seconds - not for table feedback
%     x = nikCell{i};
    dx = diff(t);
    
    bins = unique(dx);
    
    minimum(i) = min(bins);
    maximum(i) = max(bins);
    meanval(i) = mean(dx);
    stdev(i) = std(dx);
    
    subplot(3,3,i);
    h = histogram(dx, linspace(min(bins), max(bins)));
end



diary 'par_output_SegmentsIPhone4s.txt';
diary on;
for i = 1:8
    t = wsig{i}(:, 1);
    x = wsig{i}(:, 2);
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
    pxxrms = rms(pxx)^2
    par1 = pkspks(1)^2/pxxrms
    par2 = pkspks(2)^2/pxxrms
    par3 = pkspks(3)^2/pxxrms
end