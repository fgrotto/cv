% Calculation of homography Matrix
clear all;
close all;
clc;

% Two images that comes from an approximate rotation of the camera
img1=imread('house1.jpg');
img2=imread('house2.jpg');

% Use grayscale images
img1=rgb2gray(img1);
img2=rgb2gray(img2);

figure(1)
imshow(img1);
figure(2)
imshow(img2);

% I collect 8 points necessary for the 8 points algorithm
p1=[];
p2=[];
for i=1:8
    figure(1); 
    hold on,
    [x, y]=ginput(1);
    plot(x,y,'r*');
    p1=[p1; x, y];

    figure(2); 
    hold on
    [x, y]=ginput(1);
    plot(x,y,'g*'); 
    p2=[p2; x, y];
end

p1=p1';
p2=p2';

% Calculate the homography matrix solving the linear system
% (mi^T kron [mi'])vect(H) = 0
% 
% mi are points from the first image 
% mi' are points from the second image
A=[];
for i=1:size(p1,2)
    m1=[p1(:,i);1];
    m2=[p2(:,i);1];
    
    mi=[0 -m2(3) m2(2); 
                  m2(3) 0 -m2(1);
                 -m2(2) m2(1) 0];

    kro=kron(m1', mi);

    A=[A; kro(1,:);kro(2,:)];
end

[U, D, V] = svd(A);
h = V(:,end);

% Since we otained the result in a column vector
% we need to apply the reshape to 3x3 matrix
H = reshape(h,3,3);
H=H./H(3,3);

% save('house_H.mat', 'H');

%% Use the H matrix to merge the two existing matrixes (got from solutions)

H = load('house_H.mat').H

% img_rect=imwarp(img2,inv(H), 'linear', 'valid');
% figure;
% i = imshow(uint8(img_rect));
% set(i, 'AlphaData', 0.5)
% hold on;
% i = imshow(uint8(img1));
% set(i, 'AlphaData', 0.5)


[img_wrap_mos, bb, alpha]=imwarp(img2,inv(H), 'linear', 'valid');
ind=find(isnan(img_wrap_mos));
img_wrap_mos(ind)=0;

bb_ij(1)=bb(2); bb_ij(2)=bb(1); bb_ij(3)=bb(4); bb_ij(4)=bb(3);
bb_ij=bb_ij';


bb_1=[0; 0; size(img1)'];
corners=[bb_ij bb_1];

minj = min(corners(2,:));
mini = min(corners(1,:));
maxj = max(corners(4,:));
maxi = max(corners(3,:));

bb_mos=[mini; minj; maxi; maxj];

offs=[abs(mini); abs(minj)];

sz_mos=bb_mos+[offs; offs];

if(sz_mos(1)==0 && sz_mos(2)==0) 
    mosaic_ref=zeros(sz_mos(3), sz_mos(4));
    mosaic_mov=mosaic_ref;
    mosaic_out=mosaic_ref;
else
    disp('somethig wrong...'); 
end


if((offs(1)>0) && (offs(2)>0))
    mosaic_ref(offs(1):(size(img1,1)+offs(1)-1),offs(2):(size(img1,2)+offs(2)-1))=img1(:,:);
    mosaic_mov(1:(size(img_wrap_mos,1)),1:size(img_wrap_mos,2))=img_wrap_mos(:,:);
end

if ((offs(1)>0) && (offs(2)==0))
    mosaic_ref(offs(1):(size(img1,1)+offs(1)-1),1:size(img1,2))=img1(:,:);
    mosaic_mov(1:size(img_wrap_mos,1),abs(bb_ij(2)):(size(img_wrap_mos,2)+abs(bb_ij(2))-1))=img_wrap_mos(:,:);
end
    
if ((offs(1)==0) && (offs(2)>0))
    mosaic_ref(1:size(img1,1),offs(2):(size(img1,2)+offs(2)-1))=img1(:,:);
    mosaic_mov(bb_ij(1):(size(img_wrap_mos,1)+bb_ij(1)-1),1:size(img_wrap_mos,2))=img_wrap_mos(:,:);
end

if ((offs(1)==0) && (offs(2)==0))
    mosaic_ref(1:size(img1,1),1:size(img1,2))=img1(:,:);
    mosaic_mov(bb_ij(1):(size(img_wrap_mos,1)+bb_ij(1)-1),bb_ij(2):(size(img_wrap_mos,2)+bb_ij(2)-1))=img_wrap_mos(:,:);
end
    


% Ouput:
mosaic_out=mosaic_ref.*0.5+mosaic_mov.*0.5;

figure(100)
imshow(uint8(mosaic_out))
