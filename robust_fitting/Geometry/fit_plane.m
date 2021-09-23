function [plane_normal, plane_distance] = fit_plane(points)

   plane_normal = [1.0, 0.0, 0.0];
   plane_distance = 0.0;

   if (size(points, 1) == 0)
      disp('rayleigh_plane: too few points.');
      return;
   end

   o = mean(points);
   points_temp = points;

   for i = 1:size(points_temp, 1),
      points_temp(i, :) = points_temp(i, :) - o;
   end

   [v, d] = eig(points_temp' * points_temp);
   [m, i] = min(diag(d));

   plane_normal = v(:, i)' / norm(v(:, i));
   plane_distance = sum(o .* plane_normal);
