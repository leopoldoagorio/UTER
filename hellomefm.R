library(MEFM)

formula.hh <- list()
#p: log(y-o) = h(t) + f(T,t)+cjzj(t)+n(t)
#p ecuaciones, en cada una h=calendario
# f(T,t) efecto de temperatura de las dos estaciones
# cjzj efectos socioeconomicos
# n ruido
for(i in 1:48)
  formula.hh[[i]] = as.formula(log(ddemand) ~ ns(temp, df=2) + day 
                               + holiday + ns(timeofyear, 9) + ns(avetemp, 3) + ns(dtemp, 3) + ns(lastmin, 3) 
                               + ns(prevtemp1, df=2) + ns(prevtemp2, df=2) 
                               + ns(prevtemp3, df=2) + ns(prevtemp4, df=2) 
                               + ns(day1temp, df=2) + ns(day2temp, df=2) 
                               + ns(day3temp, df=2) + ns(prevdtemp1, 3) + ns(prevdtemp2, 3) 
                               + ns(prevdtemp3, 3) + ns(day1dtemp, 3))


# formula for annual model, to be given by the user
formula.a <- as.formula(anndemand ~ gsp + ddays + resiprice)

# create lagged temperature variables
sa <- maketemps(sa,2,48)

sa.model <- demand_model(sa, sa.econ, formula.hh, formula.a)

summary(sa.model$a)
summary(sa.model$hh[[33]]) 

# Simulate future normalized half-hourly data
simdemand <- simulate_ddemand(sa.model, sa, simyears=10)

# seasonal economic and weather forecast, to be given by user
afcast <- data.frame(pop=1694, gsp=22573, resiprice=34.65, ddays=642)

# Simulate half-hourly data
demand <- simulate_demand(simdemand, afcast)

# Illustrate the results
plot(density(demand$annmax, bw="SJ"),
     main="Density of seasonal maximum demand", xlab="Demand")
