function [NK]=keys(k)

nk=[];
for i=1:k
    for j=1:k
        if i~=j
            nk = [nk; i j];            
        end
    end
end

[NK]=cleann(nk);
