clear all;
zadanie_3;

T = 1000;
Tp = 0.5;

% Parametry DMC
D = 195;
N = 100;
Nu = 4;
lambda = 5;

% Nastawy PID i wyliczenie parametrów PID
K = 0.9;
Ti = 10;
Td = 0.6;
r0 = K * (1 + (Tp/(2*Ti)) + (Td/Tp));
r1 = K * ((Tp/(2*Ti)) - 2 * (Td/Tp) - 1);
r2 = K * Td / Tp;

% Ograniczenia sygnału sterującego
U_max = 2;
U_min = 1;
dU_max = 0.1;

% Obliczenia potrzebnych macierzy dla algorytmu DMC
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

Y_zad(1:60) = Ypp;
Y_zad(60:360) = 2.4;
Y_zad(360:660) = 2.1;
Y_zad(660:T) = 2.3;

y_zad = Y_zad - Ypp;

e(1:12) = 0;

% Wybór regulatora (1-DMC, 2-PID)
algorithm = 2;

for k=12:T
    % symulacja obiektu
    Y(k)=symulacja_obiektu5Y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));
    y(k) = Y(k) - Ypp;
    
    % obliczenia dla DMC
    if algorithm == 1
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
    else
        % Obliczenia dla PID
        e(k) = y_zad(k) - y(k);
        du = r0 * e(k) + r1 * e(k-1) + r2 * e(k-2);
    end

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
disp(E);

figure;
stairs(U, 'k', 'LineWidth', 1.5);
title('Sterowanie');
xlabel('k');
ylabel('u');
legend('u');

figure;
stairs(Y, 'LineWidth', 1.5);
hold on; 
stairs(Y_zad,':', 'LineWidth', 1.5);
title('Wyjście obiektu');
xlabel('k');
ylabel('y');
legend('y', 'yzad');

