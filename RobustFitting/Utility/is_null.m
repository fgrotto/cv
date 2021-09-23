function [r] = is_null(m)

   if (norm(m) < get_epsilon)
      r = uint8(1);
   else
      r = uint8(0);
   end
