function [i] = inter_line_plane(line_start, line_direction, plane_normal, plane_distance)

   i = [0.0, 0.0, 0.0];

   if (is_null(line_direction))
      disp('inter_line_plane: line direction error.');
      return;
   end

   if (is_null(plane_normal))
      disp('inter_line_plane: plane normal error.');
      return;
   end

   n = plane_normal / norm(plane_normal);

   p1 = line_start;
   p2 = line_start + line_direction;
   p3 = n * plane_distance;

   d = sum(n .* (p2 - p1));

   if (is_null(d))
      disp('inter_line_plane: no intersection.');
      return;
   end

   i = p1 + sum(n .* (p3 - p1)) / d * (p2 - p1);
