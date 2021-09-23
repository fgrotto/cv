function [line_start, line_direction] = get_line(p1, p2)

   line_start = [0.0, 0.0, 0.0];
   line_direction = [1.0, 0.0, 0.0];

   n = p2 - p1;

   if (is_null(n))
      disp('get_line: invalid points.');
      return;
   end

   line_start = p1;
   line_direction = n / norm(n);
