function [r] = team_gen(T)
%generation of strengh of teams
% T: number of teams
r = normrnd(1,sqrt(0.0083),[T,1]);
r = sort(r,'descend');
end