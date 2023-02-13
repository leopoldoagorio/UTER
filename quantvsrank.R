#define PoE function with quantile function given the time series
PoEquant <- function(x) {
  xp = (1:100)/100
  yp = quantile(x, 1-xp)
  return(data.frame(xp,yp))
}
#empiric PoE function given the time series
PoEemp <- function(x) {
  ordmaxs <- x[order(x, decreasing = TRUE)]
  Rank <- 1:length(x)
  DF <- data.frame(ordmaxs, Rank)
  DF$Prob <-  DF$Rank/(length(DF$Rank) + 1)
  xp = DF$Prob
  yp = DF$ordmaxs
  return(data.frame(xp,yp))
}

#given the PoE DF, calculates PoE p% with NO time series
PoEatp <- function(x, p) {
  xp = x[,1]
  yp = x[,2]
  #return(yp[which(xp == p)]) not working, must find greater than
  return(yp[which(xp >= p)[1]])
}

vector_data <- c(2.152259, 2.154761, 2.035851, 2.655967, 2.187733, 2.019888, 2.607536, 2.358045, 2.612438, 2.194459, 2.725004, 2.444190, 2.131163, 2.446525, 2.101101,
2.237056, 2.230318, 2.805896, 2.453244, 2.177886, 2.025021, 2.356072, 2.324823, 3.173952, 2.172993, 2.103189, 2.128990, 2.335912, 2.714424, 2.461500,
2.319471, 2.192701, 2.181006, 2.406387, 1.887279, 2.156535, 2.502106, 2.329206, 2.332971, 1.973604, 2.252254, 2.199198, 2.125621, 2.297820, 2.119982,
2.144124, 2.004545, 2.865188, 2.150243, 2.158967, 3.348151, 2.132438, 3.053091, 3.141912, 2.694151, 2.601074, 2.353471, 2.076837, 3.100880, 2.455450,
2.017996, 2.144436, 2.502861, 2.400786, 2.713637, 2.620878, 2.420127, 2.907013, 1.996426, 2.873372, 1.964446, 2.807749, 2.398877, 2.607785, 2.304855,
2.212907, 2.683464, 2.392349, 2.184720, 1.971262, 2.549911, 1.924287, 2.146612, 1.817826, 2.244767, 2.588093, 2.584259, 2.557858, 2.590748, 2.329899,
2.361720, 2.446557, 2.328364, 2.277884, 1.749324, 1.745338, 2.261042, 2.420778, 2.047919, 2.103609)

vector_data <-c(2.152259, 2.154761, 2.035851, 2.655967, 2.187733, 2.019888, 2.607536, 2.358045, 2.612438, 2.194459, 2.725004, 2.444190, 2.131163, 2.446525, 2.101101)

#plot PoE in both cases in the same plot with ggplot2 title and legend for each method
ggplot() +
  geom_line(data = PoEquant(vector_data), aes(x = xp, y = yp, color = "Quantile")) +
  geom_line(data = PoEemp(vector_data), aes(x = xp, y = yp, color = "Rank")) +
  labs(title = "PoE", x = "Probability", y = "Value") +
  scale_x_continuous(breaks = seq(0, 1, by = 0.20), labels = percent) +
  scale_y_continuous() +
  theme(legend.position = "bottom") +
  scale_color_manual(values = c("Quantile" = "red", "Rank" = "blue"), 
                     labels = c("Quantile method", "Empiric method"))

# print poe at 0.95 for both methods
print("PoE at 0.95 for quantile method")
PoEatp(PoEquant(vector_data), 0.95)
print("PoE at 0.95 for empiric method")
PoEatp(PoEemp(vector_data), 0.95)
