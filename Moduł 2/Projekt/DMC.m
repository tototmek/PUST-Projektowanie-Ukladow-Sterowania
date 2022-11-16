%% Zadanie 4(DMC w najrostszej formie)

function [U, Y, E] = DMC(D, Dz, N, Nu, lambda)
%     iterations = 500;
    n = 500;
    
    Upp=0;
    Ypp=0;
    Zpp=0;
    
    s = DMC_s_function(n);
    s_z = DMC_s_z_function(n);
    
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
    dZ = zeros(Dz, 1);
    
    % Inicjacja potrzebnych wektorów
    U(1:8) = Upp;
    Y(1:8) = Ypp;
    Y_zad(1:8) = Ypp;
    Y_zad(9:n) = 1;
    
    Z = zeros(n); % - Z można zmieniać
    Z(1:200) = 0;
    Z(201:n) = 1;
    
    for k=9:n
        % symulacja obiektu
        Y(k)=symulacja_obiektu5y_p2(U(k-6),U(k-7),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
   
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
       
       for i=Dz:-1:2
           dZ(i)=dZ(i-1);
       end
       dZ(1) = 0;
    end

    % Obliczenie wartości wskaźnika jakości regulacji
    E = sum((Y_zad - Y).^2);
end

