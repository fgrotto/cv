   %
   %
   close all
   clear
   clc
   
   addpath('./Geometry/')
   addpath('./LSGE/')
   addpath('./Utility/')
   
   points = load('a4.cnn');
   figure(1)
   plot3(points(:,1),points(:,2), points(:,3), 'r.');
   grid on
   points_upper = [];
   points_lower = [];
   v = min(points);
   b = get_boundary_size(points);
   z_limit = v(3) + b(3) / 3.0;

   for i = 1:size(points, 1)
      if (points(i, 3) > z_limit)
         points_upper = [points_upper; points(i, :)];
      else
         points_lower = [points_lower; points(i, :)];
      end
   end
  
   disp('Search cylinder.');
   [inliers_c, outliers_c] = ransac_cylinder(points, 20.0, 1200, 50, 1, points_upper, 1);

   disp('Search plane.');
   [inliers_p, outliers_p] = ransac_plane(outliers_c, 20.0, 450, 50, 1);

   disp('Fit cylinder.');
   [cylinder_axis_start, cylinder_axis_direction, cylinder_radius] = fit_cylinder(inliers_c, 1);

   disp('Fit plane.');
   [plane_normal, plane_distance] = fit_plane(inliers_p);
    figure(2)
   if (size(inliers_c, 1) ~= 0)
      plot3(inliers_c(:, 1), inliers_c(:, 2), inliers_c(:, 3), 'g.');
   end
   
   set(gcf, 'Renderer', 'OpenGL');
   hold on
   grid on

   if (size(inliers_p, 1) ~= 0)
      plot3(inliers_p(:, 1), inliers_p(:, 2), inliers_p(:, 3), 'b.');
   end

   if (size(outliers_p, 1) ~= 0)
      plot3(outliers_p(:, 1), outliers_p(:, 2), outliers_p(:, 3), 'r.');
   end

   visual_cylinder(cylinder_axis_start, cylinder_axis_direction, cylinder_radius, 550.0, get_boundary_centre(inliers_c), 1);
   visual_plane(plane_normal, plane_distance, 400.0, get_boundary_centre(inliers_p), 1);
   axis equal
