function [b] = betaGlobal_btl(A,s)
global M r
M = A;
r = s;
b = fzero(@f,0.1);
end

function [y] = f(b)
global M r
n = length(r);
y = 0;
for i=1:n
    for j=1:n
        d = r(i) - r(j);
        pij = exp(2*b*r(i))/(exp(2*b*r(i))+exp(2*b*r(j)));
        y = y + d*(M(i,j) - (M(i,j)+M(j,i))*pij);
    end
end
end