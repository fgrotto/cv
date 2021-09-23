function [r] = v_prod(p, q)

   r = [p(2) * q(3) - p(3) * q(2), p(3) * q(1) - p(1) * q(3), p(1) * q(2) - p(2) * q(1)];
