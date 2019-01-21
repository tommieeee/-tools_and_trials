%inport teams win-lose edge
%inport team names
elist = [Team1,Team2;Team2,Team1];
weight = [Team1Wins;Team2Wins];

[A,W,L,D,AW] = paramNBA(elist,30,Team1,Team2,Team1Wins,Team2Wins);

[f,s] = corrections(A,W,L,60,30,D);

Ranks = rank_gen(AW);
Ranks = [Ranks,f,s];
Ranks = organize(Ranks);
Ranks = full(Ranks);

RwNames = {};
for i = 1:8
    for j = 1:30
        RwNames(j,i) = team(Ranks(j,i),1);
    end
end
AW = full(AW);
w_L = [W,L,W-L];
corrections = [f,s];


csvwrite("AW.csv",AW);
csvwrite("winLose.csv",w_L);
csvwrite("netWL.csv",D);
xlswrite("Ranks.xls",RwNames);
csvwrite("corrections.csv",corrections);
xlswrite("teams.xls",team);