
function DMC()
    clear all
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM5 % initialise com port
    step_response=[];
    h = animatedline("Color", "r");
    h_u = animatedline("Color", "b");
    h_y_zad = animatedline("Color", "g");
    k = 10; %% Może powinno być mniej

    U_min=0;
    U_max=100;
    dU_max=20;
    Tp=1.0;
    
    Upp = 25;
    Ypp = 34.12;
    
    % Wyznaczenie modelu odpowiedzi skokowej s
    step_response_scaling;

    D=500;
    N=300;
    Nu=100;
    lambda=0.1;
    
    Y_zad(1:300) = 40;
    Y_zad(300:600) = 35;
    Y_zad(600:1000) = 45;
    y_zad = zeros(1000, 1);
    u = zeros(k, 1);
    y = zeros(k, 1);
    U = ones(k, 1) * Upp;
    Y = ones(k, 1) * Ypp;
    
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

    while(1)
        % obtaining measurements
        Y(k) = readMeasurements(1); % read measurements from 1 to 1
        % processing of the measurements and new control values calculation
        
        % Wyznaczanie sterowania DMC
        for p=1:D-1
            dUP(p) = 0;
            if k-p >0
                dUP(p)=dUP(p) + u(k-p);
            end
            if k-p-1 > 0
                dUP(p) = dUP(p) - u(k-p-1);
            end
        end
        y_zad(k) = (Y_zad(k));
        y(k) = (Y(k));
        
        y_zad_dmc = (y_zad(k))*ones(N,1);
        Y_ = (y(k))*ones(N,1);
        y0 = Y_+MP*dUP;
        du = K*(y_zad_dmc-y0);

        if du > dU_max
            du = dU_max;
        end

        if du < -dU_max
            du = -dU_max;
        end

        u(k) = du(1) + u(k-1);
        U(k) = (u(k));

        if U(k) > U_max
            U(k) = U_max;
        end

        if U(k) < U_min
            U(k) = U_min;
        end
        
        save("DMC_test_chybaspoko_D290_N66_Nu33_L1");

        %% Możliwe, że trzeba wziąć pod uwagę Upp!@!!

        % sending new values of control signals
        sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                     [ 50, 0, 0, 0, U(k), 0]);  % new corresponding control valuesdisp(measurements); % process measurements
        
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