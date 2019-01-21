function [first,second] = corrections(A,w,l,Q,T,D)
%this funciton takes in the adjacency matrix and output the first and
%second order correction of the rankings in the random walk ranking model
%   input: adjacency matrix A (simple undirected graph)
%   output: first: first correction
%           second: second correction

G = graph(A);
L = laplacian(G)*-1;
L = full(L);
Li = pinv(L);

first = -4*Q/T*Li*(w-l);
second = 8*Q/T*Li*D*Li*(w-l);


end

