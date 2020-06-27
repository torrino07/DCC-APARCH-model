function [theta,sig,v,nk]=APARCHest(data)
%% Dimensions
nr = size(data,1);
nc = size(data,2);

theta=zeros(nc,6);
for k=1:nc
    [theta(k,:)]=FML(data(:,k));
end

sig=zeros(nr,nc);
for i=1:nc
    [sig(:,i)]=APARCH11(theta(i,:),data(:,i));
end

[v]=shocks(data,sig,theta);
[nk]=keys(nc);
