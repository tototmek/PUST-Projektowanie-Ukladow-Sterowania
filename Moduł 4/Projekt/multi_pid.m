function [u, y, y_zad] = multi_pid(K, Ti, Td)
    % Na podstawie odpowiedzi skokowych sla różnych torów
    % zdecydowałem, że najlepiej będzie zastosować 3 pidy,
    % u2, y1
    % u3, y2
    % u4, y3

    % Nastawy regulatorów
    % K = [1, 1.6, 1.2];
    % Ti = [2, 3, 5];
    % Td = [0.1, 1, 2];
    % Czas próbkowania
    Tp = [0.5, 0.5, 0.5];

    % Wyliczenie parametrów regulatorów PID
    r0 = K .* (1 + (Tp./(2*Ti)) + (Td./Tp));
    r1 = K .* ((Tp./(2*Ti)) - 2 * (Td./Tp) - 1);
    r2 = K .* Td ./ Tp;

    % Definicja sygnałów zadanych
    y_zad = trajektoria_zadana();
    sim_length = size(y_zad, 2);

    % Deklaracja potrzebnych zmiennych
    u = zeros(4, sim_length);
    y = zeros(3, sim_length);
    e = zeros(3, sim_length);

    for k=5:sim_length
        % Symulacja obiektu
        [y(1, k), y(2, k), y(3, k)] = symulacja_obiektu5y_p4(...
          u(1, k-1), u(1, k-2), u(1, k-3), u(1, k-4), ...
          u(2, k-1), u(2, k-2), u(2, k-3), u(2, k-4), ...
          u(3, k-1), u(3, k-2), u(3, k-3), u(3, k-4), ...
          u(4, k-1), u(4, k-2), u(4, k-3), u(4, k-4), ...
          y(1, k-1), y(1, k-2), y(1, k-3), y(1, k-4), ...
          y(2, k-1), y(2, k-2), y(2, k-3), y(2, k-4), ...
          y(3, k-1), y(3, k-2), y(3, k-3), y(3, k-4));
      
        % Wyznaczenie uchybu
        e(1, k) = y_zad(1, k) - y(1, k);
        e(2, k) = y_zad(2, k) - y(2, k);
        e(3, k) = y_zad(3, k) - y(3, k);

        % Wyliczenie sterowania regulatorów
        u(1, k) = 0;
        u(2, k) = u(2, k-1) + r0(1) * e(1, k) + r1(1) * e(1, k-1) +  r2(1) * e(1, k-2);
        u(3, k) = u(3, k-1) + r0(2) * e(2, k) + r1(2) * e(2, k-1) +  r2(2) * e(2, k-2);
        u(4, k) = u(4, k-1) + r0(3) * e(3, k) + r1(3) * e(3, k-1) +  r2(3) * e(3, k-2);
    end
end
