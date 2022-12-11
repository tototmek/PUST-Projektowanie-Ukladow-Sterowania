function fun_params = get_membership_functions(n_regulators,  bounds)
    distance = abs(bounds(2) - bounds(1));
    d = distance / (n_regulators * 2 - 1);
    current_position = bounds(1);
    fun_params(1, :) = [current_position, current_position, current_position+d, current_position+2*d];
    for i = 2:n_regulators-1
        current_position = current_position + 2 * d;
        fun_params(i, :) = [current_position-d, current_position, current_position+d, current_position+2*d];
    end
    current_position = current_position + 2 * d;
    fun_params(n_regulators, :) = [current_position-d, current_position, current_position+d, current_position+d];

    x = (bounds(1):0.001:bounds(2));
    figure;
    hold on;
    for i = 1:n_regulators
        func = trapmf(x, fun_params(i, :));
        plot(x, func);
    end
end