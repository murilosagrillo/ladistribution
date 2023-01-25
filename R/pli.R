#'The LA and LI distribution
#'
#'Cumulative density function of the LI distribution.
#'
#'@param q vector of quantiles.
#'@param alpha parameter 1.
#'@param gama  parameter 2.
#'@param L parameter 3.
#'@param log logical; if TRUE, probabilities p are given as log(p)
#'
#'@examples
#'
#'pli(q=0.3511,alpha=-10,gama=1.5,L=4)
#'
#'@export
pli <- Vectorize(function(q,alpha,gama,L,log.p = FALSE){
  cdf <- 1-(1-(L*q/(gama+L*q))^L)^(-alpha)
  val <- round(ifelse(log.p, log(cdf), cdf),4)
  return(val)
})

