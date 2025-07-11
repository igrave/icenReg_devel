# Notes

## Stratified hazards for subgroups

In setup_icm, we need to make the following changes to allow stratified hazards for strata:
 - pass Rlind and Rrind as lists for each subgroup
 - pass RCovars as a list for each subgroup
 - pass R_w as a list for each subgroup
 - Give integer n_strata 

 Then loop over the n_strata and set up each strata.
 In the class definition, define the following to be vectors:
 -[x] base_p_obs
 -[x] etas
 -[x] expEtas
 -[x] w
 -[x] covars
 -[x] obs_inf
 -[x] node_inf 
 -[x] usedVec

-[x] baseCH
-[x] backupCH
-[x] dob_dp_both
-[x] dob_dp_rightOnly
-[x] baseS
-[x] base_p_derv
~~-[x] h ~~
-[x] prop_p
-[x] intercept

for outputs:
-[x] p_hat

The block starting `icm_obj->reg_d1.resize(reg_k);` 
can be moved out of the for loop over strata


### update functions

#### covar_nr_step()
- sum_llk()
- update_etas()

These look pretty straightforward.

#### stablizeBCH()

- baseCH I think will need to be per strata

#### icm_step()
- numericBaseDervsAllRaw() should get argument `s` for strata index

- par_llk() should also get argument `s` for strata index
- ice_addPar should also get argument `s` for strata index
- checkCH()

#### gradientDescent_step()
- baseCH_2_baseS
- baseS_2_baseP
- numeric_dobs_dp this one is only done for its side effects, so the loop could be internal

- llk_from_p
- baseP_2_baseS();
-[x] baseS_2_baseCH();

#### recenterBCH()
cumhaz2p_hat()
- R_pans




### Steps to implement stratified hazards

1. Add tests for current functionality
2. Set n_strata to 1 in the class definition
3. Adapt all of the functions to loop over strata
4. Finally allow n_strata > 1


## Profile Llikelihood

 Maybe we can set 
 `optObj->updateCovars = LOGICAL(R_updateCovars)[0] == FALSE;`
 for calculating the profile likelihood?

 Do we need to add this to the defintion of run?