function [result] = rank_gen(mat)
aMat = mat;
sr = springRank(aMat);
btl_r = btl(aMat,1e-3); 
c_mat = colleyMatrix(aMat);
eigen = eigenvectorCentrality(aMat,1);

wRatio = [];
for i = 1:30
    a = sum(aMat(i,:))/(sum(aMat(i,:))+sum(aMat(:,i)));
    wRatio = [wRatio;a];
end


result = [wRatio,eigen,c_mat,btl_r,sr];

end

