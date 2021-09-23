function [cylinder_axis_start, cylinder_axis_direction, cylinder_radius] = fit_cylinder(points, use_lsge)

   cylinder_axis_start = [0.0, 0.0, 0.0];
   cylinder_axis_direction = [1.0, 0.0, 0.0];
   cylinder_radius = 1.0;

   if (nargin < 2)
      use_lsge = 0;
   end

   if (size(points, 1) < 7)
      disp('fit_cylinder: too few points.');
      return;
   end

   [s, d] = fit_line(points);
   options = optimset('Display', 'Off');
   
   if (use_lsge)
      [cylinder_axis_start, cylinder_axis_direction, cylinder_radius] = lscylinder(points, s', d', 1.0, 0.1, 0.1);
      cylinder_axis_start = cylinder_axis_start';
      cylinder_axis_direction = cylinder_axis_direction';
   else
      parameters = lsqnonlin('lsq_cylinder', [s(1), s(2), s(3), d(1), d(2), d(3), 1.0], [], [], options, points);
      cylinder_axis_start = parameters(1:3);
      cylinder_axis_direction = parameters(4:6);
      cylinder_radius = parameters(7);
   end
