% called by unifySignalsAll

function maxEnergyIndex = printSignalEnergyPerAxis_NoFile(name, signal, lbl)



name
lbl
energyX = sum(signal(:,1).^2);
energyY = sum(signal(:,2).^2);
energyZ = sum(signal(:,3).^2);

energyVec = [energyX energyY energyZ];
maxEnergyIndex = find(energyVec == max(energyVec))