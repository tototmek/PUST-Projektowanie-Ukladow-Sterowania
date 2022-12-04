function [U, Y, E] = PID_fuzzy()
    n=1000;

    Ypp = 0;
    Upp = 0;
    
    U_min = -1;
    U_max = 1;
    
    Y_zad = get_steering_trajectory();
    
    U(1:6) = Upp;
    Y(1:6) = Ypp;
    e(1:7) = 0;
    Tp = 0.5;
    
    K = [2, 0.5, 0.1];
    Ti = [1, 7, 12];
    Td = [0.1, 0.1, 0.1];
    n_regulators = size(K, 2);

    r0 = zeros(n_regulators, 1);
    r1 = zeros(n_regulators, 1);
    r2 = zeros(n_regulators, 1);
    
    % You can setup these functions manually if you want to
    membership_functions = get_membership_functions(n_regulators, [U_min, U_max]);

    for i = 1:n_regulators
        r0(i) = K(i) * (1 + (Tp/(2*Ti(i))) + (Td(i)/Tp));
        r1(i) = K(i) * ((Tp/(2*Ti(i))) - 2 * (Td(i)/Tp) - 1);
        r2(i) = K(i) * Td(i) / Tp;
    end
    
    for k=7:n
        Y(k)=symulacja_obiektu5y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));

        e(k) = Y_zad(k) - Y(k);

        du = 0;
        for i = 1:n_regulators
            du = du + trapmf(U(k-1), membership_functions(i, :)) * (r0(i) * e(k) + r1(i) * e(k-1) + r2(i) * e(k-2));
        end

        U(k) = du(1) + U(k-1);

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