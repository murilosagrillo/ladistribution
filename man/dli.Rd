% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dli.R
\name{dli}
\alias{dli}
\title{The LA and LI distribution}
\usage{
dli(y, alpha, gama, L, log = FALSE)
}
\arguments{
\item{y}{vector of quantiles.}

\item{alpha}{parameter 1.}

\item{gama}{parameter 2.}

\item{L}{parameter 3.}

\item{log}{logical; if TRUE, probabilities p are given as log(p)}
}
\description{
Probability density function of the LI distribution.
}
\examples{

dli(y=0.43,alpha=-10,gama=1.5,L=4)

}
