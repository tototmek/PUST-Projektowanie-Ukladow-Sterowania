function DMC()
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
    
    Upp = 25;
    Ypp = 34.12;
    
    % Wyznaczenie modelu odpowiedzi skokowej s
    step_response_scaling;

    D=500;
    N=300;
    Nu=100;
    lambda=0.1;
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
        
        save("dmc.mat");

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