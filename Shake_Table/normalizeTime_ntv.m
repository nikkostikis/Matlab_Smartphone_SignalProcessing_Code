nikCell = andro_ntv_t; tag = 'a';
% nikCell = i4_ntv_t; tag = 'i';
% nikCell = i4s_ntv_t; tag = 'i';

for i = 2:10
    x = nikCell{i};
    %there was a phone call at the end of 3Hz session for i4s
    if i == 3 && tag == 'i'
        x = x(1:5500);
    end
    
    %for Sensor Data
    if tag == 'i'
        x = x.*1000; %bring msecs in int part
    %for My Sensors - tag == 'a'
    else 
        x = x./1000000; %make less than msec decimal
    end
    x = floor(x); %remove decimal part
    dx = diff(x);
    xx = [0; cumsum(dx)];
    nikCell(i) = {xx};
end

andro_ntv_t_normalized = nikCell;
% i4_ntv_t_normalized = nikCell;
% i4s_ntv_t_normalized = nikCell;