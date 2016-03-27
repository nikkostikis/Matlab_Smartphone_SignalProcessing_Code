function readScale
%I have a file created by automator where all the UPDRS text are combined.
%This function reads that file and extracts these metrics:
%Patient Number
%Hoehn/Yahr
%Tremor at Rest: Right Hand
%Tremor at Rest: Left Hand
%Hand Action Tremor: Right
%Hand Action Tremor: Left

%Upon completion it creates the following files:

%/--Not used anywhere
%metrics.mat
%names.mat
%--/

%uMetrics.mat containing 6 columns for every individual:
% (1)Name, 
% (2)RestR (scalar), 
% (3)RestL (scalar), 
% (4)ExtR (scalar), 
% (5)ExtL (scalar), 
% (6)HoehnYahr (scalar, NaN if nonexistent) 


fid = fopen('combined_from_Automator_2.txt', 'rb');
b = fread(fid, '*uint8'); 
fclose(fid);

fulltext = native2unicode(b,'UTF-8');
fulltext=fulltext';

ifroms=strfind(fulltext,'From:'); %indices where 'From:' label exists

ipnumbers=strfind(fulltext,'Patient Number:'); %indices where 'Patient Number:' label exists
ihoehnYahr=strfind(fulltext,'Hoehn/Yahr:'); %indices where 'Hoehn/Yahr:' label exists
irestRight=strfind(fulltext,'Tremor at Rest: Right Hand:'); %indices where 'Tremor at Rest: Right Hand:' label exists
irestLeft=strfind(fulltext,'Tremor at Rest: Left Hand:'); %indices where 'Tremor at Rest: Left Hand:' label exists
iextRight=strfind(fulltext,'Hand Action Tremor: Right:'); %indices where 'Hand Action Tremor: Right:' label exists
iextLeft=strfind(fulltext,'Hand Action Tremor: Left:'); %indices where 'Hand Action Tremor: Left:' label exists



ieols=strfind(fulltext,char(10)); %All the end of lines

files=cell(length(ifroms),1); %cell array with the fulltext of each file
names=cell(length(ifroms),1);
metrics=ones(length(ifroms),5).*-1;



%%%%%%%%%  for each file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(ifroms)
    
    %%%%%%%%%%%%  store file's fulltext  %%%%%%%%%%%%%%%%%%%%%%
    
    if i==length(ifroms) %if it's the last file's text
        files(i)=cellstr(fulltext(ifroms(i):length(fulltext)));
    else
        files(i)=cellstr(fulltext(ifroms(i):ifroms(i+1)-1));
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %locate where the next eol is after the current 'From:' -use the first from temp
    temp=find(ieols>ipnumbers(i)); 
    nameLine=fulltext(ipnumbers(i):ieols(temp(1))-1); %define the patient's nameline
    names(i)=cellstr( nameLine(17:length(nameLine)) ); %remove the 'Patient Number:' label (1:17)
    
    tempText=files{i};
    eols=strfind(tempText,char(10));
    
    restRight=strfind(tempText,'Tremor at Rest: Right Hand:'); %indices where 'Tremor at Rest: Right Hand:' label exists in file i
    restLeft=strfind(tempText,'Tremor at Rest: Left Hand:'); %indices where 'Tremor at Rest: Left Hand:' label exists in file i
    extRight=strfind(tempText,'Hand Action Tremor: Right:'); %indices where 'Hand Action Tremor: Right:' label exists in file i
    extLeft=strfind(tempText,'Hand Action Tremor: Left:'); %indices where 'Hand Action Tremor: Left:' label exists in file i
    hoehnYahr=strfind(tempText,'Hoehn/Yahr:'); %indices where 'Hoehn/Yahr:' label exists in file i
    
    %%%%%%%%%%%% Extract scores (rR, rL, eR, eL, hy) from file i %%%%%%%%
    
    %rR
    temp=find(eols>restRight); 
    restRightLine=tempText(restRight:eols(temp(1))-1);
    tempColon=strfind(restRightLine,':');
    rR=str2double( restRightLine( max(tempColon)+1 : length(restRightLine) ) );
    metrics(i,1)=rR;
    %rL
    temp=find(eols>restLeft); 
    restLeftLine=tempText(restLeft:eols(temp(1))-1);
    tempColon=strfind(restLeftLine,':');
    rL=str2double( restLeftLine( max(tempColon)+1 : length(restLeftLine) ) );
    metrics(i,2)=rL;
    %eR
    temp=find(eols>extRight); 
    extRightLine=tempText(extRight:eols(temp(1))-1);
    tempColon=strfind(extRightLine,':');
    eR=str2double( extRightLine( max(tempColon)+1 : length(extRightLine) ) );
    metrics(i,3)=eR;
    %eL
    temp=find(eols>extLeft); 
    extLeftLine=tempText(extLeft:eols(temp(1))-1);
    tempColon=strfind(extLeftLine,':');
    eL=str2double( extLeftLine( max(tempColon)+1 : length(extLeftLine) ) );
    metrics(i,4)=eL;
    %hy
    if (max(hoehnYahr)~=0)
        temp=find(eols>hoehnYahr); 
        hyLine=tempText(hoehnYahr:eols(temp(1))-1);
        tempColon=strfind(hyLine,'e');
        hy=str2double( hyLine( max(tempColon)+1 : length(hyLine) ) );

    else
        hy=NaN;
    end
    metrics(i,5)=hy;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
%     pause;

    


end
% fileSizes=cellfun('length',files);
% fileEnds=cumsum(fileSizes);
save 'metrics.mat' 'metrics';
save 'names.mat' 'names';
uMetrics=cell(length(ifroms),6);
uMetrics(:,1)=names;
cellMetrics=num2cell(metrics);
uMetrics(:,2:6)=cellMetrics;
uMetrics=sortrows(uMetrics,[1]);
save 'uMetrics.mat' 'uMetrics';
% pause;