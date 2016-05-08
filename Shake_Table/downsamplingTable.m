newtime = i6_js_t_normalized{10};
newtime = newtime./1000;
plot(table10(:,1), 'b');
hold on
plot(newtime, 'r');

timelimit = max(table10(:,1));
indx = find(newtime>timelimit);
newtime = newtime(1:indx(1));
plot(newtime, 'g');

ts10 = timeseries(table10(:,2), table10(:,1));
newt10 = resample(ts10, newtime);
[newpxx, newf] = plomb(newt10.data, newtime, 12);
figure(4);
plot(newf, newpxx);