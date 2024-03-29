% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{score.proc}
\alias{score.proc}
\title{Computes the standardized score processes}
\usage{
score.proc(obj, t = NULL)
}
\arguments{
\item{obj}{an object of class pwreg.}

\item{t}{a vector containing times. If not specified, the function will use
all unique event times from the data.}
}
\value{
An object of class \code{pwreg.score} consisting of \code{t:}
a vector of times; and \code{score:} a matrix whose rows are the standardized score processes
as a function of \code{t}.
}
\description{
Computes the standarized score processes for the covariates.
}
\examples{
library(WR)
head(non_ischemic)

# Randomly sample 200 subjects from non_ischemic data
id_unique <-unique(non_ischemic$ID)
set.seed(2019)
id_sample <- sample(id_unique, 200)
non_ischemic_reduce <- non_ischemic[non_ischemic$ID \%in\% id_sample, ]

# Use the reduced non_ischemic data for analysis
nr <- nrow(non_ischemic_reduce)
p <- ncol(non_ischemic_reduce)-3
ID <- non_ischemic_reduce[,"ID"]
time <- non_ischemic_reduce[,"time"]
status <- non_ischemic_reduce[,"status"]
Z <- as.matrix(non_ischemic_reduce[,4:(3+p)],nr,p)
pwreg.obj <- pwreg(time=time,status=status,Z=Z,ID=ID)
score.obj <- score.proc(pwreg.obj)
#plot the standardized score process for the first covariate
plot(score.obj, k = 1)
}
\references{
Mao, L. and Wang, T. (2020). A class of proportional win-fractions
regression models for composite outcomes. Biometrics, 10.1111/biom.13382
}
\seealso{
\code{\link{pwreg}}, \code{\link{print.pwreg}}
}
\keyword{pwreg}
