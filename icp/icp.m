% Implement a matlab script that given two cloud of points 
% it finds the rigid transformation that align them. 
clear 
close all

% Get two clouds of points
cloud_points1 = [
    1 1 1;
    1 1 2;
    1 1 3;
    1 1 4;
    1 1 5;
];
cloud_points2 = [
    6 1 1;
    6 1 2;
    6 1 3;
    6 1 4;
    6 1 5;
];

% Display the two clouds of 3d points
figure;
plot3(cloud_points1(:,1), cloud_points1(:,2), cloud_points1(:,3));hold on
plot3(cloud_points2(:,1), cloud_points2(:,2), cloud_points2(:,3));

% Apply ICP algorithm and calculate the rigid transformation
model = cloud_points2;
data = cloud_points1;
eps = 0.00000001;
maxiter = 100;

G=eye(4);
res = inf;
prevres = 0;
i=0; % iterations counter
while ((abs(res-prevres)> eps) && i < maxiter)
    i = i+1;
    prevres = res;
    % apply current transformation bringing data onto model 
    dataREG = rigid(G,data);
    [mindist,modelCP] = closestp(dataREG,model);

    res = mean(mindist);

    % compute incremental tranformation
    GI = absolute(modelCP,dataREG);
    G = GI * G;
end
Gi = G;
 
cloud_points_final = rigid(Gi,cloud_points1);

% Display the two alligned cloud of points
figure;
plot3(cloud_points2(:,1), cloud_points2(:,2), cloud_points2(:,3)); hold on
plot3(cloud_points_final(:,1), cloud_points_final(:,2), cloud_points_final(:,3));
