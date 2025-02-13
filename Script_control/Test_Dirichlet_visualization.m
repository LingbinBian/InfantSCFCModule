% Define the Dirichlet parameters
alpha = [2, 3, 5];

% Generate grid points over the 2D simplex (ternary plot)
n = 100; % Number of grid points
[x, y] = meshgrid(linspace(0, 1, n), linspace(0, 1, n));
z = 1 - x - y;
valid = z >= 0;

x = x(valid);
y = y(valid);
z = z(valid);

% Evaluate the Dirichlet PDF
pdf = dirichlet_pdf([x, y, z], alpha);

% Plot the distribution
figure;
scatter3(x, y, z, 10, pdf, 'filled');
xlabel('x');
ylabel('y');
zlabel('z');
title('Dirichlet Distribution');
colorbar;
view(2);


function p = dirichlet_pdf(X, alpha)
    % X is an N-by-K matrix where each row is a point in the K-dimensional simplex
    % alpha is a 1-by-K vector of Dirichlet parameters
    gamma_prod = prod(gamma(alpha));
    gamma_sum = gamma(sum(alpha));
    p = gamma_sum / gamma_prod * prod(X.^(alpha - 1), 2);
end