% Define the concentration parameters for the Dirichlet distribution
alpha = [2, 3, 4]; % You can change these values

% Generate samples from the Dirichlet distribution
n_samples = 10000;
samples = dirrnd(alpha, n_samples);

% Estimate the marginal densities using kernel density estimation
[f1, xi1] = ksdensity(samples(:, 1));
[f2, xi2] = ksdensity(samples(:, 2));
[f3, xi3] = ksdensity(samples(:, 3));

% Plot the marginal densities
figure;
subplot(3, 1, 1);
plot(xi1, f1, 'LineWidth', 2);
title('Marginal Density of X1');
xlabel('X1');
ylabel('Density');

subplot(3, 1, 2);
plot(xi2, f2, 'LineWidth', 2);
title('Marginal Density of X2');
xlabel('X2');
ylabel('Density');

subplot(3, 1, 3);
plot(xi3, f3, 'LineWidth', 2);
title('Marginal Density of X3');
xlabel('X3');
ylabel('Density');

% Adjust the layout
sgtitle('Marginal Densities of Dirichlet Distribution');


function X = dirrnd(alpha, n)
    % Generate n samples from a Dirichlet distribution with parameters alpha
    p = length(alpha);
    X = gamrnd(repmat(alpha, n, 1), 1, n, p);
    X = X ./ sum(X, 2);
end
