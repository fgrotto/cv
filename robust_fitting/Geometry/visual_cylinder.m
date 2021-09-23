function [] = visual_cylinder(cylinder_axis_start, cylinder_axis_direction, cylinder_radius, dim, centre, lines_only)

   if (nargin < 5)
      centre = cylinder_axis_start;
   end

   if (nargin < 6)
      lines_only = 1;
   end

   if (is_null(cylinder_axis_direction))
      disp('visual_cylinder: cylinder axis direction error.');
      return;
   end

   n = cylinder_axis_direction / norm(cylinder_axis_direction);

   if (norm(n - [1.0, 0.0, 0.0]) > norm(n - [0.0, 1.0, 0.0]))
      q = [1.0, 0.0, 0.0];
   else
      q = [0.0, 1.0, 0.0];
   end

   r = v_prod(n, q);
   s = v_prod(n, r);

   t1 = r / norm(r);
   t2 = s / norm(s);
   t3 = (t2 + t1) / norm(t2 + t1);
   t4 = (t2 - t1) / norm(t2 - t1);

   c = proj_line(cylinder_axis_start, cylinder_axis_direction, centre);

   visual_line(c - cylinder_radius * t1, cylinder_axis_direction, dim);
   visual_line(c + cylinder_radius * t1, cylinder_axis_direction, dim);
   visual_line(c - cylinder_radius * t2, cylinder_axis_direction, dim);
   visual_line(c + cylinder_radius * t2, cylinder_axis_direction, dim);
   visual_line(c - cylinder_radius * t3, cylinder_axis_direction, dim);
   visual_line(c + cylinder_radius * t3, cylinder_axis_direction, dim);
   visual_line(c - cylinder_radius * t4, cylinder_axis_direction, dim);
   visual_line(c + cylinder_radius * t4, cylinder_axis_direction, dim);

   for i = -5:5,
      d = i * dim / 5.0;

      p = [c - d * n + cylinder_radius * t1;
           c - d * n + cylinder_radius * t3;
           c - d * n + cylinder_radius * t2;
           c - d * n + cylinder_radius * t4;
           c - d * n - cylinder_radius * t1;
           c - d * n - cylinder_radius * t3;
           c - d * n - cylinder_radius * t2;
           c - d * n - cylinder_radius * t4;
           c - d * n + cylinder_radius * t1];

      plot3(p(:, 1), p(:, 2), p(:, 3), 'm-');
   end
