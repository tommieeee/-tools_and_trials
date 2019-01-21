function [s_diff] = sim_Game(X_A,X_B)
%estimation of number of scoring events
n  = poisson_fixed_time ( 1/30.8, 2880 );
%score difference initialize
s_diff = 0;
%Initialize intrinsic possibility
I_A = X_A/(X_A+X_B);
r = 0;
%random walk
for i = 1:n
   if i == 1
       P = I_A ;
       x = sum(rand >= cumsum([0,P, 1-P]));
       if x == 1
           r = 1;
       elseif x == 2
           r = -1;
       end
   else
       P = I_A - 0.152*r - 0.0022*s_diff;
       x = sum(rand >= cumsum([0,P, 1-P]));
       if x == 1
           r = 1;
       elseif x == 2
           r = -1;
       end
   end
   s = sum(rand >= cumsum([0,0.087,0.7486,0.1728,0.014]));
   %%the probability here is based on empirial data of the Redner Paper
   s_diff = s_diff + s * r;
end
end

