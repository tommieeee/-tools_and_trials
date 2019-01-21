k = 1;
w = [];
for i = 1:30
    for j = i+1:30
        if Cl2(i,2) == Cl2(j,2)
            continue
        else
         w(1,k) = i;
         w(2,k) = j;
         k= k+1;
        end
    end
end