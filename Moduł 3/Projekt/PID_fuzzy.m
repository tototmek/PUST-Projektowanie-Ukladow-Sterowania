function [U, Y, E] = PID_fuzzy()
    Tp = 0.5;
    % Długość symulacji
    n=1000;
    % Ograniczenia sterowania
    U_min = -1;
    U_max = 1;
    % Wczytanie [przebiegu sygnału sterującego
    Y_zad = get_steering_trajectory();
    % Inicjalizacja potrzebnych wektorów
    U(1:6) = 0;
    Y(1:6) = 0;
    e(1:7) = 0;
    % Parametry regulatorów lokalnych
    u_points = [-0.9, 0.25, 0.75];
    for i = 1:3
        y_points(i) = get_y_at(u_points(i));
    end
    n_regulators = size(y_points, 2);
    reg_params = zeros(n_regulators, 3);
    for i = 1:n_regulators
        reg_params(i, :) = get_pid_params(u_points(i), y_points(i));
    end
    disp(reg_params)
    % Definicja funkcji przynależności
    membership_functions = [-1, -1, -0.5, 0;
                            -0.5, 0.5, 1, 1.5;
                            1, 1.5, 6, 6];
    plot_membership_functions(membership_functions);
    hold on
    % Wyznaczenie parametrów r regulatorów lokalnych
    r0 = zeros(n_regulators, 1);
    r1 = zeros(n_regulators, 1);
    r2 = zeros(n_regulators, 1);
    for i = 1:n_regulators
        r0(i) = reg_params(i, 1) * (1 + (Tp/(2*reg_params(i, 2))) + (reg_params(i, 3)/Tp));
        r1(i) = reg_params(i, 1) * ((Tp/(2*reg_params(i, 2))) - 2 * (reg_params(i, 3)/Tp) - 1);
        r2(i) = reg_params(i, 1) * reg_params(i, 3) / Tp;
    end
    
    for k=7:n
        % Symulacja obiektu
        Y(k)=symulacja_obiektu5y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
        % Prawo regulacji rozmytej
        e(k) = Y_zad(k) - Y(k);
        du = 0;
        mi_sum = 0;
        for i = 1:n_regulators
            mi = trapmf(Y(k), membership_functions(i, :));
            du = mi * (r0(i) * e(k) + r1(i) * e(k-1) + r2(i) * e(k-2));
            mi_sum = mi_sum + mi;
        end
        du = du / mi_sum;
        U(k) = du(1) + U(k-1);
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
end