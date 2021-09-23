function [] = visual_line(line_start, line_direction, dim, centre, lines_only)

   if (nargin < 4)
      centre = line_start;
   end

   if (nargin < 5)
      lines_only = 1;
   end

   if (is_null(line_direction))
      disp('visual_line: line direction error.');
      return;
   end

   n = line_direction / norm(line_direction);
   c = proj_line(line_start, line_direction, centre);

   p = [c - dim * n;
        c + dim * n];

   plot3(p(:, 1), p(:, 2), p(:, 3), 'm-');
   hold on
