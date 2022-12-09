function [U, Y, E] = PID_fuzzy()

    % Parametry regulatorów lokalnych
    % Punkty pracy
    reg_u = [-0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75]';
    reg_y = zeros(size(reg_u));
    n_regs = size(reg_u, 1);
    for n = 1:n_regs
        reg_y(n) = wartosc_y(reg_u(n));
    end
    % Parametry K, Ti, Td
    reg_params = [0.6 7 0.2;
                  0.3 7 0.2;
                  0.25 7 0.2;
                  0.2 7 0.2;
                  0.2 7 0.2;
                  0.15 7 0.2;
                  0.08 7 0.2];
    % Parametry funkcji przynależności
    membership_functions = [-10, -10, (2*reg_u(1)+reg_u(2)) / 4, (reg_u(1)+2*reg_u(2)) / 4;
                            (3*reg_u(1)+reg_u(2)) / 4, (reg_u(1)+3*reg_u(2)) / 4, (3*reg_u(2)+reg_u(3)) / 4, (reg_u(2)+3*reg_u(3)) / 4;
                            (3*reg_u(2)+reg_u(3)) / 4, (reg_u(2)+3*reg_u(3)) / 4, (3*reg_u(3)+reg_u(4)) / 4, (reg_u(3)+3*reg_u(4)) / 4;
                            (3*reg_u(3)+reg_u(4)) / 4, (reg_u(3)+3*reg_u(4)) / 4, (3*reg_u(4)+reg_u(5)) / 4, (reg_u(4)+3*reg_u(5)) / 4;
                            (3*reg_u(4)+reg_u(5)) / 4, (reg_u(4)+3*reg_u(5)) / 4, (3*reg_u(5)+reg_u(6)) / 4, (reg_u(5)+3*reg_u(6)) / 4;
                            (3*reg_u(5)+reg_u(6)) / 4, (reg_u(5)+3*reg_u(6)) / 4, (3*reg_u(6)+reg_u(7)) / 4, (reg_u(6)+3*reg_u(7)) / 4;
                            (3*reg_u(6)+reg_u(7)) / 4, (reg_u(6)+3*reg_u(7)) / 4, 10, 10];
    % Wyznaczenie współczynników r dla regulatorów lokalnych
    Tp = 0.5;
    r0 = zeros(n_regs, 1);
    r1 = zeros(n_regs, 1);
    r2 = zeros(n_regs, 1);
    for i = 1:n_regs
        K = reg_params(i, 1);
        Ti = reg_params(i, 2);
        Td = reg_params(i, 3);
        r0(i) = K * (1 + (Tp/(2*Ti)) + (Td/Tp));
        r1(i) = K * ((Tp/(2*Ti)) - 2 * (Td/Tp) - 1);
        r2(i) = K * Td / Tp;
    end
    
    % Parametry symulacji
    n=1000;
    Y_zad = get_steering_trajectory();
    U_min = -1;
    U_max = 1;
    U(1:6) = 0;
    Y(1:6) = 0;
    e = zeros(n, 1);
    % Symulacja
    for k=7:n
        % Symulacja obiektu
        Y(k)=symulacja_obiektu5y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));

        % Prawo regulacji rozmytej
        e(k) = Y_zad(k) - Y(k);
        du = 0;
        total_mi = 0;
        for i = 1:n_regs
            mi = trapmf(U(k-1), membership_functions(i, :));
            du = du + mi * (r0(i) * e(k) + r1(i) * e(k-1) + r2(i) * e(k-2));
            total_mi = total_mi + mi;
        end
        U(k) = du/total_mi + U(k-1);

        % Ograniczenie sygnału sterującego
        if U(k) > U_max
            U(k) = U_max;
        end
        if U(k) < U_min
            U(k) = U_min;
        end
    end

    % Obliczenie wartości wskaźnika jakości regulacji
    E = sum((Y_zad - Y).^2);

    % Wyświetlenie wyników symulacji
    plot_results(Y, U, E, Y_zad);
    plot_membership_functions(membership_functions);
    plot_fuzzy_points(reg_u, reg_y);
end