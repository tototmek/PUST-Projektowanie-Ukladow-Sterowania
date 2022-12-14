function E = PID_normal(X)
    K = X(1);
    Ti = X(2);
    Td = X(3);
    n=1000;
    
    U_min = -1;
    U_max = 1;
    
    global Upp;
    global Ypp;

%     Y_zad = get_steering_trajectory();
    Y_zad(1:10) = Ypp - 0.01;
    Y_zad(10:1000) = Ypp + 0.01; 
    
    U(1:6) = Upp;
    Y(1:6) = Ypp;
    e(1:7) = 0;
    Tp = 0.5;

    r0 = K * (1 + (Tp/(2*Ti)) + (Td/Tp));
    r1 = K * ((Tp/(2*Ti)) - 2 * (Td/Tp) - 1);
    r2 = K * Td / Tp;

    
    for k=7:n
        Y(k)=symulacja_obiektu5y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));

        e(k) = Y_zad(k) - Y(k);

        du = r0 * e(k) + r1 * e(k-1) + r2 * e(k-2);

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
