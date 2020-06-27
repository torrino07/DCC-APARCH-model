function [v]=shocks(x,sig,theta)

nr=size(x,1);
nc=size(x,2);

u=zeros(nr,nc);

for i=1:nc
    u=x./(sig.^(1/theta(i,4)));
end
v=u;