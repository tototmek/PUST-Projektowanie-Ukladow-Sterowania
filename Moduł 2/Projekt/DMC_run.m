D = 230;
Dz = 110;
% N=70;
% Nu=5;
% lambda=1;

N=229;
Nu=2;
lambda=0.01;

Y_zad(1:8) = Ypp;
Y_zad(9:n) = 1;
    
[U, Y, E] = DMC(D, Dz, N, Nu, lambda);

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
