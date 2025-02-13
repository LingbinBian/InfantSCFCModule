function C = chernoff_coefficient(alpha1, alpha2)
    % alpha1: parameters of the first Dirichlet distribution
    % alpha2: parameters of the second Dirichlet distribution

    % Define the multivariate Beta function
    function B = multivariate_beta(alpha)
        B = prod(gamma(alpha)) / gamma(sum(alpha));
    end

    % Define the Chernoff coefficient function
    t=0.5;
    function C_t = chernoff_t(t)
        B_mixed = multivariate_beta(t*alpha1 + (1-t)*alpha2);
        B1 = multivariate_beta(alpha1);
        B2 = multivariate_beta(alpha2);
        C_t = B_mixed / (B1^t * B2^(1-t));
    end

    % Optimize over t in the interval [0, 1]
    %options = optimset('Display', 'off');
    %[t_opt, C] = fminbnd(@(t) -chernoff_t(t), 0, 1, options);
    %C = -C;  % fminbnd finds the minimum, we need the maximum
    C=chernoff_t(t);
end