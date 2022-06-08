p1 <- 8/41 # men
p2 <- 20/63 # women
z <- 1.96
N1 <- 41
N2 <- 63
#men as reference group
con_low <- p2 -p1 - z*sqrt(    (p1*(1-p1))/N1 + (p2*(1-p2))/N2     )
con_high <- p2 -p1 + z*sqrt(    (p1*(1-p1))/N1 + (p2*(1-p2))/N2     )

exp(0.7)

risk <- 1/(1+exp(  -(-16.04 + 0.22*53)    ))


odd_ratio <- exp(0.18*29)


con_low_1 <- exp(0.5341 - 1.96*0.3181)
con_high_1 <- exp(0.5341 + 1.96*0.3181)
