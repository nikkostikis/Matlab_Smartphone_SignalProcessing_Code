% nikCell = andro_js_t;
% nikCell = i4_js_t;
% nikCell = i4s_js_t;
% nikCell = i6_js_t;


for i = 2:10
    x = nikCell{i};
%     x = unique(x); %just in case
    dx = diff(x);
%     max(dx)
    idx = find(dx > 1000) %find the minute change/changes
    
    if length(idx) > 0 %there may be no nimute change
        dx(idx) = round(mean(dx(dx<1000))); %replace jump/jumps with rounded mean
    end
    xx = [0; cumsum(dx)];
    nikCell(i) = {xx};
end
% andro_js_t_normalized = nikCell;
% i4_js_t_normalized = nikCell;
% i4s_js_t_normalized = nikCell;
% i6_js_t_normalized = nikCell;
