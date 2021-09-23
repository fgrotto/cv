function [p] = proj_plane(plane_normal, plane_distance, point)

   p = point;

   if (is_null(plane_normal))
      disp('proj_plane: plane normal error.');
      return;
   end

   n = plane_normal / norm(plane_normal);
   d = sum(point .* n) - plane_distance;
   p = point - n * d;
