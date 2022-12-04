function DMC_z()
    addpath('D:\SerialCommunication'); % add a path to the functions
    initSerialControl COM4 % initialise com port
    k = 10;
    
    % Wczytanie odpowiedzi skokowych
    data = load("step_responses_DMC.mat");
    s = data.s;
    sz = data.sz;
    
    % Parametry DMC
    D=500;
    Dz=700;
    N=300;
    Nu=100;
    lambda=0.1;
    
    % Deklaracja oraz definicja odpowiednich sygnałów
    Y_zad(1:200) =  33.43;
    Y_zad(200:400) = 45;
    Y_zad(400:700) = 35;
    Y_zad(700:1000) = 40;
    U = ones(k, 1) * 25;
    Y = ones(k, 1) * 33.43;
    Z(1:300) = 0;
    Z(300:600) = 30;
    Z(600:1000) = 45;
    
    % Obliczenia DMC offline
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
          MZP(i,j)=sz(i+j)-sz(j);
       end
    end

    K = (M'*M + lambda*eye(Nu, Nu))\M';
    dUP = zeros(D-1, 1);
    dZ = zeros(Dz, 1);

    while(1)
        % Pomiar wyjścia obiektu
        Y(k) = readMeasurements(1);
        
        % Obliczenia DMC online
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
        Y0 = Y(k)*ones(N,1)+MP*dUP+MZP*dZ;
        dU = K*(Y_zad_dmc-Y0);
        
        U(k) = dU(1) + U(k-1);
        
        dz=Z(k)-Z(k-1);
        
        for i=Dz:-1:2
           dZ(i)=dZ(i-1);
        end
        dZ(1) = dz;

        % Ograniczenia sterowania
        if U(k) > 100
            U(k) = 100;
        end
        
        if U(k) < 0
            U(k) = 0;
        end
        
        % Wysyłanie sterowania do obiektu
        sendControlsToG1AndDisturbance(U(k), Z(k))
        sendControls([1], ...
                     [50]);
        waitForNewIteration();
        k = k+1;
    end
end