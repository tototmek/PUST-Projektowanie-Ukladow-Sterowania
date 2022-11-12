function [U, Y, E] = DMC_function(D, N, Nu, lambda)
    % Obliczenia potrzebnych macierzy dla algorytmu DMC
    init;
    
    iterations = 500;
    U_step = 2;
    
    s = DMC_s(iterations, U_step);
    
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

    % Inicjacja potrzebnych wektorów
    U(1:11) = Upp;
    Y(1:11) = Ypp;

    u=U-Upp;
    y=Y-Ypp;
    
    y_zad = Y_zad - Ypp;

    for k=12:T
        % symulacja obiektu
        Y(k)=symulacja_obiektu5Y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));
        y(k) = Y(k) - Ypp;
        
        for p=1:D-1
            dUP(p) = 0;
            if k-p >0
                dUP(p)=dUP(p) + u(k-p);
            end
            if k-p-1 > 0
                dUP(p) = dUP(p) - u(k-p-1);
            end
        end
        
        y_zad_dmc = y_zad(k)*ones(N,1);
        y = y(k)*ones(N,1);
        y0 = y+MP*dUP;
        du = K*(y_zad_dmc-y0);

        if du > dU_max
            du = dU_max;
        end

        if du < -dU_max
            du = -dU_max;
        end

        u(k) = du(1) + u(k-1);

        if u(k) > U_max - Upp
            u(k) = U_max - Upp;
        end

        if u(k) < U_min - Upp
            u(k) = U_min  - Upp;
        end
        U(k) = u(k) + Upp;
    end

    % Obliczenie wartości wskaźnika jakości regulacji
    E = sum((Y_zad - Y).^2);
end
