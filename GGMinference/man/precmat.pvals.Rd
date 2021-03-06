% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MLpvals.R
\name{precmat.pvals}
\alias{precmat.pvals}
\title{P-values and confidence intervals based on the precision matrix (inverse covariance matrix)}
\usage{
precmat.pvals(X, standardize = FALSE, alpha = 0.05,
  theta0 = matrix(0, ncol(X), ncol(X)), pmethod = "BH",
  visual = FALSE)
}
\arguments{
\item{X}{Input matrix with \code{n} rows, each an observation vector.}

\item{standardize}{Should design matrix be standardized to unit column standard deviation.}

\item{alpha}{Level of the confidence intervals.}

\item{theta0}{(Optional) A \code{pxp} matrix for custom testing of hypothesis theta_ij = theta0_ij.}

\item{pmethod}{Method to use for multiple testing correction (one of 'holm', 'hochberg', 'hommel', 'bonferroni', 'BH',
BY','fdr', 'none'). The default is "BH".}

\item{visual}{Logical indicating whether a heatmap of adjusted p-values should be plotted. Default is False.}
}
\value{
Returns a list containing p-values, adjusted p-values, confidence intervals
and significant variables as specified below.
\item{pvals}{\code{pxp} matrix containing individual p-values for each parameter.}
\item{pvals.adjusted}{\code{pxp} matrix containing p-values for each parameter, corrected with a multiple-testing adjustment specified by \code{pmethod}.}
\item{conf.ints}{A list with two \code{pxp} matrices: the matrices hold upper and lower bounds of individual confidence intervals respectively (without
multiple testing adjustment).}
\item{selected}{A matrix with 2 columns where rows are pairs of coordinates of edges that are selected as significant at level \code{alpha} (with multiple testing adjustment as specified by
\code{pmethod}).}
}
\description{
P-values and confidence intervals for edge weights in high-dimensional
undirected Gaussian graphical models. The method is based on the inverse sample covariance estimator and works only when \code{ncol(X) < nrow(X)} (i.e. low-dimensional case).
}
\examples{
# Inference for edge weights using data generated from a Gaussian graphical model

library(MASS)
set.seed(1)

p <- 100
n <- 150
rho <-  0.3
Theta <- diag(p) + cbind(rho*diag(p)[,-1], rep(0,p)) + t(cbind(rho*diag(p)[,-1], rep(0,p)))

X <- mvrnorm(n, rep(0,p), Sigma = solve(Theta))

precmat.inference <- precmat.pvals(X, standardize = FALSE, alpha = 0.05,
                                   pmethod = "BH", visual = FALSE)

precmat.inference$p.values.adjusted

}
\references{
Janková, J. and van de Geer, S. (2015,2017,2018)
\emph{Inference in high-dimensional undirected graphical models}
\url{https://arxiv.org/abs/1801.08512}
}
