## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=F-------------------------------------------------------------------
#  obj<-WRSS(xi,bparam)

## ----eval=F-------------------------------------------------------------------
#  bparam<-base(lambda_D,lambda_H,kappa,tau_b,tau,lambda_L)

## ----eval=F-------------------------------------------------------------------
#  gum<-gumbel.est(id, time, status)

## ----setup--------------------------------------------------------------------
## load the package
library(WR)
## load the dataset
data(hfaction_cpx9)
dat<-hfaction_cpx9
head(dat)
## subset to the control group (usual care)
pilot<-dat[dat$trt_ab==0,]


## -----------------------------------------------------------------------------
id<-pilot$patid
## convert time from month to year
time<-pilot$time/12
status<-pilot$status
## compute the baseline parameters for the Gumbel--Hougaard
## copula for death and hospitalization
gum<-gumbel.est(id, time, status)
gum
lambda_D<-gum$lambda_D
lambda_H<-gum$lambda_H
kappa<-gum$kappa

## -----------------------------------------------------------------------------
## max follow-up 4 years
tau<-4
## 3 years of initial accrual
tau_b<-3
## loss to follow-up hazard rate
lambda_L=0.05
## compute the baseline parameters
bparam<-base(lambda_D,lambda_H,kappa,tau_b,tau,lambda_L)
bparam

## -----------------------------------------------------------------------------
## effect size specification
thetaD<-seq(0.6,0.95,by=0.05) ## hazard ratio for death
thetaH<-seq(0.6,0.95,by=0.05) ## hazard ratio for hospitalization

## create a matrix "SS08" for sample size powered at 80% 
## under each combination of thetaD and thetaH
mD<-length(thetaD)
mH<-length(thetaH)
SS08<-matrix(NA,mD,mH)
rownames(SS08)<-thetaD
colnames(SS08)<-thetaH
## fill in the computed sample size values
for (i in 1:mD){
  for (j in 1:mH){
    ## sample size under hazard ratios thetaD[i] for death and thetaH[j] for hospitalization
    SS08[i,j]<-WRSS(xi=log(c(thetaD[i],thetaH[j])),bparam=bparam,q=0.5,alpha=0.05,
                       power=0.8)$n
  }
}
## print the calculated sample sizes
print(SS08)

## repeating the same calculation for power = 90%
SS09<-matrix(NA,mD,mH)
rownames(SS09)<-thetaD
colnames(SS09)<-thetaH
## fill in the computed sample size values
for (i in 1:mD){
  for (j in 1:mH){
     ## sample size under hazard ratios thetaD[i] for death and thetaH[j] for hospitalization
    SS09[i,j]<-WRSS(xi=log(c(thetaD[i],thetaH[j])),bparam=bparam,q=0.5,alpha=0.05,
                       power=0.9)$n
  }
}
## print the calculated sample sizes
print(SS09)

## ---- fig.height = 9, fig.width=7---------------------------------------------
oldpar <- par(mfrow = par("mfrow"))
par(mfrow=c(2,1))
persp(thetaD, thetaH, SS08/1000, theta = 50, phi = 15, expand = 0.8, col = "gray",
      ltheta = 180, lphi=180, shade = 0.75,
      ticktype = "detailed",
      xlab = "\n HR on Death", ylab = "\n HR on Hospitalization",
      zlab=paste0("\n Sample Size (10e3)"),
      main="Power = 80%",
      zlim=c(0,26),cex.axis=1,cex.lab=1.2,cex.main=1.2
)
persp(thetaD, thetaH, SS09/1000, theta = 50, phi = 15, expand = 0.8, col = "gray",
      ltheta = 180, lphi=180, shade = 0.75,
      ticktype = "detailed",
      xlab = "\nHR on Death", ylab = "\nHR on Hospitalization",
      zlab=paste0("\n Sample Size (10e3)"),
      main="Power = 90%",
      zlim=c(0,26),cex.axis=1,cex.lab=1.2,cex.main=1.2
)
par(oldpar)

