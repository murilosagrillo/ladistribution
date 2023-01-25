#'The LA and LI distribution
#'
#'Random generation for the LA distribution.
#'
#'@param n number of observations. If length(n) > 1, the length is taken to be the number required.
#'@param alpha parameter 1.
#'@param gama  parameter 2.
#'@param L parameter 3.
#'
#'@examples
#'
#'rla(n=1000,alpha=-2,gama=2,L=3)
#'
#'@export
rla <- function(n,alpha,gama,L){
  u <- runif(n)
  val <- sqrt(gama*L^(-1)*(-1+(1-(1-u)^(-1/alpha))^(-1/L))^(-1))
  return(val)
}
