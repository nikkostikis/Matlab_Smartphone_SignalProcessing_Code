function createSeparateFiles

% fin=fopen('wrapper.txt','r','n','UTF-8');

% fulltext=fileread('wrapper.txt');

% fid = fopen('wrapper.txt', 'rb');
fid = fopen('updrs_on_off.txt', 'rb');
b = fread(fid, '*uint8'); 
fclose(fid);

fulltext = native2unicode(b,'UTF-8');
fulltext=fulltext';

froms=strfind(fulltext,'From:');
pnumbers=strfind(fulltext,'Patient Number:');
eols=strfind(fulltext,char(10));
files=cell(length(froms),1);
for i=1:length(froms)
    if i==length(froms)
        files(i)=cellstr(fulltext(froms(i):length(fulltext)));
    else
        files(i)=cellstr(fulltext(froms(i):froms(i+1)-1));
    end
    temp=find(eols>pnumbers(i));
    nameline=fulltext(pnumbers(i):eols(temp(1))-1);
    name=nameline(17:length(nameline));
%     name=unicode2native(   , 'UTF-8'  );
    
    fout=strcat('UPDRSs/',name,'.txt');
    fid = fopen(fout, 'w');
    str=files{i};
    encoded_str = unicode2native(str, 'UTF-8');
    fwrite(fid, encoded_str, 'uint8');
%     fwrite(fid, str, 'uint8');

    fclose(fid);
%     pause;
end


% pause;