#'The LA and LI Distribution
#'
#'Fit function for the LA distribution.
#'
#'@param alpha parameter 1.
#'@param gama  parameter 2.
#'@param L parameter 3.
#'@param x data
#'
#'@examples
#'
#'lafit(rla(n=1000,alpha=-10,gama=1.5,L=4))
#'
#'@import GenSA
#'
#'@export
 lafit <-function(x){
  x <- as.vector(x)
  n<-length(x)
  set.seed(137)

  fdpLA<-function(par){
    alpha=par[1]
    gama=par[2]
    L=par[3]
    -2*alpha*gama*((L*x^2/(L*x^2+gama)))^(1+L)*(1-((L*x^2/(L*x^2+gama)))^L)^(-1-alpha)*x^(-3)
  }

  #loglike_theta
  l_theta<- function(par){
    sum(log(fdpLA(par)))
  }

  gr<-function(par){
    alpha<-par[1]
    gama<-par[2]
    L<-par[3]
    c( -((n/alpha)-sum(log(1-(L*x^2/(gama+L*x^2))^L))),
       -((n/gama)-(L+1)*sum(1/(gama+L*x^2))-(1+alpha)*L*sum(((gama+L*x^2)*(((1-gama/(gama+L*x^2))^(-L))-1))^(-1))),
       -(sum(log(L*x^2/(gama+L*x^2)))+(L+1)*sum(gama/(L^2*x^2+gama*L))-(alpha+1)*sum(((1-(gama/(gama+L*x^2)))^L/((gama+L*x^2)*((1-(gama/(gama+L*x^2)))^(L)-1)))*(gama+(gama+L*x^2)*log(1-gama/(gama+L*x^2)))))
    )
  }

  ##Initial genSA
  fit.sa <- function(x,fdpLA) {
    minusllike <- function(x) -sum(log(fdpLA(c(x[1],x[2],x[3]))))
    lower <- c(-10,0.001,0.001) #may need some changes here
    upper <- c(-0.01,10,10)
    out <- GenSA(lower = lower, upper = upper,
                 fn = minusllike, control=list(verbose=TRUE,max.time=2))
    return(out[c("value","par","counts")])
  }

  initial<-fit.sa(x,fdpLA)$par
  #

  res<-optim(initial, l_theta, method="BFGS",#x=x,
             control=list(fnscale=-1, pgtol=1e-20, maxit=200,gr=gr))

  gama_emv<-res$par[2]
  L_emv<-res$par[3]
  alpha_semi<-n/(sum(log(1-((L_emv*x^2)/(gama_emv+L_emv*x^2))^L_emv)))

  density<-function(x){
    -2*alpha_semi*gama_emv*((L_emv*x^2/(L_emv*x^2+gama_emv)))^(1+L_emv)*(1-((L_emv*x^2/(L_emv*x^2+gama_emv)))^L_emv)^(-1-alpha_semi)*x^(-3)
  }

  p<-3
  AIC<-(-2*sum(log( -2*alpha_semi*gama_emv*((L_emv*x^2/(L_emv*x^2+gama_emv)))^(1+L_emv)*(1-((L_emv*x^2/(L_emv*x^2+gama_emv)))^L_emv)^(-1-alpha_semi)*x^(-3)      ))+2*p)
  BIC<-(-2*sum(log( -2*alpha_semi*gama_emv*((L_emv*x^2/(L_emv*x^2+gama_emv)))^(1+L_emv)*(1-((L_emv*x^2/(L_emv*x^2+gama_emv)))^L_emv)^(-1-alpha_semi)*x^(-3)     ))+p*log(length(x)))

  emvs<-c(alpha_semi,gama_emv,L_emv)
  sorted_data = sort(x)
  cdfLA<-function(emvs,sorted_data){
    1-(1-(L_emv*sorted_data^2/(gama_emv+L_emv*sorted_data^2))^L_emv)^(-alpha_semi)
  }

  cdfLA_ks_test<-function(x,par){
    1-(1-(L_emv*x^2/(gama_emv+L_emv*x^2))^L_emv)^(-alpha_semi)
  }

  v = cdfLA(emvs, sorted_data)
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
  KS = ks.test(x = x, y="cdfLA_ks_test", par = emvs)

  g<-c()
  estim <- emvs
  g$alpha <- estim[1]
  g$gamma <- estim[2]
  g$L <- estim[3]
  g$convergence <- res$conv
  g$value<-res$value
  data<-x
  hist(data,nclass = 45, freq = F,xlim=c(0.001,max(data)),ylim=c(0.001,max(density(data))))
  curve(density,xlim=c(0.001,max(data)),ylim=c(0.001,max(density(data))),lty=3,add=T)
  g$AIC<-AIC
  g$W_star<- W_star
  g$A_star<- A_star
  g$KS<- KS
  return(g)
}

