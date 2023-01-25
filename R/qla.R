#'The LA and LI distribution
#'
#'Quantile function of the LA distribution.
#'
#'@param p vector of probabilities.
#'@param alpha parameter 1.
#'@param gama  parameter 2.
#'@param L parameter 3.
#'
#'@examples
#'
#'qla(p=0.4,alpha=-2,gama=2,L=3)
#'
#'@export
qla <- Vectorize(function(p,alpha,gama,L){
  val <- round(sqrt(gama*L^(-1)*(-1+(1-(1-p)^(-1/alpha))^(-1/L))^(-1)),4)
  return(val)
})
