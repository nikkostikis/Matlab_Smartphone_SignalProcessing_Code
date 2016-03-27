cell1=pData(4,:); %Bilika
cell2=cell1(1,8:9); %keep only name and rest right, 2 efforts

rr1=cell2{1,1}; %rest right effort 1
rr2=cell2{1,2}; %rest right effort 2
rr1_rv_xyz=rr1(:,4:6); %rest right rot velocity effort 1
rr2_rv_xyz=rr2(:,4:6); %rest right rot velocity effort 2

% amp_rr1_x=nikfft(rr1_rv_xyz,500,20,1);
% amp_rr1_x=nikfft(rr1_rv_xyz(:,1),500,20,1);
% amp_rr1_x=nikfft(rr1_rv_xyz(:,2),500,20,1);
% amp_rr1_x=nikfft(rr1_rv_xyz(:,3),500,20,1);


plot(amp_rr1_x,'DisplayName','amp_rr1_x','YDataSource','amp_rr1_x');figure(gcf)

[Pxx,f] = pwelch(rr1_rv_xyz(:,1),64,60,[],20);
plot(f,Pxx);

[Pxx,f] = pwelch(rr1_rv_xyz(:,2),64,60,[],20);
plot(f,Pxx);

[Pxx,f] = pwelch(rr1_rv_xyz(:,3),64,60,[],20);
plot(f,Pxx);

[Pxx,f] = pwelch(rr2_rv_xyz(:,1),64,60,[],20);
plot(f,Pxx);

[Pxx,f] = pwelch(rr2_rv_xyz(:,2),64,60,[],20);
plot(f,Pxx);

[Pxx,f] = pwelch(rr2_rv_xyz(:,3),64,60,[],20);
plot(f,Pxx);