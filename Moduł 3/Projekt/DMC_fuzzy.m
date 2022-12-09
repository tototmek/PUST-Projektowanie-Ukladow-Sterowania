function [U, Y, E] = DMC_fuzzy()

    reg_u = [-0.75, 0.25, 0.5]';
    reg_y = zeros(size(reg_u));
    n_regs = size(reg_u, 1);
    for n = 1:n_regs
        reg_y(n) = wartosc_y(reg_u(n));
    end
    plot(reg_u, reg_y, 'o');
    reg_params = [100 74 2 1;
                  100 74 2 1;
                  100 74 2 1];
    
    membership_functions = [-2, -1, -1, -0.5;
                            -1, -0.5, 0, 0.5;
                            0, 0.5, 1, 2];

    %plot_membership_functions(membership_functions);


    n_s = 500;
    for index=1:n_regs
        D = reg_params(index, 1);
        N = reg_params(index, 2);
        Nu = reg_params(index, 3);
        lambda = reg_params(index, 4);
        s = lokalny_model_odp_skok(reg_u(index), reg_y(index));
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
        K_matrix(index, :, :) = K;
        MP_matrix(index, :, :) = MP;
        dUP_matrix(index, :) = dUP;
    end
    
    n=1000;
    Y_zad = get_steering_trajectory();
    U_min = -1;
    U_max = 1;
    U(1:6) = 0;
    Y(1:6) = 0;
    
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

    for k=7:n
        Y(k)=symulacja_obiektu5y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
        
        for p=1:D-1
            dUP(p) = 0;
            if k-p >0
                dUP(p)=dUP(p) + U(k-p);
            end
            if k-p-1 > 0
                dUP(p) = dUP(p) - U(k-p-1);
            end
        end
        
        Y_zad_dmc = Y_zad(k)*ones(N,1);
        Y0 = Y(k)*ones(N,1)+MP*dUP;
        dU = K*(Y_zad_dmc-Y0);

        U(k) = dU(1) + U(k-1);

        if U(k) > U_max - Upp
            U(k) = U_max - Upp;
        end

        if U(k) < U_min
            U(k) = U_min;
        end

    end

    % Obliczenie wartości wskaźnika jakości regulacji
    E = sum((Y_zad - Y).^2);
end
