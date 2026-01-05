## ----include=FALSE------------------------------------------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance=TRUE
)


## ----echo = FALSE-------------------------------------------------------------------------------------------
# For consistency of poor mixing in Bayes example
set.seed(123)


## ----echo = FALSE-------------------------------------------------------------------------------------------
library(icenReg)


## -----------------------------------------------------------------------------------------------------------
data(miceData)
head(miceData, 3)


## -----------------------------------------------------------------------------------------------------------
np_fit = ic_np(cbind(l, u) ~ grp, data = miceData)


## -----------------------------------------------------------------------------------------------------------
groupedFit1 <- ic_np(cbind(l,u) ~ 0, data = miceData)
groupedFit2 <- ic_np(miceData[,c('l', 'u')])


## ----fig.height=5.5, fig.width=5.5--------------------------------------------------------------------------
plot(np_fit, col = c('blue', 'orange'),
     xlab = 'Time', ylab = 'Estimated Survival')


## -----------------------------------------------------------------------------------------------------------
data("IR_diabetes")
head(IR_diabetes, 3)


## -----------------------------------------------------------------------------------------------------------
  fit_ph <- ic_sp(cbind(left, right) ~ gender, model = 'ph', 
                  bs_samples = 100, data = IR_diabetes)
      
  fit_po <- ic_sp(cbind(left, right) ~ gender, model = 'po',
                  bs_samples = 100, data = IR_diabetes)


## -----------------------------------------------------------------------------------------------------------
  fit_po
  fit_ph


## ----fig.height=5.5, fig.width=5.5--------------------------------------------------------------------------
  newdata <- data.frame(gender = c('male', 'female') )
    
  rownames(newdata) <- c('males', 'females')

  plot(fit_po, newdata)


## -----------------------------------------------------------------------------------------------------------
fit_po_gamma <- ic_par(cbind(left, right) ~ gender,
    data = IR_diabetes, model = "po", dist = "gamma")


## -----------------------------------------------------------------------------------------------------------
fit_po_gamma


## ----fig.height=5.5, fig.width=5.5--------------------------------------------------------------------------
plot(fit_po_gamma, newdata, lgdLocation = "topright")


## -----------------------------------------------------------------------------------------------------------
flatPrior_fit <- ic_bayes(cbind(left, right) ~ gender,
    data = IR_diabetes, model = "po", dist = "gamma")


## -----------------------------------------------------------------------------------------------------------
flatPrior_fit


## -----------------------------------------------------------------------------------------------------------
head(flatPrior_fit$samples)  


## -----------------------------------------------------------------------------------------------------------
# Accessing the first few samples of the first chain
head(flatPrior_fit$mcmcList[[1]])
# Accessing the first few samples of the second chain
head(flatPrior_fit$mcmcList[[2]])


## -----------------------------------------------------------------------------------------------------------
head(flatPrior_fit$logPosteriorDensities[[1]])  


## ----fig.height=5.5, fig.width=5.5--------------------------------------------------------------------------
  plot(flatPrior_fit, newdata,
       main = 'Posterior Median Estimates')


## ----fig.height=7.5, fig.width=7.5--------------------------------------------------------------------------
  plot(flatPrior_fit$mcmcList)


## -----------------------------------------------------------------------------------------------------------
 logPriorFunction <- function(x){
   ans <- 0 
   ans <- ans + dnorm(x[1], sd = 0.1, log = T)
   # Tight prior about 1st parameter, log_shape
   ans <- ans + dnorm(x[2], sd = 10, log = T)
   # Diffuse prior about 2nd parameter, log_scale
   ans <- ans + dnorm(x[3], sd = 0.1, log = T)
   # Tight prior about 3rd parameter, regression parameter
   return(ans)
 }    
  
informPrior_fit <- ic_bayes(cbind(left, right) ~ gender,
    data = IR_diabetes, model = "po", dist = "gamma",
    logPriorFxn = logPriorFunction)
# Fitting model with prior. 

informPrior_fit


## ----fig.height=7.5, fig.width=7.5--------------------------------------------------------------------------
weak_data <- IR_diabetes[1:2,]
weakData_fit <- ic_bayes(cbind(left, right) ~ gender,
    data = weak_data,
    model = "po", dist = "gamma",
    logPriorFxn = logPriorFunction,
    controls = bayesControls(useMLE_start = F))

plot(weakData_fit$mcmcList)


## -----------------------------------------------------------------------------------------------------------
# Extract estimates for inverse CDF
invCDF_ests = survCIs(informPrior_fit, newdata, 
                      p = seq(from = 0.05, to = .95, by = 0.2))
# Extract estimates for *CDF* probabilities at given values
CDF_ests = survCIs(informPrior_fit, newdata, 
                   q = seq(from = 5, to = 25, by = 5))

invCDF_ests
CDF_ests


## ----fig.height=5.5, fig.width=5.5--------------------------------------------------------------------------
diag_baseline(cbind(left, right) ~ gender,
    model = "po",
    data = IR_diabetes,
    dists = c("exponential", "weibull", 
              "loglogistic", "gamma"),
    lgdLocation = "topright")


## -----------------------------------------------------------------------------------------------------------
diag_baseline(fit_po, lgdLocation = "topright",
              dists = c("exponential", "weibull", 
                        "loglogistic", "gamma")
              )


## -----------------------------------------------------------------------------------------------------------
diag_covar(fit_po, lgdLocation = "topright", 
           main = "Checking Proportional Odds")
diag_covar(fit_ph, lgdLocation = "topright", 
           main = "Checking Proportional Hazards")


## ----fig.height=5, fig.width=5, echo = FALSE----------------------------------------------------------------
diag_covar(fit_po, lgdLocation = "topright", 
           main = "Checking Proportional Odds")


## ----fig.height=4, fig.width=4, echo = FALSE----------------------------------------------------------------
diag_covar(fit_ph, lgdLocation = "topright", 
           main = "Checking Proportional Hazards")

