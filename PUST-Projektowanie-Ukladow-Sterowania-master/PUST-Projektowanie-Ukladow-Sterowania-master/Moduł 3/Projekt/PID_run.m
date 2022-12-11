fuzzy = true;

Y_zad = get_steering_trajectory();

if ~fuzzy
    % K=0.266837; Ti=5.119934; Td=0.309450;
    K=0.2; Ti=7; Td=0.2;
    [U, Y, E] = PID_normal(K, Ti, Td);
else
    [U, Y, E] = PID_fuzzy();
end
plot_results(Y, U, E, Y_zad);