function [d] = dist_cylinder(cylinder_axis_start, cylinder_axis_direction, cylinder_radius, point)

   d = 0.0;

   if (is_null(cylinder_axis_direction))
      disp('dist_cylinder: cylinder axis direction error.');
      return;
   end

   d = norm(point - proj_cylinder(cylinder_axis_start, cylinder_axis_direction, cylinder_radius, point));
