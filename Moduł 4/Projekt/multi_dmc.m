function [u, y, y_zad] = multi_dmc(D, N, Nu, lambda, mi)
    % Parametry procesu
    ny = 3;
    nu = 4;

    % Wczytanie modelu odpowiedzi skokowej
    data = load("s.mat");
    s =  data.s;

    % Obliczenia offline dla regulatora DMC
    Psi = zeros(ny * N, ny * N);
    for i = 1:ny
        for j = 1:N
            index = i + ny * (j-1);
            Psi(index, index) = mi(i);
        end
    end
    
    Lambda = zeros(nu * Nu, nu * Nu);
    for i = 1:nu
        for j = 1:Nu
            index = i + nu * (j-1);
            Lambda(index, index) = lambda(i);
        end
    end
    
    for i = 1:N
        for j = 1:Nu
            index = i - j + 1;
            if index < 1
                M{i, j} = zeros(ny, nu);
            else
                M{i, j} = squeeze(s(index, :, :));
            end
        end
    end
    M = cell2mat(M);

    K = (M' * Psi * M + Lambda)^-1 * M' * Psi;

    for i=1:N
        for j=1:D-1
           MP{i, j} = squeeze(s(i+j, :, :)) - squeeze(s(j, :, :));
        end
    end
    MP = cell2mat(MP);

    % Definicja sygnałów zadanych
    y_zad = trajektoria_zadana();
    sim_length = size(y_zad, 2);

    % Deklaracja potrzebnych zmiennych
    u = zeros(4, sim_length);
    y = zeros(3, sim_length);

    dUp = zeros(nu * (D - 1), 1);
    Y = zeros(ny * N, 1);
    Y_zad = zeros(ny * N, 1);

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

        % Obliczenia online dla regulatora DMC
        for i = 1:(D-1)
            for j = 1:nu
                if k - i - 1 < 1
                    dUp(nu * (i - 1) + j) = 0;
                else
                    dUp(nu * (i - 1) + j) = u(j, k - i) - u(j, k - i - 1);
                end
            end
        end

        for i = 1:N
            for j = 1:ny
                Y(ny * (i - 1) + j) = y(j, k);
                Y_zad(ny * (i - 1) + j) = y_zad(j, k);
            end
        end

        dU = K * (Y_zad - Y - MP * dUp);

        for i = 1:nu
            u(i, k) = u(i, k-1) + dU(i);
        end
    end
end
