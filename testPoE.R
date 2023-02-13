library(ggplot2)
library(MEFM)
library(scales)

# Create a data frame with the data
set.seed(1234)
Aall <- sample(0:5000, 2500, prob = exp(seq(10, 0, length.out = 5001)))
A <- Aall[order(Aall, decreasing = TRUE)]
Rank <- 1:2500

DF <- data.frame(A, Rank)
DF$Prob <-  DF$Rank/(length(DF$Rank) + 1)

ggplot(data = DF, aes(x = Prob, y = A)) +
  geom_line() + 
  scale_x_continuous(breaks = seq(0, 1, by = 0.20),
                     labels = percent) +
  scale_y_continuous()#(trans = "log10")

