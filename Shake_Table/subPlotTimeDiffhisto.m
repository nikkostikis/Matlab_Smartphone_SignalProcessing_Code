% nikCell = andro_js_t_normalized;
% nikCell = i4_js_t_normalized;
% nikCell = i4s_js_t_normalized;
% nikCell = i6_js_t_normalized;

% nikCell = i4_ntv_t_normalized;
% nikCell = i4s_ntv_t_normalized;
% nikCell = andro_ntv_t_normalized;

figure(200);
minimum = zeros(1,9);
maximum = zeros(1,9);
meanval = zeros(1,9);
stdev = zeros(1,9);
for i = 2:10
    x = nikCell{i};
    dx = diff(x);
    
    bins = unique(dx);
    
    minimum(i-1) = min(bins);
    maximum(i-1) = max(bins);
    meanval(i-1) = mean(dx);
    stdev(i-1) = std(dx);
    
    subplot(3,3,i-1);
    h = histogram(dx, linspace(min(bins), max(bins)));
end