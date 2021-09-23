function [line_start, line_direction] = fit_line(points)

   line_start = [0.0, 0.0, 0.0];
   line_direction = [1.0, 0.0, 0.0];
   radius = 1.0;

   if (size(points, 1) == 0)
      disp('rayleigh_line: too few points.');
      return;
   end

   o = mean(points);
   points_temp = points;

   for i = 1:size(points_temp, 1),
      points_temp(i, :) = points_temp(i, :) - o;
   end

   [v, d] = eig(points_temp' * points_temp);
   [m, i] = max(diag(d));

   line_start = o;
   line_direction = v(:, i)' / norm(v(:, i));
