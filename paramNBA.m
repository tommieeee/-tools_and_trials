function [A,W,L,D, AW] = paramNBA(list,T,Team1,Team2,Team1Wins,Team2Wins)
%generate parameters from an edge list for further calculation
%   A: simple undirected adjacency matrix
%   w: wins of each team
%   l: loses of each team
%   D: has w-l on its diagnal, has net win-lose with team j on each of
%   diagnal ij position
%   assume 30 teams now

W = zeros(T,1);
L = zeros(T,1);

g1 = digraph(Team1,Team2,Team1Wins);
g1 = addedge(g1, Team2,Team1,Team2Wins);
nn = numnodes(g1);
[s,t] = findedge(g1);
AW = sparse(s,t,g1.Edges.Weight,nn,nn);

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

