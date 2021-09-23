function [d] = dist_line(line_start, line_direction, point)

   d = 0.0;

   if (is_null(line_direction))
      disp('dist_line: line direction error.');
      return;
   end

   d = norm(point - proj_line(line_start, line_direction, point));
