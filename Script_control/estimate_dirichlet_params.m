function alpha = estimate_dirichlet_params(X)
    % X: n x d matrix of samples from a Dirichlet distribution
    [n, d] = size(X);
    
    % Initial guess for alpha
    alpha0 = ones(1, d);

    % Log-likelihood function
    function ll = log_likelihood(alpha)
        ll = n * (gammaln(sum(alpha)) - sum(gammaln(alpha))) ...
             + sum(sum(bsxfun(@times, (alpha - 1), log(X))));
        ll = -ll;  % We minimize in MATLAB, so take the negative of the log-likelihood
    end

    % Set optimization options
    options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point');

    % Constraints: alpha > 0
    lb = zeros(1, d) + eps;  % Lower bound
    ub = [];  % No upper bound

    % Optimize
    alpha = fmincon(@log_likelihood, alpha0, [], [], [], [], lb, ub, [], options);
end