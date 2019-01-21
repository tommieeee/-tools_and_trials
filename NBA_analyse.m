elist = [Team1,Team2;Team2,Team1];
weight = [Team1Wins;Team2Wins];

[A,W,L,D,AW] = paramNBA(elist,30,Team1,Team2,Team1Wins,Team2Wins);

[sig_a0,sig_L0]=crossValidation(AW,5,50);

Cl = GCSpectralClust1(AW,6);
num = 1:30;
num = num';
Cl2 = [num,Cl(:,6)];
AWT = zeros(30);
sig_a1 = [];
sig_L1 = [];
for i = 1:30
    for j = i+1:30
        if Cl2(i,2) == Cl2(j,2)
            continue
        else
            AWT = AW;
            a = AWT(i,j);
            AWT(i,j) = AWT(j,i);
            AWT(j,i) = a;
            [sig_a2,sig_L2] = crossValidation(AWT,5,50);
            sig_a1 = [sig_a1,sig_a2];
            sig_L1 = [sig_L1,sig_L2];
        end
    end
end


