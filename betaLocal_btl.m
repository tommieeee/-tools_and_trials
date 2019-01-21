function [b] = betaLocal_btl(A,s)

global M r
M = A;
r = s;
b = fminbnd(@negacc,1e-6,1000);
end

function [a] = negacc(b)
global M r
m = sum(sum(M));
n = length(r);
y = 0; 
for i=1:n
    for j=1:n
        %d = r(i) - r(j);
        pij = exp(2*b*r(i))/(exp(2*b*r(i))+exp(2*b*r(j)));
        y = y + abs( M(i,j)- (M(i,j) + M(j,i))*pij );
    end
end
a = y/m-1;
end