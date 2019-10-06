## ---- echo = FALSE, message = FALSE--------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(WR)
head(non_ischemic)

## ------------------------------------------------------------------------
colnames(non_ischemic)[4:16]=c(
  "Training vs Usual","Age (year)","Male vs Female","Black vs White", 
  "Other vs White", "BMI","LVEF","Hypertension","COPD","Diabetes",
  "ACE Inhibitor","Beta Blocker", "Smoker"
)

## ------------------------------------------------------------------------
# sample size
length(unique(non_ischemic$ID))
# median length of follow-up time
median(non_ischemic$time[non_ischemic$status<2])/30.5

## ------------------------------------------------------------------------
# get the number of rows and number of covariates.
nr <- nrow(non_ischemic)
p <- ncol(non_ischemic)-3

# extract ID, time, status and covariates matrix Z from the data.
# note that: ID, time and status should be column vector.
# covariatesZ should be (nr, p) matrix.
ID <- non_ischemic[,"ID"]
time <- non_ischemic[,"time"]
status <- non_ischemic[,"status"]
Z <- as.matrix(non_ischemic[,4:(3+p)],nr,p)


# pass the parameters into the function
pwreg.obj <- pwreg(time=time,status=status,Z=Z,ID=ID)
print(pwreg.obj)

## ------------------------------------------------------------------------
#extract estimates of (\beta_4,\beta_5)
beta <- matrix(pwreg.obj$beta[4:5])
#extract estimated covariance matrix for (\beta_4,\beta_5)
Sigma <- pwreg.obj$Var[4:5,4:5]
#compute chisq statistic in quadratic form
chistats <- t(beta) %*% solve(Sigma) %*% beta  

#compare the Wald statistic with the reference
# distribution of chisq(2) to obtain the p-value
1 - pchisq(chistats, df=2)

## ---- fig.height = 8, fig.width=7.5--------------------------------------
score.obj <- score.proc(pwreg.obj)
print(score.obj)

oldpar <- par(mfrow = par("mfrow"))
par(mfrow = c(4,4))
for(i in c(1:13)){
  plot(score.obj, k = i)
}
par(oldpar)

