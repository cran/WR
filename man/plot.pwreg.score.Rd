% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generic.R
\name{plot.pwreg.score}
\alias{plot.pwreg.score}
\title{Plot the standardized score processes}
\usage{
\method{plot}{pwreg.score}(
  x,
  k,
  xlab = "Time",
  ylab = "Standardized score",
  lty = 1,
  frame.plot = TRUE,
  add = FALSE,
  ylim = c(-3, 3),
  xlim = NULL,
  lwd = 1,
  ...
)
}
\arguments{
\item{x}{an object of class \code{pwreg.score}.}

\item{k}{A positive integer indicating the order of covariate to be plotted. For example, \code{k=3} requests the standardized score process for the third covariate in the covariate matrix \code{Z}.}

\item{xlab}{a title for the x axis.}

\item{ylab}{a title for the y axis.}

\item{lty}{the line type. Default is 1.}

\item{frame.plot}{a logical variable indicating if a frame should be drawn in the 1D case.}

\item{add}{a logical variable indicating whether add to current plot?}

\item{ylim}{a vector indicating the range of y-axis. Default is (-3,3).}

\item{xlim}{a vector indicating the range of x-axis. Default is NULL.}

\item{lwd}{the line width, a positive number. Default is 1.}

\item{...}{further arguments passed to or from other methods}
}
\value{
A plot of the standardized score process for object \code{pwreg.score}.
}
\description{
Plot the standardized score processes.
}
\examples{
# see the example for score.proc
}
\seealso{
\code{\link{score.proc}}
}
\keyword{pwreg}
