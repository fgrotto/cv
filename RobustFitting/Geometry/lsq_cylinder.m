function [err] = lsq_cylinder(parameters, points)

   cylinder_axis_start = parameters(1:3);
   cylinder_axis_direction = parameters(4:6);
   cylinder_radius = parameters(7);

   err = zeros(size(points, 1), 1);

   if (is_null(cylinder_axis_direction))
      disp('lsq_cylinder: cylinder axis direction error.');
      return;
   end

   if (size(points, 1) < 7)
      disp('lsq_cylinder: too few points.');
      return;
   end

   n = cylinder_axis_direction / norm(cylinder_axis_direction);

   for i = 1:size(points, 1),
      s1 = sum((points(i, :) - cylinder_axis_start) .^ 2.0);
      s2 = sum((points(i, :) - cylinder_axis_start) .* n) ^ 2.0;
      s3 = cylinder_radius ^ 2.0;
      err(i) = s1 - s2 - s3;
   end
