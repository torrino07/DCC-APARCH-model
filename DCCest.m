function[delta,pt]=DCCest(v,nk)



nr=size(v,1)
nc=size(v,2)

pt=zeros(nr,length(nk));
delta=zeros(length(nk),2);


v=v.';

for i = 1:size(nk,1)
    
    [delta(i,:)]=SML([v(nk(i,1),:);v(nk(i,2),:)]');
    [pt(:,i)]=DCC11(delta(i,:),[v(nk(i,1),:);v(nk(i,2),:)]');  
    
end

end