test_that("example PH model works", {
  set.seed(1)
  
  sim_data <- simIC_weib(n = 100, inspections = 5, inspectLength = 1)
  ph_fit <- ic_sp(Surv(l, u, type = 'interval2') ~ x1 + x2, data = sim_data)	
  # Default fits a Cox-PH model
  
  expect_true(inherits(ph_fit, "ic_ph"))
  
  expect_equal(ph_fit$reg_pars, c(x1 = 0.779129170, x2 = -0.780001493))
  expect_snapshot(ph_fit$reg_pars)

  expect_snapshot(ph_fit$bsMat)
  expect_null(ph_fit$bsMat)

  expect_equal(ph_fit$model, "ph")
  
  expect_snapshot(ph_fit$T_bull_Intervals)
  expect_equal(dim(ph_fit$T_bull_Intervals), c(2, 38))
  expect_equal(sum(ph_fit$T_bull_Intervals), 124.489860)
  
  expect_snapshot(ph_fit$p_hat)
  expect_length(ph_fit$p_hat, 38)
  expect_equal(sum(ph_fit$p_hat), 1)


  expect_equal(ph_fit$llk, -110.85635)
  expect_equal(ph_fit$iterations, 14)

  s_ph <- summary(ph_fit)		
  expect_snapshot(s_ph)
  
})
  
test_that("example PO model works", {
  set.seed(1)
  
  sim_data <- simIC_weib(n = 100, inspections = 5, inspectLength = 1)

  # plotting the estimated survival curves
  
  po_fit <- ic_sp(Surv(l, u, type = 'interval2') ~ x1 + x2, 
  data = sim_data, model = 'po')
  # fits a proportional odds model
  
  expect_snapshot(summary(po_fit))
})
