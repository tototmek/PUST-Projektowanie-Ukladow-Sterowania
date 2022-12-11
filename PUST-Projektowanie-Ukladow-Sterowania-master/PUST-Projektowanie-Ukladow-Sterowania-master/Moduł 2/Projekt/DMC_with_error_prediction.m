function [U, Y, E] = DMC_with_error_prediction(D, Dz, N, Nu, lambda)
    n = 300;
    
    Upp=0;
    Ypp=0;
    Zpp=0;

    % Inicjacja potrzebnych wektorów

    U(1:8) = Upp;
    Y(1:8) = Ypp;
    Y_zad(1:8) = Ypp;
    Y_zad(9:n) = 1;
    
    Z = zeros(n); 
    
%     T_z = 100;
%     Z(1:T_z) = 0;
% 
%     Z(T_z+1:n) = 0;
%     Z(T_z+1:n) = 1;
%     Z(T_z+1:n)=5*sin(linspace(0,1,n-T_z));
%     
%     noise = wgn(1,n,-10);
%     Z = Z + noise;

    
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
        
        dz=Z(k)-Z(k-1);
        
        for i=Dz:-1:2
           dZ(i)=dZ(i-1);
        end
        
        dZ(1) = dz;
    end

    % Obliczenie wartości wskaźnika jakości regulacji
    E = sum((Y_zad - Y).^2);
end

