clear all;
close all;
clc;

% Get the two perspective matrixes
left = load('2_tri1.mat', 'P').P;
right = load('2_tri2.mat', 'P').P;

% Get the two images
img1=imread('2_tri1.jpg');
img2=imread('2_tri2.jpg');

% Decompose the P matrixes [Q|q]
Q1=left(:,1:3);
Q2=right(:,1:3);
q1=left(:,4);
q2=right(:,4);

% K is in common for both new perspective matrixes
% so I need to decompose P = K[R|t]
[K1,R1,t1] = art(left);

% Optical centers C = -inv(Q)q
c1 = - inv(Q1)*q1;
c2= - inv(Q2)*q2;

% Estimate the rotation which is in common between 
% the two new perspective matrixes
v1 = (c2-c1);
k=R1(3,:);
v2 = cross(k',v1);
v3 = cross(v1,v2);

% Normalize the optained vectors
R = [v1'/norm(v1); v2'/norm(v2); v3'/norm(v3)];

% Calculate the new perspective matrixes
Pn1 = K1 * [R -R*c1 ];
Pn2 = K1 * [R -R*c2 ];

% Calculate the transformation matrixes for both (homography)
H1=Pn1(:,1:3)*inv(Q1);
H2=Pn2(:,1:3)*inv(Q2);

% Use imwarp to apply the transformation to the original image
img1_rec = imwarp(rgb2gray(img1),H1);
img2_rec = imwarp(rgb2gray(img2),H2);

% Show the result
figure;
imshow(uint8(img1_rec));
figure;
imshow(uint8(img2_rec));