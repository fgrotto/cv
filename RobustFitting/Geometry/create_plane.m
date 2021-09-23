% Genera un "piano" (nuvola di punti) nello spazio.
function [plane, noise] = create_plane(space_dim, num_plane_points, num_noise_points, max_error)

   plane = [];
   noise = [];

   plane_normal = rand_normal;
   plane_distance = rand_range(1, 1, space_dim / 3.0);

   for i = 1:num_plane_points,
      p = rand_range(1, 3, space_dim);
      plane = [plane; proj_plane(plane_normal, plane_distance, p)];
   end

   for i = 1:num_plane_points,
      plane(i, :) = plane(i, :) + rand_normal * max_error;
   end

   for i = 1:num_noise_points,
      noise = [noise; rand_range(1, 3, space_dim)];
   end
