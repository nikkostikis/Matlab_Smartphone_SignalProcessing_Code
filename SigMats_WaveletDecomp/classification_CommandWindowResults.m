Warning: Variable names were modified to make them valid MATLAB identifiers. 
> In genvalidnames at 81
  In @dataset/private/setvarnames at 40
  In dataset.dataset>dataset.dataset at 384
  In classifier at 59 
         x0    x1
    0    5     0 
    1    4     7 

    'TN:'    '1'    'TP:'    '0.63636'


idxvar =

    18    19    20    21    25    26


ans = 

    'RL2'    'RL3'    'RL4'    'RL5'    'RR1'    'RR2'

classifier
Warning: Variable names were modified to make them valid MATLAB identifiers. 
> In genvalidnames at 81
  In @dataset/private/setvarnames at 40
  In dataset.dataset>dataset.dataset at 384
  In classifier at 59 
         x0    x1
    0    6      2
    1    4     10

    'TN:'    '0.75'    'TP:'    '0.71429'


idxvar =

    16    21    25    26    29


ans = 

    'ER8'    'RL5'    'RR1'    'RR2'    'RR5'

classifier

sizetrain =

    17

Warning: Variable names were modified to make them valid MATLAB identifiers. 
> In genvalidnames at 81
  In @dataset/private/setvarnames at 40
  In dataset.dataset>dataset.dataset at 384
  In classifier at 59 
         x0    x1
    0    3     0 
    1    3     6 

    'TN:'    '1'    'TP:'    '0.66667'


negativeFeatures =

     7    13    14


idxvar =

     5     6    20    25


ans = 

    'EL5'    'EL6'    'RL4'    'RR1'

classifier

sizetrain =

    17


nTrees =

   800

Warning: Variable names were modified to make them valid MATLAB identifiers. 
> In genvalidnames at 81
  In @dataset/private/setvarnames at 40
  In dataset.dataset>dataset.dataset at 384
  In classifier at 59 
         x0    x1
    0    2     1 
    1    4     5 

    'TN:'    '0.66667'    'TP:'    '0.55556'


negativeFeatures =

     8    32


idxvar =

    15    18    20    21    25    26    27    29


ans = 

    'ER7'    'RL2'    'RL4'    'RL5'    'RR1'    'RR2'    'RR3'    'RR5'

classifier

sizetrain =

    16


nTrees =

   800

Warning: Variable names were modified to make them valid MATLAB identifiers. 
> In genvalidnames at 81
  In @dataset/private/setvarnames at 40
  In dataset.dataset>dataset.dataset at 384
  In classifier at 59 
         x0    x1
    0    4     0 
    1    4     6 

    'TN:'    '1'    'TP:'    '0.6'


negativeFeatures =

     7    12    13


idxvar =

     5    20    25    26    28    29


ans = 

    'EL5'    'RL4'    'RR1'    'RR2'    'RR4'    'RR5'

load('pDataAll_46.mat')
classifier
Error: File: classifier.m Line: 46 Column: 16
Unexpected MATLAB operator.
 
classifier

sizetrainOH =

    20


sizetrainPD =

    26

Each class must have training and prediction instances

nTrees =

        1000

Operation terminated by user during categorical/cellstr (line 12)


In classreg.learning.internal.ClassLabel/labels (line 134)
                Y = cellstr(this.L);

In classreg.learning.classif.ClassificationModel/get.ClassNames (line 60)
            cnames = labels(this.ClassSummary.ClassNames);

In classreg.learning.internal.DisallowVectorOps/subsref (line 21)
                [varargout{1:nargout}] = builtin('subsref',this,s);

In CompactTreeBagger/treeEval (line 1113)
                    cTreeNames = tree.ClassNames;

In TreeBagger>oobPermVarUpdate (line 1905)
    [sfitvar,~,yfitvar] = ...

In TreeBagger>localGrowTrees/loopBody (line 1808)
                    [slicedPrivOOBPermutedVarDeltaError, ...

In internal.stats.parallel.smartForSliceout (line 175)
            [slice{:}] = loopbody(iter, S);

In TreeBagger>localGrowTrees (line 1676)
            [trees, ...

In TreeBagger/growTrees (line 611)
            [trees, ...

In TreeBagger (line 485)
            bagger = growTrees(bagger,NTrees,'Options', parallelOptions, 'nprint', nprint);

In classifier (line 70)
b = TreeBagger(nTrees, train, ratingtrain, 'Method' , 'classification', 'oobpred', 'on',
'oobvarimp', 'on');
 
classifier

sizetrainOH =

    20


sizetrainPD =

    26


nTrees =

        1000

Warning: Variable names were modified to make them valid MATLAB identifiers. 
> In genvalidnames at 81
  In @dataset/private/setvarnames at 40
  In dataset.dataset>dataset.dataset at 384
  In classifier at 74 
         x0    x1
    0    20     0
    1     0    26

    'TN:'    'Inf'    'TP:'    'Inf'


negativeFeatures =

     7     9    14    32


idxvar =

     5    18    20    21    25    26    27    29


ans = 

    'EL5'    'RL2'    'RL4'    'RL5'    'RR1'    'RR2'    'RR3'    'RR5'

classifier

sizetrainOH =

    20


sizetrainPD =

    26


nTrees =

        1000

Warning: Variable names were modified to make them valid MATLAB identifiers. 
> In genvalidnames at 81
  In @dataset/private/setvarnames at 40
  In dataset.dataset>dataset.dataset at 384
  In classifier at 79 
         x0    x1
    0    14     6
    1     5    21


AUC =

    0.1346

    'TN:'    '0.7'    'TP:'    '0.80769'


negativeFeatures =

     7     8    32


idxvar =

     5    18    19    20    21    25    26    27    29


ans = 

    'EL5'    'RL2'    'RL3'    'RL4'    'RL5'    'RR1'    'RR2'    'RR3'    'RR5'

plot(XX,YY)
classifier

sizetrainOH =

    20


sizetrainPD =

    26


nTrees =

        1000

Warning: Variable names were modified to make them valid MATLAB identifiers. 
> In genvalidnames at 81
  In @dataset/private/setvarnames at 40
  In dataset.dataset>dataset.dataset at 384
  In classifier at 79 
         x0    x1
    0    15     5
    1     4    22


AUC =

    0.8654

    'TN:'    '0.75'    'TP:'    '0.84615'


negativeFeatures =

     8    12    13    32


idxvar =

     5    18    20    21    25    26    27    29


ans = 

    'EL5'    'RL2'    'RL4'    'RL5'    'RR1'    'RR2'    'RR3'    'RR5'

figure(300)
plot(XX,YY)
