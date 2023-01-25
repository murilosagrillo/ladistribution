#'The LA and LI distribution
#'
#'Probability density function of the LA distribution.
#'
#'@param y vector of quantiles.
#'@param alpha parameter 1.
#'@param gama  parameter 2.
#'@param L parameter 3.
#'@param log logical; if TRUE, probabilities p are given as log(p)
#'
#'@examples
#'
#'dla(y=0.43,alpha=-10,gama=1.5,L=4)
#'
#'@export
dla <- Vectorize(function(y,alpha,gama,L,log = FALSE){
  logden = log(-2*alpha*gama*((L*y^2/(L*y^2+gama)))^(1+L)*(1-((L*y^2/(L*y^2+gama)))^L)^(-1-alpha)*y^(-3))
  val = round(ifelse(log, logden, exp(logden)),4)
  return(val)
})
