function compMetricsOnOff
% it calculates the metrics from the signals (pData.mat). It deletes
% uComMetrics and pComMetrics because these are created later on by
% correlation.m. They are the intersection of uMetrics and pMetrics 

L=500;
Fs=20;
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
f = Fs/2*linspace(0,1,NFFT/2+1);

load 'pDataOnOff.mat';

pMetricsOnOff=cell(4,5);

pMetricsOnOff(:,1)=pDataOnOff(:,1);

%one column for each metric - now I have four, 
%(1) accMagn & 
%(2) rvelMagn, 
%(3) rvelAmp
%(4) accSumDiff
metMat=cell(1,4); 

for i=1:4
    m=1;
    flag=0;
    for j=2:2:8
        accMagn=0;
        rvelMagn=0;
        rvelAmp=0;
        accSumDiff=0;
        if (~isempty(pDataOnOff{i,j})) %checking if there is effort 1
            tempMat=pDataOnOff{i,j};
            accMat=tempMat(:,1:3);
            rvelMat=tempMat(:,4:6);
            
            %signal power metric
            accMagn=sum( (accMat(:,1).^2+accMat(:,2).^2+accMat(:,3).^2) );
            rvelMagn=sum( (rvelMat(:,1).^2+rvelMat(:,2).^2+rvelMat(:,3).^2) );
            accSumDiff=sum( sum( abs( diff(accMat(:,1:3)) ) ) );
            
            %signal dominant frequency metric
%             accFpeak=zeros(1,3);
%             rvelFpeak=zeros(1,3);
            for k=1:3 %for all 3 axes
%                 accAmp=nikfft(accMat(:,k),L, Fs, 0);
%                 accFpeak(k)=f( find(accAmp==max(accAmp)) );
                rvelAmpF=nikfft(rvelMat(:,k),L, Fs, 0);
                rvelAmp=rvelAmp + max(rvelAmpF(104:182));%104:182 means 4-7Hz 78:208 means 3-8 Hz
%                 rvelFpeak(k)=f( find(rvelAmp==max(rvelAmp)) );
            end
                
            metMat={accMagn rvelMagn rvelAmp accSumDiff};
            flag=1;
            m=m+1;
            pMetricsOnOff{i,m}=metMat;
        end
        
        if (~isempty(pDataOnOff{i,j+1})) %checking if there is effort 2
            tempMat=pDataOnOff{i,j+1};
            accMat=tempMat(:,1:3);
            rvelMat=tempMat(:,4:6);
            
            %signal power metric
            accMagn=accMagn+sum( (accMat(:,1).^2+accMat(:,2).^2+accMat(:,3).^2) );
            rvelMagn=rvelMagn+sum( (rvelMat(:,1).^2+rvelMat(:,2).^2+rvelMat(:,3).^2) );
            accSumDiff=accSumDiff+sum( sum( abs( diff(accMat(:,1:3)) ) ) );
            %signal dominant frequency metric
%             accFpeak=zeros(1,3);
%             rvelFpeak=zeros(1,3);
            for k=1:3 %for all three axes
%                 accAmp=nikfft(accMat(:,k),L, Fs, 0);
%                 accFpeak(k)=f( find(accAmp==max(accAmp)) );
                rvelAmpF=nikfft(rvelMat(:,k),L, Fs, 0);
                rvelAmp=rvelAmp + max(rvelAmpF(104:182));%104:182 means 4-7Hz 78:208 means 3-8 Hz
%                 rvelFpeak(k)=f( find(rvelAmp==max(rvelAmp)) );
            end
            
            denom=2;
            if (flag==0) %there was no effort 1
                m=m+1;
                denom=1;
            end
            metMat={accMagn/denom rvelMagn/denom rvelAmp/denom accSumDiff/denom};
            pMetricsOnOff{i,m}=metMat; 
        end
    end
end
save 'pMetricsOnOff.mat' 'pMetricsOnOff';

return;