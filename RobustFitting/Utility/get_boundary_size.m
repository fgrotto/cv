function [s] = get_boundary_size(points)

   s = max(points) - min(points);
