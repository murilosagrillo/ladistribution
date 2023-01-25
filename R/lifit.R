#'The LA and LI Distribution
#'
#'Fit function for the LI distribution.
#'
#'@param alpha parameter 1.
#'@param gama  parameter 2.
#'@param L parameter 3.
#'@param x data
#'
#'@examples
#'
#'lifit(rli(n=1000,alpha=-10,gama=1.5,L=4))
#'
#'@import GenSA
#'
#'
#'@export
lifit <-function(x){
  x <- as.vector(x)
  n<-length(x)
  set.seed(137)

  fdpLI<-function(par){
    alpha=par[1]
    gama=par[2]
    L=par[3]
    (-L^(1 + L)*x^(-1 + L)* alpha *gama *(L* x +   gama)^(-1 - L)* (1 - L^L* x^(L) *(L *x + gama)^(-L))^(-1 - alpha))
  }

  l_theta<- function(par){
    sum(log(fdpLI(par)))
  }

  ##Initial genSA
  fit.sa3 <- function(x,fdpEPLW) {
    minusllike <- function(x) -sum(log(fdpLI(c(x[1],x[2],x[3]))))
    lower <- c(-100,0.001,0.001) #max need some changes here
    upper <- c(-0.1,20,20)
    out <- GenSA(lower = lower, upper = upper,
                 fn = minusllike, control=list(verbose=TRUE,max.time=2))
    return(out[c("value","par","counts")])
  }

  initial<-fit.sa3(x,fdpLI)$par
  #

  res<-optim(initial, l_theta, method="BFGS",#x=x,
             control=list(fnscale=-1, pgtol=1e-20, maxit=200))

  alpha_emv<-res$par[1]
  gama_emv<-res$par[2]
  L_emv<-res$par[3]

  density<-function(x){
    (-L_emv^(1 + L_emv)*x^(-1 + L_emv)* alpha_emv *gama_emv *(L_emv* x +   gama_emv)^(-1 - L_emv)* (1 - L_emv^L_emv* x^(L_emv) *(L_emv *x + gama_emv)^(-L_emv))^(-1 - alpha_emv))
  }

  p<-3
  AIC<-(-2*sum(log( (-L_emv^(1 + L_emv)*x^(-1 + L_emv)* alpha_emv *gama_emv *(L_emv* x +   gama_emv)^(-1 - L_emv)* (1 - L_emv^L_emv* x^(L_emv) *(L_emv *x + gama_emv)^(-L_emv))^(-1 - alpha_emv)) ))+2*p)

  emvs<-c(alpha_emv,gama_emv,L_emv)
  sorted_data = sort(x)
  cdfLI<-function(emvs,sorted_data){
    1-(1-(L_emv*sorted_data/(gama_emv+L_emv*sorted_data))^L_emv)^(-alpha_emv)
  }

  cdfLI_ks_test<-function(x,par){
    1-(1-(L_emv*x/(gama_emv+L_emv*x))^L_emv)^(-alpha_emv)
  }

  v = cdfLI(emvs, sorted_data)
  s = qnorm(v)
  u = pnorm((s - mean(s))/sqrt(var(s)))
  W_temp <- vector()
  A_temp <- vector()
  for (i in 1:n) {
    W_temp[i] = (u[i] - (2 * i - 1)/(2 * n))^2
    A_temp[i] = (2 * i - 1) * log(u[i]) + (2 * n + 1 - 2 * i) * log(1 - u[i])
  }
  A_2 = -n - mean(A_temp)
  W_2 = sum(W_temp) + 1/(12 * n)
  W_star = W_2 * (1 + 0.5/n)
  A_star = A_2 * (1 + 0.75/n + 2.25/n^2)
  KS = ks.test(x = x, y="cdfLI_ks_test", par = emvs)

  g<-c()
  estim <- emvs
  g$alpha <- estim[1]
  g$gamma <- estim[2]
  g$L <- estim[3]
  g$convergence <- res$conv
  g$value<-res$value
  data<-x
  hist(x,nclass = 70, freq = F,xlim=c(0.001,max(data)),ylim=c(0.001,6))
  curve(density,xlim=c(0.001,max(data)),ylim=c(0.001,1),lty=3,add=T)
  g$AIC<-AIC
  g$W_star<- W_star
  g$A_star<- A_star
  g$KS<- KS
  return(g)
}
