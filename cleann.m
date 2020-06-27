function [A]=cleann(X)

v1=X(:,1);
v2=X(:,2);
v = [v1, v2];
v = sort(v, 2);
[uniquerows, idx] = unique(v, 'rows');
uniquev1 = v1(idx);
uniquev2 = v2(idx);

A=[uniquev1,uniquev2];
