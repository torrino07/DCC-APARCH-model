function [sig]=APARCH11(theta,x)
%% APARCH(1,1)
%% Parameters

omega=theta(1);
alpha = theta(2);
gama=theta(3);
delta=theta(4);
beta = theta(5);
v=theta(6);

%% Filter Covariance

T=length(x);
sig=zeros(T,1);
sig(1) = omega/(1-alpha*((1-gama)^delta)-beta);

for t = 2:T
  
    %sig(t) =  omega+alpha*x(t-1)^2+beta*sig(t-1);
    sig(t) = omega + alpha*(abs(x(t-1))-gama*x(t-1))^(delta) + beta*sig(t-1);
    
end

