function [CM]= CorrM(pt,nc)
m=mean(pt);
CM=zeros(nc,nc);
for i=1:nc
    for j=1:nc
        if i < j
            for q=1:size(m,1)
                for r=1:(nc-1)
                    for c=r+1:nc
                        CM(r,c) = m(1,q);
                        q=q+1;
                    end
                end
            end
        elseif i==j
            CM(i,j) = 1;
        elseif i>j
            for q=1:size(m,1)
                for c=1:(nc-1)
                    for r=c+1:nc
                        CM(r,c) = m(1,q);
                        q=q+1;
                    end
                end
            end
        end
         
    end
end     
end