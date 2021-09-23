clear 
close all
P1 =  load('./Cherubino/IMG_0011.pm');
P2 =  load('./Cherubino/IMG_0012.pm');

I1 = imread('./Cherubino/IMG_0011.JPG');
I2 = imread('./Cherubino/IMG_0012.JPG');
figure(1)
imshow(I1);
figure(2);
imshow(I2);

[H1,H2,Pn1,Pn2] = rectifyP(P1,P2);

[I1r,I2r, bb1, bb2] = imrectify(I1,I2,H1,H2,'valid');

figure(3)
imshow(uint8(I1r));
figure(4);
imshow(uint8(I2r));

%%
disp('Computing stereo...')
[imo,val]=imstereo_ncc(I2r,I1r,[300,490],15);

%to get a cleaner map
mask= imread('./Cherubino/IMG_0012_mask.png');
maskr = imwarp(single(rgb2gray(mask)),@(x)htx(inv(H2),x), bb2);
imo(~logical(maskr) | val>.995 ) = nan;

figure(5);
imshow(imo,[],'InitialMagnification','fit');
title('Disparita NCC');
colorbar
disp('Done')

%% Reconstruct from disparity
[v,u] = meshgrid(1:size(imo,2), 1:size(imo,1));
M = triang_disp(u,v,imo,Pn2,Pn1);

%Change the sample rate to have a denser or sparser cloud of points
sr=100;
Clv=([I2r(:),I2r(:),I2r(:) ]./255);

figure(6);
scatter3(M(1,1:sr:end),M(2,1:sr:end),M(3,1:sr:end),2, Clv(1:sr:end,:));
axis equal
