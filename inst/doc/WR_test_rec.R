## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=F-------------------------------------------------------------------
#  obj<-WRrec(ID,time,status,trt)

## ----setup--------------------------------------------------------------------
library(WR)
head(hfaction_cpx9)

## -----------------------------------------------------------------------------
## simplify the dataset name
dat<-hfaction_cpx9
## comparing exercise training to usual care by LWR, FWR, and NWR
obj<-WRrec(ID=dat$patid,time=dat$time,status=dat$status,
          trt=dat$trt_ab,strata=dat$age60,naive=TRUE)
## print the results
obj

## -----------------------------------------------------------------------------
######################################
## Remove recurrent hospitalization ##
######################################
## sort dataset by patid and time
o<-order(dat$patid,dat$time)
dat<-dat[o,]
## retain only the first hospitalization
datHF<-dat[!duplicated(dat[c("patid","status")]),]
head(datHF)

## -----------------------------------------------------------------------------
## Perform the standard win ratio test
objSWR<-WRrec(ID=datHF$patid,time=datHF$time,status=datHF$status,
          trt=datHF$trt_ab,strata=datHF$age60)
## print the results
objSWR

