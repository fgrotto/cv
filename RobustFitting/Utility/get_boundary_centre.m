function [c] = get_boundary_centre(points)

   c = (min(points) + max(points)) / 2.0;
