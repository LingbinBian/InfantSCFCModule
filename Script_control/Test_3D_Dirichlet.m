clear
clc
close all

% Parameters for the Dirichlet distribution
alpha = [20, 5, 10];
num_samples = 1000;

% Generate samples
samples = drchrnd(alpha, num_samples);

% Extract the samples
x = samples(:, 1);
y = samples(:, 2);
z = samples(:, 3);

% Create 3D scatter plot
figure;
scatter3(x, y, z, 10, 'filled');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Scatter Plot of Dirichlet Distribution');
grid on;
axis equal;

% Create 3D scatter plot with customizations
figure;
scatter3(x, y, z, 15, z, 'filled'); % Color by z-value
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Scatter Plot of Dirichlet Distribution');
grid on;
axis equal;
colormap jet; % Change color map
colorbar; % Add color bar


function r = drchrnd(a,n)
    p = length(a);
    r = gamrnd(repmat(a,n,1),1,n,p);
    r = r ./ sum(r,2);
end





