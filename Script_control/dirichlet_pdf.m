function p = dirichlet_pdf(X, alpha)
    % X is an N-by-K matrix where each row is a point in the K-dimensional simplex
    % alpha is a 1-by-K vector of Dirichlet parameters
    gamma_prod = prod(gamma(alpha));
    gamma_sum = gamma(sum(alpha));
    p = gamma_sum / gamma_prod * prod(X.^(alpha - 1), 2);
end