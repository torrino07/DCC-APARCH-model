function [pt]=DCC11(theta,v)
%% DCC(1,1)
%% Parameters

aq=theta(1);
bq=theta(2);

T=length(v(:,1));
%% Filter Covariance Qt
Qt=zeros(T,3);

C=cov(v);
Qt=[C(1,1),C(1,2),C(2,2)];

for t=2:T
    
    Qt(t,1)= C(1,1)*(1-aq-bq) + bq*Qt(t-1,1) + aq*v(t-1,1)^2;
    Qt(t,2)= C(1,2)*(1-aq-bq) + bq*Qt(t-1,2) + aq*v(t-1,1)*v(t-1,2);
    Qt(t,3)= C(2,2)*(1-aq-bq) + bq*Qt(t-1,3) + aq*v(t-1,2)^2;
    
end

q11t = Qt(:,1);
q22t = Qt(:,3);
q12t = Qt(:,2);    

pt=q12t./(sqrt(q11t).*sqrt(q22t));

end
