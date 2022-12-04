function [U, Y, E] = DMC_rozmyty(D, N, Nu, lambda)
    n=1000;
    n_s = 500;

    Ypp = 0;
    Upp = 0;
    
    U_min = -1;
    U_max = 1;
    
    Y_zad(1:49) = 0;
    Y_zad(50:249) = 1;
    Y_zad(250:599) = 2.5;
    Y_zad(600:799) = 0.5;
    Y_zad(800:n) = 1.5;
    
    U(1:6) = Upp;
    Y(1:6) = Ypp;
    
    s = DMC_s_function(n_s);
    
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

    for k=7:n
        Y(k)=symulacja_obiektu5y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2));
        
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
        Y0 = Y(k)*ones(N,1)+MP*dUP;
        dU = K*(Y_zad_dmc-Y0);

        U(k) = dU(1) + U(k-1);

        if U(k) > U_max - Upp
            U(k) = U_max - Upp;
        end

        if U(k) < U_min
            U(k) = U_min;
        end

    end

    % Obliczenie wartości wskaźnika jakości regulacji
    E = sum((Y_zad - Y).^2);
end
