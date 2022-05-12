clear all
close all
clc

img = imread('2_tri2.jpg');

% Object with 4 values coordinate
Mi = [0,0,2,1;
    7.5,0,2,1;
    7.5,13.5,2,1;
    0,13.5,2,1;
    7.5,0,0,1;
    7.5,13.5,0,1];

fig1 = figure(1);

imshow(img);
hold on;

% Get points from image
xc = [];
yc = [];
i = 0;
while i < 6
    [x,y] = ginput(1);
    xc = [xc;x];
    yc = [yc;y];
    scatter(x, y,'g','+');
    text(x,y,strcat('.    ',num2str(i+1)));
    i = i+1;
end

mi = [xc,yc,ones(6,1)];

% build matrix to solve with svd
A = [];
for i = 1:6
    a = mi(i,:)';
    ax = [0,-a(3,1),a(2,1);
        a(3,1),0,-a(1,1);
        -a(2,1), a(1,1), 0];
    kro = kron(ax, Mi(i,:));
    A = [A;kro(1,:); kro(2,:)];
end

% solve svd to get the solution vector, linear problem
[U,S,V] = svd(A,'econ');
vecP = V(:,size(A,2));

% Compute full perspective matrx
P = [vecP(1,1),vecP(2,1),vecP(3,1),vecP(4,1);
    vecP(5,1),vecP(6,1),vecP(7,1),vecP(8,1);
    vecP(9,1),vecP(10,1),vecP(11,1),vecP(12,1)];

P
save('direct_calib.mat','P');

% Calculate reprojection
m_reproj = [];
for j = 1:6
   mcurrent = P*(Mi(j,:).');
   m_reproj = [m_reproj;mcurrent.'/mcurrent(3,1)];
end

% Plot reprojected points and mark them
for k = 1:6
    scatter(m_reproj(k,1),m_reproj(k,2),'r');
    scatter(xc(k,1),yc(k,1),'g','+');
    text((m_reproj(k,1)),(m_reproj(k,2)),strcat('.    ',num2str(k)));
end
