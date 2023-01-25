#'The LA and LI distribution
#'
#'Probability density function of the LI distribution.
#'
#'@param y vector of quantiles.
#'@param alpha parameter 1.
#'@param gama  parameter 2.
#'@param L parameter 3.
#'@param log logical; if TRUE, probabilities p are given as log(p)
#'
#'@examples
#'
#'dli(y=0.43,alpha=-10,gama=1.5,L=4)
#'
#'@export
dli <- Vectorize(function(y,alpha,gama,L,log = FALSE){
  logden <- log(-L^(1 + L)* y^(-1 + L)* alpha *gama *(L* y +   gama)^(-1 - L)* (1 - L^L* y^(L) *(L *y + gama)^(-L))^(-1 - alpha))
  val <- round(ifelse(log, logden, exp(logden)),4)
  return(val)
})
