load 'pMetrics.mat' % Load metrics file from all patients - cell(32,5)

Gind1 = find (strcmp(pMetrics(:,1), 'Gensiosoff'));
Gind2 = find (strcmp(pMetrics(:,1), 'Gensioson'));
% Isolate in a cell the lines concerning the on-off patient
Gcell=pMetrics(Gind1:Gind2,:);

% save metrics in separate 1x4 arrays (I have four metrics)
% off medication
rRoff=Gcell{1,2};
rRoff=cell2mat(rRoff);
rLoff=Gcell{1,3};
rLoff=cell2mat(rLoff);
eRoff=Gcell{1,4};
eRoff=cell2mat(eRoff);
eLoff=Gcell{1,5};
eLoff=cell2mat(eLoff);

% on medication
rRon=Gcell{2,2};
rRon=cell2mat(rRon);
rLon=Gcell{2,3};
rLon=cell2mat(rLon);
eRon=Gcell{2,4};
eRon=cell2mat(eRon);
eLon=Gcell{2,5};
eLon=cell2mat(eLon);

%{
(rRon-rRoff)./rRoff*100

ans =

   -4.2632  -40.4287  -31.4756  -10.2389

(eRon-eRoff)./eRoff*100

ans =

  -57.6723  -84.8855  -57.7929  -43.3527

(rLon-rLoff)./rLoff*100

ans =

  -19.5347  -35.3271  -22.9357  -23.3537

(eLon-eLoff)./eLoff*100

ans =

  -30.9262  -55.2651  -48.0227  -36.5441
}%