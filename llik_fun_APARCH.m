function  [llik] = llik_fun_APARCH(x,theta)

T=length(x);

omega=theta(1);
alpha = theta(2);
gama=theta(3);
delta=theta(4);
beta = theta(5);
v=theta(6);

%% Filter Volatility

sig(1)=omega/(1-alpha*((1-gama)^delta)-beta);

for t=1:T
    
    sig(t+1) = omega + alpha*(abs(x(t))-gama*x(t))^(delta) + beta*sig(t);
    
end

%% Calculate Log Likelihood Values

%% Normal log-likelihood
%l = -(1/2)*log(2*pi) - (1/2)*log(sig(1:T)) - (1/2)*(x').^2./sig(1:T);
%% Student-t log-likelihood
l = log(gamma((v+1)/2)) - log(gamma(v/2)) - (1/2)*log(pi*(v-2)) - (1/2)*(log(sig(1:T))) - ((v+1)/2)*(log(1+((x').^2)./(sig(1:T)*(v-2))));

llik =mean(l);