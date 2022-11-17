function PID()
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM5 % initialise com port
    step_response=[];
    h = animatedline("Color", "r");
    h_u = animatedline("Color", "b");
    h_y_zad = animatedline("Color", "g");
    k = 3;

    U_min=0;
    U_max=100;
    dU_max=20;
    Tp=1.0;
    
    K = 11;
    Ti = 40;
    Td = 0.5;

    y_zad(1:300) = 40;
    y_zad(300:600) = 35;
    y_zad(600:1000) = 45;
    
    r0 = K * (1 + (Tp/(2*Ti)) + (Td/Tp));
    r1 = K * ((Tp/(2*Ti)) - 2 * (Td/Tp) - 1);
    r2 = K * Td / Tp;
    
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
        du = r0 * e(k) + r1 * e(k-1) + r2 * e(k-2);


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
        save("PID_test_K11_Ti40_Td0-5");

        %% Możliwe, że trzeba wziąć pod uwagę Upp!@!!

        % sending new values of control signals
        sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                     [ 50, 0, 0, 0, u(k), 0]);  % new corresponding control valuesdisp(measurements); % process measurements
        
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