function DMC_fuzzy()
    clear all
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM4 % initialise com port
    h = animatedline("Color", "r");
    h_u = animatedline("Color", "b");
    h_y_zad = animatedline("Color", "g");
    k = 10; %% Może powinno być mniej

    U_min=0;
    U_max=100;
    dU_max=20;
    Tp=1.0;
    
    reg_u = [20, 50, 80]';
    reg_y = zeros(size(reg_u));
    n_regs = size(reg_u, 1);

    reg_params = [100 100 16 1;
                  100 60 15 1;
                  100 75 14 1];

    membership_functions(1, :) = [-10, -10, (3*reg_u(1)+reg_u(2)) / 4, (reg_u(1)+3*reg_u(2)) / 4];
        for index=2:n_regs-1
            membership_functions(index, :) = [(3*reg_u(index-1)+reg_u(index)) / 4, (reg_u(index-1)+3*reg_u(index)) / 4, (3*reg_u(index)+reg_u(index+1)) / 4, (reg_u(index)+3*reg_u(index+1)) / 4];
        end
    membership_functions(end, :) = [(3*reg_u(end-1)+reg_u(end)) / 4, (reg_u(end-1)+3*reg_u(end)) / 4, 100, 100];

    
    y_zad(1:10) = 0;
    y_zad(10:300) = 33.8;
    y_zad(300:500) = 33.8+5;
    y_zad(500:700) = 33.8+15;
    y_zad(700:1000) = 33.8;
    Y_zad = y_zad;
    
    u = zeros(k, 1);
    y = zeros(k, 1);
    U = zeros(k, 1);
    Y = ones(k, 1) * Ypp;
    
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
        
        % Wątpliwe!!!:
        s = load(sprintf("sModels/s_%d", reg_u(index))).s;
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

    while(1)
        % obtaining measurements
        Y(k) = readMeasurements(1); % read measurements from 1 to 1
        % processing of the measurements and new control values calculation
        
        % Wyznaczanie sterowania DMC
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
                if k-p > 0
                    dUP(p)=dUP(p) + u(k-p);
                end
                if k-p-1 > 0
                    dUP(p) = dUP(p) - u(k-p-1);
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
        u(k) = du/total_mi + u(k-1);
        U(k) = (u(k));

        if U(k) > U_max
            U(k) = U_max;
        end

        if U(k) < U_min
            U(k) = U_min;
        end
        
        save("fuzzy_dmc.mat");

        %% Możliwe, że trzeba wziąć pod uwagę Upp!@!!

        % sending new values of control signals
        sendNonlinearControls(U(k))
      
        % synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
        addpoints(h, k, Y(k));
        addpoints(h_u, k, U(k));
        addpoints(h_y_zad, k, Y_zad(k));
        legend("y", "u", "y_z_a_d");
        grid on;
        grid minor;
        drawnow
        k = k+1;
    end
end