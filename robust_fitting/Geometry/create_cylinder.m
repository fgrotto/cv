% Genera un "cilindro" (nuvola di punti) nello spazio.
function [cylinder, noise] = create_cylinder(space_dim, num_cylinder_points, num_noise_points, max_error)

   cylinder = [];
   noise = [];

   cylinder_axis_start = rand_range(1, 3, space_dim / 3.0);
   cylinder_axis_direction = rand_normal;
   cylinder_radius = (rand(1) + 0.5) * space_dim / 5.0;

   for i = 1:num_cylinder_points,
      p = rand_range(1, 3, space_dim);
      cylinder = [cylinder; proj_cylinder(cylinder_axis_start, cylinder_axis_direction, cylinder_radius, p)];
   end

   for i = 1:num_cylinder_points,
      cylinder(i, :) = cylinder(i, :) + rand_normal * max_error;
   end

   for i = 1:num_noise_points,
      noise = [noise; rand_range(1, 3, space_dim)];
   end
