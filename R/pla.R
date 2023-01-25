#'The LA and LI distribution
#'
#'Cumulative density function of the LA distribution.
#'
#'@param q vector of quantiles.
#'@param alpha parameter 1.
#'@param gama  parameter 2.
#'@param L parameter 3.
#'@param log logical; if TRUE, probabilities p are given as log(p)
#'
#'@examples
#'
#'pla(q=0.5925,alpha=-10,gama=1.5,L=4)
#'
#'@export
pla <- Vectorize(function(q,alpha,gama,L,log.p = FALSE){
  cdf <- 1-(1-(L*q^2/(gama+L*q^2))^L)^(-alpha)
  val <- round(ifelse(log.p, log(cdf), cdf),4)
  return(val)
})
