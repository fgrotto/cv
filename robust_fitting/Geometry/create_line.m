% Genera una "retta" (nuvola di punti) nello spazio.
function [line, noise] = create_line(space_dim, num_line_points, num_noise_points, max_error)

   line = [];
   noise = [];

   line_start = rand_range(1, 3, space_dim / 3.0);
   line_direction = rand_normal;

   for i = 1:num_line_points,
      p = rand_range(1, 3, space_dim);
      line = [line; proj_line(line_start, line_direction, p)];
   end

   for i = 1:num_line_points,
      line(i, :) = line(i, :) + rand_normal * max_error;
   end

   for i = 1:num_noise_points,
      noise = [noise; rand_range(1, 3, space_dim)];
   end
