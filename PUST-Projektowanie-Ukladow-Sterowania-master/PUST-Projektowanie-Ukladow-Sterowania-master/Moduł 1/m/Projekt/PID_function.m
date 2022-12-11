function [U, Y, E] = PID_function(K, Ti, Td)
    init

    r0 = K * (1 + (Tp/(2*Ti)) + (Td/Tp));
    r1 = K * ((Tp/(2*Ti)) - 2 * (Td/Tp) - 1);
    r2 = K * Td / Tp;
    
    U(1:11) = Upp;
    Y(1:11) = Ypp;
    e(1:12) = 0;

    u=U-Upp;
    y=Y-Ypp;

    y_zad = Y_zad - Ypp;

    for k=12:T
        Y(k)=symulacja_obiektu5Y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));

        y(k) = Y(k) - Ypp;
        e(k) = y_zad(k) - y(k);

        du = r0 * e(k) + r1 * e(k-1) + r2 * e(k-2);

        if du > dU_max
            du = dU_max;
        end

        if du < -dU_max
            du = -dU_max;
        end

        u(k) = du(1) + u(k-1);

        if u(k) > U_max - Upp
            u(k) = U_max - Upp;
        end

        if u(k) < U_min - Upp
            u(k) = U_min  - Upp;
        end

        U(k) = u(k) + Upp;
    end

    % Obliczenie wartości wskaźnika jakości regulacji
    E = sum((Y_zad - Y).^2);
end