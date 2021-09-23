function [r] = rand_normal()

   r = [0.0, 0.0, 0.0];
   
   while (is_null(r))
      r = rand(1, 3);
   end

   r = r / norm(r);
