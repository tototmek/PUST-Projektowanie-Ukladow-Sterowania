function PID_fuzzy()
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM4 % initialise com port
    h = animatedline("Color", "r");
    h_u = animatedline("Color", "b");
    h_y_zad = animatedline("Color", "g");
    k = 3;

    U_min=0;
    U_max=100;
    dU_max=20;
    Tp=1.0;
    reg_u = [20, 50, 80]';
    reg_y = zeros(size(reg_u));
    n_regs = size(reg_u, 1);

    % Parametry regulatorów lokalnych
    reg_params = [0.7 3 0.1;
                  0.19 4 0.2;
                  0.18 10 0.2];

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
    
    e = zeros(3, 1);
    u = ones(3, 1) * 25;
    y = ones(3, 1) * 33;
    while(1)
        % obtaining measurements
        y(k) = readMeasurements(1); % read measurements from 1 to 1
        % processing of the measurements and new control values calculation
        disp(y(k));
        
        % Prawo regulacji PID
        e(k) = y_zad(k) - y(k);
        du = 0;
        total_mi = 0;
        for i = 1:n_regs
            mi = trapmf(U(k-1), membership_functions(i, :));
            du = du + mi * (r0(i) * e(k) + r1(i) * e(k-1) + r2(i) * e(k-2));
            total_mi = total_mi + mi;
        end
        u(k) = du/total_mi + u(k-1);


        if du > dU_max
            du = dU_max;
        end

        if du < -dU_max
            du = -dU_max;
        end

        u(k) = du(1) + u(k-1);

        if u(k) > U_max
            u(k) = U_max;
        end

        if u(k) < U_min
            u(k) = U_min;
        end
        save("fuzzy_pid.mat");

        %% Możliwe, że trzeba wziąć pod uwagę Upp!@!!

        % sending new values of control signals
        sendNonlinearControls(u(k));  % new corresponding control valuesdisp(measurements); % process measurements
        
        % synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
        addpoints(h, k, y(k));
        addpoints(h_u, k, u(k));
        addpoints(h_y_zad, k, y_zad(k));
        legend("y", "u", "y_z_a_d");
        grid on;
        grid minor;
        drawnow
        k = k+1;
    end
end