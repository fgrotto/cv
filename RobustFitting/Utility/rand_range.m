function [r] = rand_range(n, m, limit)

   r = rand(n, m);
   r = 2.0 * (r - 0.5) * limit;
