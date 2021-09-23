clear all;
close all;

P1 = load('2_tri1.mat', 'P').P;
P2 = load('2_tri2.mat', 'P').P;

M1 = [];
M2 = [];

i = 1;
while (i <= 2)
    figure
    img1 = imread('2_tri1.jpg');
    imshow(img1);
    hold on;

    [x1,y1] = ginput(1);
    scatter(x1, y1,'g','+');
    text(x1,y1,strcat('.    ',num2str(i)));

    figure
    img2 = imread('2_tri2.jpg');
    imshow(img2);
    hold on;

    [x2,y2] = ginput(1);
    scatter(x2, y2,'g','+');
    text(x2,y2,strcat('.    ',num2str(i)));

    A = [(P1(1,:) - x1*(P1(3,:)));
        (P1(2,:) - y1*(P1(3,:)));
        (P2(1,:) - x2*(P2(3,:)));
        (P2(2,:) - y2*(P2(3,:)))];

    [U,D,V] = svd(A,0);
    M = V(:,end);
    if (i == 1)
        M1 = M;
    else 
        M2 = M;
    end
    i = i+1;
end

pts1 = [M1(1,:)./M1(4,:) M1(2,:)./M1(4,:) M1(3,:)./M1(4,:)];
pts2 = [M2(1,:)./M2(4,:) M2(2,:)./M2(4,:) M2(3,:)./M2(4,:)];
sqrt(sum((pts1 - pts2 ) .^ 2))




