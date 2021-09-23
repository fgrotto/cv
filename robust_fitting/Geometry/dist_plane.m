function [d] = dist_plane(plane_normal, plane_distance, point)

   d = 0.0;

   if (is_null(plane_normal))
      disp('dist_plane: plane normal error.');
      return;
   end

   d = norm(point - proj_plane(plane_normal, plane_distance, point));
