clear all;
close all;
clc;

% Load image and calibration
load('imgInfo.mat');
img = imread('cav.jpg');
p2D = imgInfo.punti2DImg;
p3D = imgInfo.punti3DImg;
K = imgInfo.K;

% Extract the first 100 points to apply the fiore algorithm
points2 = p2D(1:100,:)';
points3 = p3D(1:100,:)';

% Get the 3d point in homogenous coordinates
M = [points3; ones(1,(size(points3,2)))];
r = rank(M);
[~,~,Vt] = svd(M);
% Get the last n-r lines as used for fiore algorithm
Vr = Vt(:,r+1:end);

% Get 2D points and calculate homogeneous coordinates
m = [points2;ones(1,size(points2,2))]';
m = inv(K)*m';

numP = size(m,2);

% Build the D matrix 
D = [];
for i = 1:numP
  D =  [D
        zeros(3,i-1) m(:,i) zeros(3,numP-i)];
end

L = kron(Vr', inv(K))*D;

% Solve the linear system to get the exstimated xi
% that will be used to prepare the absolute orientation
% problem
[~, ~, V] = svd(L);
xi = V(:, end);
% Just adapt to correct normalization
% probably not necessary here
xi = xi * sign(xi(1));

% Solve the absolute orientation problem
[G,s,t] = absolute(vtrans(D * xi,3),points3, 'scale');

% Show the real 2D points and the 2D reprojected
% from the relative 3D points using the estimated
% perspective matrix
figure; imshow(img);
hold on;
plot(p2D(:,1), p2D(:,2), 'go');
[u,v] = proj(K*G,p3D);
plot(u,v,'bo');

% Print the external camera parameters estimated by the calibration
% toolbox and G obtained from the fiore algorithm
imgInfo.R
imgInfo.T
G
