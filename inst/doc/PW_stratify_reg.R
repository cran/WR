## ---- echo = FALSE, message = FALSE-------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=F-------------------------------------------------------------------
#  obj<-pwreg(ID, time, status, Z, strata, fixedL=TRUE)

## ----eval=F-------------------------------------------------------------------
#  ## compute the standardized score processes
#  score<-score.proc(obj)
#  ## plot the computed process for the kth covariate
#  plot(score, k)

## ----setup--------------------------------------------------------------------
library(WR)
head(gbc)

## -----------------------------------------------------------------------------
grade_matrix <- model.matrix(~factor(grade),data=gbc)
grade_df <- as.data.frame(grade_matrix[,-1])
names(grade_df) <- c("grade2 vs grade1", "grade3 vs grade1")
gbc <- cbind.data.frame(gbc[,-8], grade_df)

## -----------------------------------------------------------------------------
## extract the covariate matrix Z from the data
## leaving out menopause as the stratifying variable
Z1 <- as.matrix(gbc[,c("hormone", "age", "size", "nodes", "prog_recp",
                       "estrg_recp", "grade2 vs grade1", "grade3 vs grade1")])

## fit a PW model stratified by the binary menopause status
## use type I variance estimator
obj1<-pwreg(ID=gbc$id,time=gbc$time,status=gbc$status, Z=Z1,strata=gbc$menopause,fixedL=TRUE)
## print out the results
print(obj1)

## ---- fig.height = 7.5, fig.width=7.5-----------------------------------------
score1 <- score.proc(obj1)
oldpar <- par(mfrow = par("mfrow"))
par(mfrow = c(3,3))
for(i in c(1:8)){
  plot(score1, k = i)
  abline(h = 0, col="blue",lty=2)
  abline(h = -2, col="blue",lty=2)
  abline(h =  2, col="blue",lty=2)
}
par(oldpar)

## -----------------------------------------------------------------------------
## cut age into ~30 groups by quantiles
cutpoints <- c(0,unique(quantile(gbc$age[gbc$status<2],
                        seq(0.1,1,by=0.02))),Inf)
cutpoints
age_group <- cut(gbc$age, breaks = cutpoints, right = FALSE)

## -----------------------------------------------------------------------------
## extract the covariate matrix Z from the data
## leaving out age as the stratifying variable
Z2 <- as.matrix(gbc[,c("hormone", "menopause", "size", "nodes", "prog_recp",
                       "estrg_recp", "grade2 vs grade1", "grade3 vs grade1")])

## fit a PW model stratified by the binary menopause status
## use type II variance estimator because L is large
obj2<-pwreg(ID=gbc$id,time=gbc$time,status=gbc$status, Z=Z2,strata=age_group,fixedL=TRUE)
## print out the results
print(obj2)

