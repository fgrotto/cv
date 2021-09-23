clc;

k = 0.04;
Threshold = 50000;
sigma = 1;
halfwid = sigma * 3;

[xx, yy] = meshgrid(-halfwid:halfwid, -halfwid:halfwid);

Gxy = exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));

Gx = xx .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
Gy = yy .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));

img = imread('object.png');

rows = size(img, 1);
columns = size(img, 2);

% 1) Compute x and y derivatives of image
Ix = conv2(Gx, I);
Iy = conv2(Gy, I);

size(Ix)

% 2) Compute products of derivatives at every pixel
Ix2 = Ix .^ 2;
Iy2 = Iy .^ 2;
Ixy = Ix .* Iy;

% 3)Compute the sums of the products of derivatives at each pixel
Sx2 = conv2(Gxy, Ix2);
Sy2 = conv2(Gxy, Iy2);
Sxy = conv2(Gxy, Ixy);

im = zeros(rows, columns);
for x=1:rows,
   for y=1:columns,
       H = [Sx2(x, y) Sxy(x, y); Sxy(x, y) Sy2(x, y)];
       R = det(H) - k * (trace(H) ^ 2);
       if (R > Threshold)
          im(x, y) = R; 
       end
   end
end

% 7) Compute nonmax suppression
output = im > imdilate(im, [1 1 1; 1 0 1; 1 1 1]);

figure, imshow(I);
figure, imshow(output)