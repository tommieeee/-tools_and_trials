function [result] = organize(a,j)
num = 1:30;
num = num';
result = [];
a = [num,a];
for i = 2:j
    a = sortrows(a,i,'descend');
    result = [result,a(:,1)];
end
result = [num,result];
end

