function [DCorrs]=diffCoer(x,pt,nc)
[DCCCM]= CorrM(pt,nc);
PCCM=corrcoef(x);

D=DCCCM-PCCM;
for i=1:nc
    for j=1:nc
        if i==j
            D(i,j) = 0;
        end
    end
end
DCorrs=abs(D);
        

