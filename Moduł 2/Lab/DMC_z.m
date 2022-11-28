function DMC_z()
    clear all
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM4 % initialise com port
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
    Ypp = 33.43;
    Zpp=0;
    
    % Wyznaczenie modelu odpowiedzi skokowej s
    % [s sz] = step_resonse_scaling(); % Stare, wykorzystuje bezpośrednie
    % pomiary, prawdopodobnie lepsza jest aproksymacja:
    data = load("step_responses_DMC.mat");
    s = data.s;
    sz = data.sz;



    D=500;
    Dz=500;
    N=300;
    Nu=100;
    lambda=0.1;
    
    Y_zad(1:200) =  33.43;
    Y_zad(200:400) = 45;
    Y_zad(400:700) = 35;
    Y_zad(700:1000) = 40;
    y_zad = zeros(950, 1);
    u = ones(k, 1) * Upp;
    y = ones(k, 1) * Ypp;
    U = ones(k, 1) * Upp;
    Y = ones(k, 1) * Ypp;
    
    Z = zeros(n); % - Z można zmieniać
%     T_z = 100;
%     
%     Z(1:T_z) = 0;
%     
% %     Z(T_z+1:n) = 1;
%     Z(T_z+1:n)=5*sin(linspace(0,1,n-T_z));
%     
%     noise = wgn(1,n,-10);
%     Z = Z + noise;
    
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
    
    MZP = zeros(N, Dz);
    for i=1:N
       for j=1:Dz-1
          MZP(i,j)=s_z(i+j)-s_z(j);
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
        y_zad(k) = Y_zad(k);
        y(k) = Y(k);
        
        Y_zad_dmc = Y_zad(k)*ones(N,1);
        Y0 = Y(k)*ones(N,1)+MP*dUP+MZP*dZ;
        dU = K*(Y_zad_dmc-Y0);
        
        U(k) = dU(1) + U(k-1);
        
        if U(k) > 100
            U(k) = 100;
        end
        
        dz=Z(k)-Z(k-1);
        
        for i=Dz:-1:2
           dZ(i)=dZ(i-1);
        end
        dZ(1) = dz;
        
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