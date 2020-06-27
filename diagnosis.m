function [h1,p1,h2,p2,h3,p3]=diagnosis(v,alpha)


[h1,p1] = lbqtest(v,'lags',[5,10,15]);
[h2,p2] = lbqtest(v.^2,'lags',[5,10,15]);
[h3,p3,jbstat,critval] = jbtest(v,alpha);




end