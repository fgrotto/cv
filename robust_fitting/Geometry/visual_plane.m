function [] = visual_plane(plane_normal, plane_distance, dim, centre, lines_only)

   if (nargin < 4)
      centre = [0.0, 0.0, 0.0];
   end

   if (nargin < 5)
      lines_only = 1;
   end

   if (is_null(plane_normal))
      disp('visual_plane: plane normal error.');
      return;
   end

   n = plane_normal / norm(plane_normal);

   if (norm(n - [1.0, 0.0, 0.0]) > norm(n - [0.0, 1.0, 0.0]))
      q = [1.0, 0.0, 0.0];
   else
      q = [0.0, 1.0, 0.0];
   end

   r = v_prod(n, q);
   s = v_prod(n, r);
   r = r / norm(r);
   s = s / norm(s);

   c = proj_plane(plane_normal, plane_distance, centre);

   if (lines_only)
      for i = 1:10,
         d = i * dim / 10.0;

         p = [c - d * r + d * s;
              c + d * r + d * s;
              c + d * r - d * s;
              c - d * r - d * s;
              c - d * r + d * s];

         plot3(p(:, 1), p(:, 2), p(:, 3), 'm-');
         hold on
      end
   else
      idx = [1, 2, 3, 3, 4, 1];
      
      p = [c - dim * r + dim * s;
           c + dim * r + dim * s;
           c + dim * r - dim * s;
           c - dim * r - dim * s];
      
      trisurf(idx, p(:, 1), p(:, 2), p(:, 3));
   end
