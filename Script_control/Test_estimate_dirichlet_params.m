% Generate some sample data from a known Dirichlet distribution for testing
rng(1);  % For reproducibility
alpha_true = [2, 5, 3];
X = drchrnd(alpha_true, 1000);  % Generate 1000 samples

% Estimate the parameters
alpha_estimated = estimate_dirichlet_params(X);
disp('Estimated alpha:');
disp(alpha_estimated);

% Helper function to generate Dirichlet samples
function r = drchrnd(a,n)
    p = length(a);
    r = gamrnd(repmat(a,n,1),1,n,p);
    r = r ./ sum(r,2);
end