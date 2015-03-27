require(rjags)
require(coda.discrete.utils)
require(ggplot2)
require(gridExtra)

# Make the simulations reproducible
my.seed <- 1 # 1 is arbitrary. The rest of the simulation is deterministic given that initial seed.
set.seed(my.seed) 
inits <- list(.RNG.name = "base::Mersenne-Twister",
              .RNG.seed = my.seed)
              
model <- jags.model(
  'model.bugs')

samples <- 
  jags.samples(model,
               c('isAbetter', 'zA', 'zB'), 
               100000) 
               
print(coda.expectation(samples))
coda.density(samples)
coda.density2d(samples, "zA", "zB", print.marginals = TRUE)
