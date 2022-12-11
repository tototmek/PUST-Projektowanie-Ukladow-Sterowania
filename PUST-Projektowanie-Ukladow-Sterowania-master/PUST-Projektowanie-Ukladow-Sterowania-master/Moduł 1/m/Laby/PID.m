function PID()
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
    step_response=[];
    h = animatedline("Marker", "o");
    k = 0;

    U_min=0;
    U_max=100;
    dU_max=20;
    Tp=1.0;
    
    K = 1;
    Ti = 100;
    Td = 0;

    y_zad = 36;
    
    r0 = K * (1 + (Tp/(2*Ti)) + (Td/Tp));
    r1 = K * ((Tp/(2*Ti)) - 2 * (Td/Tp) - 1);
    r2 = K * Td / Tp;
    
    e = zeros(3, 1);
    u = zeros(3, 1);

    while(1)
        k = k+1;
        % obtaining measurements
        y = readMeasurements(1); % read measurements from 1 to 1
        % processing of the measurements and new control values calculation
        disp(measurements);
        
        % Prawo regulacji PID
        e(k+2) = y_zad - y;
        du = r0 * e(k+2) + r1 * e(k+1) + r2 * e(k);


        if du > dU_max
            du = dU_max;
        end

        if du < -dU_max
            du = -dU_max;
        end

        u(k+1) = du(1) + u(k);

        if u(k+1) > U_max
            u(k+1) = U_max;
        end

        if u(k+1) < U_min
            u(k+1) = U_min;
        end

        %% Możliwe, że trzeba wziąć pod uwagę Upp!@!!

        % sending new values of control signals
        sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                     [ 50, 0, 0, 0, u(k+1), 0]);  % new corresponding control valuesdisp(measurements); % process measurements
        
        % synchronising with the control process
        waitForNewIteration(); % wait for new batch of measurements to be ready
        addpoints(h, k, step_response(k));
        drawnow
    end
end