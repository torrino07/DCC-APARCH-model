function l = llik_fun_DCC(theta,x)


aq=theta(1);
bq=theta(2);

dim=size(x);
T=dim(1);
llik=0;

Qt=zeros(T,3);

C=cov(x);
Qt(1,:)=[C(1,1),C(1,2),C(2,2)];

for t = 2:T
    
    Qt(t,1)=C(1,1)*(1-aq-bq)+bq*Qt(t-1,1)+aq*x(t-1,1)^2;
    Qt(t,2)=C(1,2)*(1-aq-bq)+bq*Qt(t-1,2)+aq*x(t-1,1)*x(t-1,2);
    Qt(t,3)=C(2,2)*(1-aq-bq)+bq*Qt(t-1,3)+aq*x(t-1,2)^2;
    
    Q=[Qt(t,1),Qt(t,2);Qt(t,2),Qt(t,3)];
    DQ=[sqrt(Qt(t,1)), 0; 0, sqrt(Qt(t,3))];
    Rt=inv(DQ)*Q*inv(DQ);
    
    llik=llik-0.5*(log(det(Rt))+(x(t,:))*inv(Rt)*(x(t,:).'))/T;
    l=mean(llik);
end

end