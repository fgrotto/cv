function [plane_normal, plane_distance] = get_plane(p1, p2, p3)

   plane_normal = [1.0, 0.0, 0.0];
   plane_distance = 0.0;

   n = v_prod(p2 - p1, p3 - p1);

   if (is_null(n))
      disp('get_plane: invalid points.');
      return;
   end

   plane_normal = n / norm(n);
   plane_distance = sum(p1 .* plane_normal);
