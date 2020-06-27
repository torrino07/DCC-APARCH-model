function [h,pValue]=ADFT(data)

alpha=[0.1 0.05 0.01];

for i=1:size(data,2)
    for j = 1:size(alpha,2)
        [h(i,j),pValue(i,j),stat(i,j),cValue(i,j),reg(i,j)] = adftest(data(:,i),'alpha', alpha(1,j));
    end
end