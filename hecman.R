# library -----------------------------------------------------------------

source("estimate_parameter_function.R")

# preparation -------------------------------------------------------------

data <- read.csv("file.csv", header = TRUE)

para_0 <- numeric(3)

data_length <- length(data[, 1])



# function ----------------------------------------------------------------

# Y_i = B_2 %*% X + p ��(B_1 %*%  ��) + e
#�� �t�~���Y��

# (B_1 %*%  ��)
probit <- function(para) {
  ans <- 0
  
  for (i in 1:data_length) {
    v <-
      para[1] * data$aaa[i] + para[2] * data$bbb[i] + para[3] * data$ccc[i]
    
    p1 <- pnorm(v, mean = 0, sd = exp(para[4]))
    
    p2 <- 1 - p1
    
    
    likelihood <- (p1 ^ data$y[i]) * (p2 ^ (1 - data$y[i]))
    
    ans <- ans + log(likelihood)
    
  }
  
  return(ans)
  
}

#������Ăт����Ƃ��C0�ɂȂ�f�[�^����������
standardization <- function(para) {
  
  z <-
    (para[1] +0 data$aaa * para[2] + data$bbb * para[3] * data$ccc)/exp(para[4])
  
  return(z)
}

# ��(B_1 %*%  ��)
preparation <- function(z) {
  ans <- pnorm(z, mean = 0, sd = 1) / dnorm(z, mean = 0, sd = 1)
  
  return(ans)
}

# Y_i = B_2 %*% X + p ��(B_1 %*%  ��) + e
#  e^2 = (Y_i - B_2 %*% X + p ��(B_1 %*%  ��) )^2
# parameter B_2, p
reggrestion_func <- function(data,data_y) {
  
  b<-solve(t(data)%*%data) %*% t(data)%*%data_y
  
  return(b)
}