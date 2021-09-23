function [p] = proj_line(line_start, line_direction, point)

   p = point;

   if (is_null(line_direction))
      disp('proj_line: line direction error.');
      return;
   end

   n = line_direction / norm(line_direction);
   d = sum((point - line_start) .* n);
   p = line_start + n * d;
