function optymalizacja_nastaw()
    % Algorytm DMC
    [X] = fmincon(@dmc_e, [0.25 0.45 0.05 0.27 1 1.5 1.6], ...
              [], [], [], [], ...
              [0.001 0.001 0.001 0.001 0 0 0], ...
              [100 100 100 100 10 10 10]);
    disp(X);
    [u, y, y_zad] = multi_pid(100, 23, 12, X(1:4), X(5:7));
    plot_output(u, y, y_zad);

    % Algorytm PID
    [X] = fmincon(@pid_e, [1, 1.6, 1.2, 2, 3, 5, 0, 0, 0], ...
              [], [], [], [], ...
              [0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0, 0, 0], ...
              [100 100 100 100 100 100 0.1 0.1 0.1]);
    disp(X);
    [u, y, y_zad] = multi_pid(X(1:3), X(4:6), X(7:9));
    plot_output(u, y, y_zad);
end

function E = dmc_e(X)
    D = 100;
    N = 23;
    Nu = 12;
    lambda = X(1:4);
    mi = X(5:7);
    [~, y, y_zad] = multi_dmc(D, N, Nu, lambda, mi);
    E = 0;
    for i = 1:3
        E = E + sum((y_zad(i, :) - y(i, :)).^2);
    end
    disp(E);
end

function E = pid_e(X)
    K = X(1:3);
    Ti = X(4:6);
    Td = X(7:9);
    [~, y, y_zad] = multi_pid(K, Ti, Td);
    E = 0;
    for i = 1:3
        E = E + sum((y_zad(i, :) - y(i, :)).^2);
    end
    disp(E);
end
