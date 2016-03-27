function pmw=mw(A,B, column)

% A=deNaNize(A);
% B=deNaNize(B);

fprintf(strcat('\nMann-Whitney test for \t ', column, '\n\n'));%: h=1 if means are NOT the same\n');

[pmw,hMW] = ranksum(A,B,'alpha',0.01);
if hMW==1
    fprintf('MW says %s means not equal\n',column);
else
    fprintf('MW says %s means equal\n', column);
end 
pmw
% fprintf(strcat('end of Mann-Whitney test for \t ',column,' \n\n'));  

