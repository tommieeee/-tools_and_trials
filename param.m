function [A,W,L,D, AW] = param(list,T)
%generate parameters from an edge list for further calculation
%   A: simple undirected adjacency matrix
%   w: wins of each team
%   l: loses of each team
%   D: has w-l on its diagnal, has net win-lose with team j on each of
%   diagnal ij position
%   assume 30 teams now

W = zeros(T,1);
L = zeros(T,1);

elist = list;
g = digraph(elist(:,1), elist(:,2));
weight = [];
for i = 1:T
    for j = 1:T
        w = edgecount(g,i,j);
        if w == 0
            continue;
        else
            weight = [weight;w];    
        end      
    end    
end
%%simplify the multigraph and give each edge a weight
h = simplify(g);
AW = adjacency(h,weight);

%outcome reversing between team 12 and team 30
%REMEMBER to DELETE when not using
temp = AW(12,30);
AW (12,30) = AW (30,12);
AW (30,12) = temp;

count = 0;
for i = 1:T   
    for j = 1:T
        if i == j
            count = count + 0;
        else
            count = count + AW(i,j);
        end
    end
    W(i) = count;
    count = 0;
end

for j = 1:T   
    for i = 1:T
        if i == j
            count = count + 0;
        else
            count = count + AW(i,j);
        end
    end
    L(j) = count;
    count = 0;
end

D = zeros(T,T);
for i = 1:T
    D(i,i) = W(i)-L(i);
end

for i = 1:T
    for j = 1:T
        if i == j
            continue;
        else
            D(i,j) = AW(i,j) - AW(j,i);
        end
    end
end

elist = list;
G = graph(elist(:,1), elist(:,2));
A = adjacency(G);

end

