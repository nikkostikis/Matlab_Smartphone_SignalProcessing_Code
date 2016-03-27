OH: 20
PD: 30

From PD I am usually removing 
Efthimiou, due to lack of observations (and bad quality - he was in wheelchair), 
Ximitidou, due to lack of observations,
Papadopoulou, due to outlier-ish values and
Ntavela,  due to outlier-ish values

-so, PD: 46

21 Alexiou 119 values above 20
30 Elanidou 89 values above 20
32 Fourkioti 7 values above 20
35 Kalianidis 271 values above 20
37 Koukouli 20 values above 20
41 Nikolaides 5 values above 20

wavDetCoefsPower_3_6_All = [wavDetCoefsPower_3_6_EL wavDetCoefsPower_3_6_ER wavDetCoefsPower_3_6_RL wavDetCoefsPower_3_6_RR];
wavCoefs = sum(wavDetCoefsPower_3_6_All')';