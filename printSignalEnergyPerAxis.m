% called by unifySignalsAll

function maxEnergyIndex = printSignalEnergyPerAxis(name, signal, lbl)



name
lbl
energyX = sum(signal(:,1).^2);
energyY = sum(signal(:,2).^2);
energyZ = sum(signal(:,3).^2);

energyVec = [energyX energyY energyZ];
maxEnergyIndex = find(energyVec == max(energyVec));


fid = fopen('energyPerAxis.txt', 'a+');

fprintf(fid, '\n\nName: %s \t Label: %s \n', name, lbl);
fprintf(fid, '%f \t %f \t %f \t \n', energyX, energyY, energyZ);

fclose(fid);



