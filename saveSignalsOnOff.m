function saveSignalsOnOff(folder, fold)
%it is called for every individual separateley and creates the pData.mat.
%pData.mat is a cell containing 9 columns for each individual:
% (1)Name, 
% (2)RestR1[500,6], 
% (3)RestR2[500,6], 
% (4)RestL1[500,6], 
% (5)RestL2[500,6], 
% (6)ExtR1[500,6], 
% (7)ExtR2[500,6], 
% (8)ExtL1[500,6], 
% (9)ExtL2[500,6]

dirname=strcat(fold, folder);

D=dir(dirname);
D=D(3:length(D)); %this needs xtra attention. Check the count of files to be sure. 
                    %In MacOS I need to start at 4, maybe Windows differs. 
                    %Also, the slash may need to be changed

load 'pDataOnOff.mat';
inext=min( find( cellfun( 'isempty',pDataOnOff(:,1) ) ) );
pDataOnOff{inext,1}=folder;

rrc=0;
rlc=0;
erc=0;
elc=0;

for j=1:length(D);
    j;
    fname=D(j).name;
    idx=find(fname=='_');
    
    if (~isempty(strfind(fname,'RawDataUniversal'))) %handle only files with signal, not time
        fname;
        rawData=load(strcat(dirname,'/',fname)); %10 cols: a/a,x,y,z,a,b,c,as,bs,cs , where 'as' stands for alpha/sec
        sig=rawData(101:600,[2:4 8:10]); %500 samples x as, bs, cs
        
        %choose where to save the signal
        if (strfind(fname,'rest'))

            if (strfind(fname,'right')) %col 2,3
                rrc=rrc+1;
                if (rrc==1) %col 2
                    pDataOnOff{inext,2}=sig;
                else %col 3
                    pDataOnOff{inext,3}=sig;
                end
            elseif (strfind(fname,'left')) %col 4,5
                rlc=rlc+1;
                if (rlc==1) %col 4
                    pDataOnOff{inext,4}=sig;
                else %col 5
                    pDataOnOff{inext,5}=sig;    
                end
                
            end
            
        elseif (strfind(fname,'Extended'))

            if (strfind(fname,'right')) %col 6,7
                erc=erc+1;
                if (erc==1) %col 6
                    pDataOnOff{inext,6}=sig;
                else %col 7
                    pDataOnOff{inext,7}=sig;    
                end
                
            elseif (strfind(fname,'left')) %col 8,9
                elc=elc+1;
                if (elc==1) %col 8
                    pDataOnOff{inext,8}=sig;
                else %col 9
                    pDataOnOff{inext,9}=sig;
                end
                
            end
            
        end    
        
        
    end
end
save 'pDataOnOff.mat' 'pDataOnOff';
return;