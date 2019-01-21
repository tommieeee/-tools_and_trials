%team generation and rearrange and simulation of 1 NBA season
%(teams are grouped by tiers)
teams = team_gen(30);
[r,team] = arrange(teams,30,1);
e_list = season_sim(r,team);

[A,W,L,D,AW] = param(e_list,30);

[f,s] = corrections(A,W,L,60,30,D);

Ranks = rank_gen(AW);
Ranks = [Ranks,f,s];
Ranks = organize(Ranks);
Ranks = full(Ranks);

AW = full(AW);
w_L = [W,L,W-L];
corrections = [f,s];

%csvwrite("AW.csv",AW);
%csvwrite("winLose.csv",w_L);
%csvwrite("netWL.csv",D);
%csvwrite("Ranks.csv",Ranks);
%csvwrite("corrections.csv",corrections);
%csvwrite("teams.csv",teams);



