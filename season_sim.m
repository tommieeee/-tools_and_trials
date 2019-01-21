function [e_list] = season_sim (r,team)


%%initialize result list
e_list = [];
%%game simulation of same group
for l = 1:2
    for i = 1:6
        for j = 1:5
            for k = 1:5
                if j == k
                    continue;
                else
                    result = sim_Game(r(i,j),r(i,k));
                    if result > 0
                        e_list = [e_list;team(i,j),team(i,k)];
                    else
                        e_list = [e_list;team(i,k),team(i,j)];
                    end
                end
            end
        end
    end
end
%%game simulation of inter-group
for i = 1:4
    for j = 1:5
        for k = j:5
            result = sim_Game(r(1,j),r(2,k));
                if result > 0
                    e_list = [e_list;team(1,j),team(2,k)];
                else
                    e_list = [e_list;team(2,k),team(1,j)];
                end
            result = sim_Game(r(2,j),r(3,k));
                if result > 0
                    e_list = [e_list;team(2,j),team(3,k)];
                else
                    e_list = [e_list;team(3,k),team(2,j)];
                end
            result = sim_Game(r(3,j),r(1,k));
                if result > 0
                    e_list = [e_list;team(3,j),team(1,k)];
                else
                    e_list = [e_list;team(1,k),team(3,j)];
                end
            result = sim_Game(r(4,j),r(5,k));
                if result > 0
                    e_list = [e_list;team(4,j),team(5,k)];
                else
                    e_list = [e_list;team(5,k),team(4,j)];
                end
            result = sim_Game(r(5,j),r(6,k));
                if result > 0
                    e_list = [e_list;team(5,j),team(6,k)];
                else
                    e_list = [e_list;team(6,k),team(5,j)];
                end
            result = sim_Game(r(6,j),r(4,k));
                if result > 0
                    e_list = [e_list;team(6,j),team(4,k)];
                else
                    e_list = [e_list;team(4,k),team(6,j)];
                end
        end
    end
end
for i = 1:3
    for j = 1:4
        for k = j+1:5
            result = sim_Game(r(1,j),r(3,k));
                if result > 0
                    e_list = [e_list;team(1,j),team(3,k)];
                else
                    e_list = [e_list;team(3,k),team(1,j)];
                end
            result = sim_Game(r(2,j),r(1,k));
                if result > 0
                    e_list = [e_list;team(2,j),team(1,k)];
                else
                    e_list = [e_list;team(1,k),team(2,j)];
                end
            result = sim_Game(r(3,j),r(2,k));
                if result > 0
                    e_list = [e_list;team(3,j),team(2,k)];
                else
                    e_list = [e_list;team(2,k),team(3,j)];
                end
            result = sim_Game(r(4,j),r(6,k));
                if result > 0
                    e_list = [e_list;team(4,j),team(6,k)];
                else
                    e_list = [e_list;team(6,k),team(4,j)];
                end
            result = sim_Game(r(5,j),r(4,k));
                if result > 0
                    e_list = [e_list;team(5,j),team(4,k)];
                else
                    e_list = [e_list;team(4,k),team(5,j)];
                end
            result = sim_Game(r(6,j),r(5,k));
                if result > 0
                    e_list = [e_list;team(6,j),team(5,k)];
                else
                    e_list = [e_list;team(5,k),team(6,j)];
                end
        end
    end
end
%%game simulation of inter-conference
for i = 1:2
    for j = 1:3
        for k = 1:5
            for l = 4:6
                for m = 1:5
                     result = sim_Game(r(j,k),r(l,m));
                    if result > 0
                        e_list = [e_list;team(j,k),team(l,m)];
                    else
                        e_list = [e_list;team(l,m),team(j,k)];
                    end
                end
            end
            
        end
    end
end



end

