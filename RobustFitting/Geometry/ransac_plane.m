function [inliers, outliers] = ransac_plane(points, tollerance, inliers_req, max_iterations, vis, points_r)

   inliers = [];
   outliers = [];

   if (nargin < 5)
      vis = 0;
   end

   if ((nargin < 6) || (size(points_r, 1) == 0))
      points_r = points;
   end

   i = 0;
   while ((i < max_iterations) && (size(inliers, 1) < inliers_req))
      inliers_temp = [];
      outliers_temp = [];

      p1_idx = uint32(rand(1) * size(points_r, 1) + 1.0 - get_epsilon);
      p2_idx = uint32(rand(1) * size(points_r, 1) + 1.0 - get_epsilon);
      p3_idx = uint32(rand(1) * size(points_r, 1) + 1.0 - get_epsilon);

      if ((p1_idx == p2_idx) || (p1_idx == p3_idx) || (p2_idx == p3_idx))
         continue;
      end

      p1 = points_r(p1_idx, :);
      p2 = points_r(p2_idx, :);
      p3 = points_r(p3_idx, :);

      if (is_null(v_prod(p2 - p1, p3 - p1)))
         continue;
      end

      [plane_normal, plane_distance] = get_plane(p1, p2, p3);

      for j = 1:size(points, 1),
         point = points(j, :);
         distance = dist_plane(plane_normal, plane_distance, point);

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
