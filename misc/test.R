set.seed(1)

sim_data <- simIC_weib(n = 100, inspections = 5, inspectLength = 1)
ph_fit <- ic_sp(Surv(l, u, type = 'interval2') ~ x1 + x2, 
                data = sim_data)	

summary(ph_fit)		
