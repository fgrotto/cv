function [inliers, outliers] = ransac_cylinder(points, tollerance, inliers_req, max_iterations, vis, points_r, use_lsge)

   inliers = [];
   outliers = [];

   if (nargin < 5)
      vis = 0;
   end
   
   if ((nargin < 6) || (size(points_r, 1) == 0))
      points_r = points;
   end

   if (nargin < 7)
      use_lsge = 0;
   end

   i = 0;
   while ((i < max_iterations) && (size(inliers, 1) < inliers_req))
      p = [];
      inliers_temp = [];
      outliers_temp = [];

      for j = 1:7,
         p = [p; points_r(uint32(rand(1) * size(points_r, 1) + 1.0 - get_epsilon), :)];
      end

      [cylinder_axis_start, cylinder_axis_direction, cylinder_radius] = fit_cylinder(p, use_lsge);

      for j = 1:size(points, 1),
         point = points(j, :);
         distance = dist_cylinder(cylinder_axis_start, cylinder_axis_direction, cylinder_radius, point);

         if (abs(distance) <= tollerance)
            inliers_temp = [inliers_temp; point];
         else
            outliers_temp = [outliers_temp; point];
         end
      end

      if (size(inliers_temp, 1) > size(inliers, 1))
         inliers = inliers_temp;
         outliers = outliers_temp;
      end

      i = i + 1;
   end

   if (vis)
      disp(' ');
      disp('Iterations: [n / total]');
      disp([i, max_iterations]);
      disp('Inliers: [n / total]');
      disp([size(inliers, 1), size(inliers, 1) + size(outliers, 1)]);
   end
