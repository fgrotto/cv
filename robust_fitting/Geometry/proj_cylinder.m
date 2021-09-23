function [p] = proj_cylinder(cylinder_axis_start, cylinder_axis_direction, cylinder_radius, point)

   p = point;

   if (is_null(cylinder_axis_direction))
      disp('proj_cylinder: cylinder axis direction error.');
      return;
   end

   p = proj_line(cylinder_axis_start, cylinder_axis_direction, point);
   n = point - p;

   if (is_null(n))
      if (norm(cylinder_axis_direction - [1.0, 0.0, 0.0]) > norm(cylinder_axis_direction - [0.0, 1.0, 0.0]))
         n = v_prod(cylinder_axis_direction, [1.0, 0.0, 0.0]);
      else
         n = v_prod(cylinder_axis_direction, [0.0, 1.0, 0.0]);
      end
   end

   p = p + n / norm(n) * cylinder_radius;
