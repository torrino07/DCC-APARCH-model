function[x]=differing(data)

for i=1:size(data,2)
    [h(i,1)] = adftest(data(:,i),'alpha', 0.01);
end

x=zeros((size(data,1))-1,(size(data,2)));
for i=1:size(data,2)
    if h(i,1)==1
        x(:,i)=data(2:end,i);
    elseif h(i,1)==0
        x(:,i)=returns(data(:,i));      
    end
end

x=real(x);

end

