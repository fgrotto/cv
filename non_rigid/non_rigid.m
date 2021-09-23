%% PCA su set
load('cat5.mat');
num_subject =3400;
n_basis=3;

datas(:,1) = surface.X;
datas(:,2) = surface.Y;
datas(:,3) = surface.Z;

% datas = reshape(object,[],num_subjects);
mshape=mean(datas,2);
mshapes = repmat(mshape,1,3);
[coeff, basis] = pca(datas-mshapes);

% Nomalize it
% for i=1:n_basis
%     basis(:,i)=basis(:,i)/norm(basis(:,i));
% end

plot3(datas(:,1), datas(:,2), datas(:,3), '.b');
hold on;
plot3(basis(:,1), basis(:,2), basis(:,3), '.r');