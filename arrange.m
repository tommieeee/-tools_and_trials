function [r,team] = arrange(r,T,i)
%%particular game arrangement for five different tiers according to
%%strength
if i == 1
    r = reshape(r,5,6);
    r = r';
    team = reshape(1:T,5,6);
    team = team';
elseif i == 2
    r = reshape(r,6,5);
    team = reshape(1:30,6,5);
end
end

