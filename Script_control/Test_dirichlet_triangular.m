

% Parameters for the Dirichlet distribution

alpha=[2, 5, 3];
num_samples = 1000;

% Generate samples
samples = drchrnd(alpha, num_samples);

% Extract the samples
x = samples(:, 1);
y = samples(:, 2);
z = samples(:, 3);

% Convert (x, y, z) to ternary plot coordinates
ternary_coords = [0.5 * (2 * y + z) ./ (x + y + z), sqrt(3) * z ./ (x + y + z)];

% Create figure and hold on
figure;
hold on;

% Define the vertices of the triangle
triangle_vertices = [0, 0; 1, 0; 0.5, sqrt(3)/2];

% Plot the triangle
fill(triangle_vertices(:, 1), triangle_vertices(:, 2), 'w', 'EdgeColor', 'k', 'LineWidth', 1.5);

% Add grid lines
grid_points = 0:0.1:1;
for i = 1:length(grid_points)
    % Lines parallel to AB
    plot([grid_points(i), 0.5*(1 + grid_points(i))], [0, sqrt(3)/2*(1 - grid_points(i))], '--', 'Color', [0.8, 0.8, 0.8]);
    % Lines parallel to AC
    plot([0.5*grid_points(i), 1 - 0.5*grid_points(i)], [sqrt(3)/2*grid_points(i), sqrt(3)/2*grid_points(i)], '--', 'Color', [0.8, 0.8, 0.8]);
    % Lines parallel to BC
    plot([1 - grid_points(i), 0.5*(1 - grid_points(i))], [0, sqrt(3)/2*(1 - grid_points(i))], '--', 'Color', [0.8, 0.8, 0.8]);
end

% Plot the samples with customized markers
scatter(ternary_coords(:, 1), ternary_coords(:, 2), 15, 'filled', 'MarkerFaceAlpha', 0.7, 'MarkerEdgeColor', 'k');

% Annotate the triangle
text(-0.05, -0.05, 'A', 'FontSize', 14, 'FontWeight', 'bold');
text(1.05, -0.05, 'B', 'FontSize', 14, 'FontWeight', 'bold');
text(0.5, sqrt(3)/2 + 0.05, 'C', 'FontSize', 14, 'FontWeight', 'bold');

% Add axis ticks
text(-0.05, 0.5*sqrt(3)/2, '0.5', 'FontSize', 10, 'Color', 'k');
text(0.5, -0.05, '0.5', 'FontSize', 10, 'Color', 'k');
text(0.75, 0.25*sqrt(3)/2, '0.5', 'FontSize', 10, 'Color', 'k');

% Set axis properties
axis equal;
axis off;
title('Fancy Ternary Plot of Dirichlet Distribution', 'FontSize', 14);

hold off;

function r = drchrnd(a, n)
    p = length(a);
    r = gamrnd(repmat(a, n, 1), 1, n, p);
    r = r ./ sum(r, 2);
end