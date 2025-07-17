# example PH model works

    Code
      ph_fit$reg_pars
    Output
              x1         x2 
       0.7791292 -0.7800015 

---

    Code
      ph_fit$bsMat
    Output
      NULL

---

    Code
      ph_fit$T_bull_Intervals
    Output
                [,1]      [,2]      [,3]      [,4]      [,5]      [,6]      [,7]
      [1,] 0.3483021 0.4925961 0.5421304 0.6603322 0.7621515 0.8413517 0.8658642
      [2,] 0.3538842 0.4933187 0.5467078 0.6646182 0.7954380 0.8479649 0.9259429
                [,8]      [,9]    [,10]    [,11]    [,12]    [,13]    [,14]    [,15]
      [1,] 0.9692088 0.9806413 1.032365 1.064375 1.137560 1.218179 1.314497 1.359312
      [2,] 0.9730711 0.9910992 1.042981 1.078483 1.154219 1.223836 1.323303 1.359400
              [,16]    [,17]    [,18]    [,19]    [,20]    [,21]    [,22]    [,23]
      [1,] 1.366205 1.417251 1.440519 1.493582 1.512823 1.627655 1.740009 1.834121
      [2,] 1.384199 1.426120 1.446974 1.505619 1.517324 1.641585 1.787192 1.861480
              [,24]    [,25]    [,26]    [,27]    [,28]    [,29]    [,30]    [,31]
      [1,] 1.922024 1.932194 1.995500 2.007685 2.179980 2.245212 2.308476 2.352439
      [2,] 1.929939 1.956713 1.996221 2.009043 2.233444 2.287490 2.311413 2.355616
              [,32]    [,33]    [,34]    [,35]    [,36]    [,37]    [,38]
      [1,] 2.421321 2.507620 2.600047 2.701019 2.771134 2.815559 3.059271
      [2,] 2.444005 2.512453 2.692233 2.721108 2.797920 2.948664 3.108327

---

    Code
      ph_fit$p_hat
    Output
       [1] 0.035597337 0.001370274 0.000000000 0.000000000 0.121412246 0.026162185
       [7] 0.000000000 0.000000000 0.000000000 0.000000000 0.078164532 0.016630263
      [13] 0.141960210 0.000000000 0.000000000 0.011328322 0.000000000 0.000000000
      [19] 0.000000000 0.000000000 0.000000000 0.000000000 0.046574209 0.111461872
      [25] 0.000000000 0.000000000 0.000000000 0.094094371 0.000000000 0.046494071
      [31] 0.000000000 0.000000000 0.114612117 0.000000000 0.000000000 0.021402584
      [37] 0.067541107 0.065194299

---

    Code
      s_ph
    Output
      
      Model:  Cox PH
      Dependency structure assumed: Independence
      Baseline:  semi-parametric 
      Call: ic_sp(formula = Surv(l, u, type = "interval2") ~ x1 + x2, data = sim_data)
      
         Estimate Exp(Est)
      x1   0.7791   2.1800
      x2  -0.7800   0.4584
      
      final llk =  -110.8563 
      Iterations =  14 
      Bootstrap Samples =  0 
      WARNING: only  0  bootstrap samples used for standard errors. 
      Suggest using more bootstrap samples for inference

# example PO model works

    Code
      summary(po_fit)
    Output
      
      Model:  Proportional Odds
      Dependency structure assumed: Independence
      Baseline:  semi-parametric 
      Call: ic_sp(formula = Surv(l, u, type = "interval2") ~ x1 + x2, data = sim_data, 
          model = "po")
      
         Estimate Exp(Est)
      x1   -1.150   0.3167
      x2    1.174   3.2350
      
      final llk =  -111.9402 
      Iterations =  10 
      Bootstrap Samples =  0 
      WARNING: only  0  bootstrap samples used for standard errors. 
      Suggest using more bootstrap samples for inference

