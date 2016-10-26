% you have to load a signal from MATs/Table
f = 4;
Fs = 800;

indLow = find(signal(:,1) < 10);
indHi = find(signal(:,1) > 50);

sig = signal((indLow(end) + 1):(indHi(1) - 1),:);

i = 1;
j = 1;
wsig = {};
while i < (length(sig))
    wsig{j} = sig(i:(i + 3999),:);
    i = i + 4000
    j = j + 1;
end

figure(300);
for i = 1:8
    t = wsig{i}(:, 1);
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