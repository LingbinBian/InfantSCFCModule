% Parameters of the first Dirichlet distribution
alpha1 = [3, 4, 15];

% Parameters of the second Dirichlet distribution
alpha2 = [3, 4, 2];

% Calculate the Chernoff coefficient
C = chernoff_coefficient(alpha1, alpha2);
disp('Chernoff Coefficient:');
disp(C);