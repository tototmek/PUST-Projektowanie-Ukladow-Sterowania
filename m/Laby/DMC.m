function DMC()
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
    step_response=[];
    h = animatedline("Marker", "o");
    k = 10; %% Może powinno być mniej

    U_min=0;
    U_max=100;
    dU_max=20;
    Tp=1.0;
    
    % Wyznaczenie modelu odpowiedzi skokowej s
    step_response_scaling;

    D=350;
    N=40;
    Nu=6;
    lambda=0.1;

    y_zad = 36;
    
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

    u(1:k) = 0;

    while(1)
        k = k+1;
        % obtaining measurements
        y = readMeasurements(1); % read measurements from 1 to 1
        % processing of the measurements and new control values calculation
        disp(measurements);
        
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
        
        y_zad_dmc = y_zad*ones(N,1);
        Y = y*ones(N,1);
        y0 = Y+MP*dUP;
        du = K*(y_zad_dmc-y0);

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