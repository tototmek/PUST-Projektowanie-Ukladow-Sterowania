function [U, Y, E] = DMC_fuzzy()

    % Parametry regulatorów lokalnych
    % Punkty pracy
    reg_u = [-0.75, 0.75]';
    % reg_u = [-0.75, 0.5, 0.75]';
    % reg_u = [-0.75, 0.25, 0.5, 0.75]';
    % reg_u = [-0.75, -0.25, 0.25, 0.5, 0.75]';
    % reg_u = [-0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75]';
    reg_y = zeros(size(reg_u));
    n_regs = size(reg_u, 1);
    for n = 1:n_regs
        reg_y(n) = wartosc_y(reg_u(n));
    end
    % Parametry D, N, Nu, lambda
    reg_params = [100 100 16 1
                  100 75 14 1];
    % reg_params = [100 100 16 1;
    %               100 60 15  1;
    %               100 75 14  1];
    % reg_params = [100 100 16 1;
    %               100 32 14 1;
    %               100 18 15 1;
    %               100 75 14 1];
    % reg_params = [100 100 16 1;
    %               100 90 15 1;
    %               100 32 14 1;
    %               100 18 15 1;
    %               100 75 14 1];
    % reg_params = [100 100 16 3;
    %               100 98 16 3;
    %               100 90 15 3;
    %               100 90 16 3;
    %               100 32 14 4;
    %               100 18 15 15;
    %               100 75 14 46];
    % Parametry funkcji przynależności
    membership_functions = zeros(n_regs, 4);
    membership_functions(1, :) = [-10, -10, (3*reg_u(1)+reg_u(2)) / 4, (reg_u(1)+3*reg_u(2)) / 4];
    for index=2:n_regs-1
        membership_functions(index, :) = [(3*reg_u(index-1)+reg_u(index)) / 4, (reg_u(index-1)+3*reg_u(index)) / 4, (3*reg_u(index)+reg_u(index+1)) / 4, (reg_u(index)+3*reg_u(index+1)) / 4];
    end
    membership_functions(end, :) = [(3*reg_u(end-1)+reg_u(end)) / 4, (reg_u(end-1)+3*reg_u(end)) / 4, 10, 10];
    % Wyznaczenie macierzy K, MP, dUP dla każdego regulatora lokalnego
    K_matrix = cell(n_regs, 1);
    MP_matrix = cell(n_regs, 1);
    dUP_matrix = cell(n_regs, 1);
    n_s = 500;
    for index=1:n_regs
        D = reg_params(index, 1);
        N = reg_params(index, 2);
        Nu = reg_params(index, 3);
        lambda = reg_params(index, 4);
        s = lokalny_model_odp_skok(reg_u(index), reg_y(index), n_s);
        M = zeros(N, Nu);
        for i = 1:N
            M(i,1)=s(i);
        end
        for i=2:Nu
            M(i:N,i)=M(1:N-i+1,1);
        end
        MP=zeros(N,D-1);
        for i=1:N
            for j=1:D-1
                MP(i,j)=s(i+j)-s(j);
            end
        end
        K = (M'*M + lambda*eye(Nu, Nu))\M';
        dUP = zeros(D-1, 1);
        K_matrix{index} = K;
        MP_matrix{index} = MP;
        dUP_matrix{index} = dUP;
    end
    
    % Parametry symulacji
    n=1000;
    Y_zad = get_steering_trajectory();
    U_min = -1;
    U_max = 1;
    U(1:6) = 0;
    Y(1:6) = 0;
    
    % Symulacja
    for k=7:n
        % Symulacja obiektu
        Y(k)=symulacja_obiektu5y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
        % Regulator DMC, wersja z regulacją rozmytą
        total_mi = 0;
        du = 0;
        for index=1:n_regs
            D = reg_params(index, 1);
            N = reg_params(index, 2);
            dUP = dUP_matrix{index};
            MP = MP_matrix{index};
            K = K_matrix{index};
            
            for p=1:D-1
                dUP(p) = 0;
                if k-p >0
                    dUP(p)=dUP(p) + U(k-p);
                end
                if k-p-1 > 0
                    dUP(p) = dUP(p) - U(k-p-1);
                end
            end

            dUP_matrix{index} = dUP;
            
            Y_zad_dmc = Y_zad(k)*ones(N,1);
            Y0 = Y(k)*ones(N,1)+MP*dUP;
            dU = K*(Y_zad_dmc-Y0);

            mi = trapmf(U(k-1), membership_functions(index, :));
            total_mi = total_mi + mi;
            du = du + mi*dU(1);
        end
        U(k) = du/total_mi + U(k-1);

        % Ograniczenie wartości sterowania
        if U(k) > U_max
            U(k) = U_max;
        end
        if U(k) < U_min
            U(k) = U_min;
        end
    end

    % Obliczenie wartości wskaźnika jakości regulacji
    E = sum((Y_zad - Y).^2);
    disp(E)
    % Wyświetlenie wyników symulacji
    %plot_results(Y, U, E, Y_zad);
    plot_membership_functions(membership_functions);
    print(sprintf("plots/dmc/%ddmcmf", n_regs), "-depsc", "-r400")
    %plot_fuzzy_points(reg_u, reg_y);
    close all
end
