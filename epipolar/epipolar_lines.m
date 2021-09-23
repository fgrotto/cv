clear all;
close all;

P1 = load('2_tri1.mat', 'P').P;
P2 = load('2_tri2.mat', 'P').P;

img1 = imread('2_tri1.jpg');
img2 = imread('2_tri2.jpg');

figure; imagesc(img1);
figure; imagesc(img2);

% Calculate the epipole from definition
% e = -Q'Q-1*q + q'
% Calculate F matrix from definition
% F = [e']*Q'Q-1
e = -P2(:,1:3)*inv(P1(:,1:3))*P1(:,4) + P2(:,4);
F = [0 -e(3) e(2)
     e(3) 0 -e(1)
    -e(2) e(1) 0]*P2(:,1:3)*inv(P1(:,1:3));

for i=1:5
   % Get a point from the first image
   figure(1)
   [x,y] = ginput(1);
   hold on
   plot(x,y,'g');
   
   % Calculate the epipolar line
   p = F*[x;y;1];
   
   % Calculate x-y points to draw the epipolar line
   x_value = 1:size(img1,2);
   y_value = (-p(3)-p(1)*x_value)/p(2);
   
   figure(2);
   hold on;
   plot(x_value, y_value);
end




