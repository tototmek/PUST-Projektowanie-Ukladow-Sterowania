function plot_membership_functions(fun_params)
    n_regulators = size(fun_params, 1);
    figure;
    x = (-1:0.001:5);
    hold on;
    for i = 1:n_regulators
        func = trapmf(x, fun_params(i, :));
        plot(x, func);
    end