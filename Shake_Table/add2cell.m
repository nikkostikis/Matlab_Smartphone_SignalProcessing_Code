% Used to add imported vectors to a cell
% The offset is used for the native app collection which has NaNs 
% at the beginning. 

% prefix = 'i4s_';
% prefix = 'i4_';
% prefix = 'i6_';
prefix = 'andro_';
offset = 10;
% offset = 1;
for i = 2:10
    name = strcat(prefix, num2str(i))
    x = eval(name);
    x = x(offset:end);
%     i6_js(i) = {x};
%     i4s_js(i) = {x};
%     i4_js(i) = {x};
%     andro_js(i) = {x};
%     i4s_ntv(i) = {x};
%     i4_ntv(i) = {x};
    andro_ntv(i) = {x};
end