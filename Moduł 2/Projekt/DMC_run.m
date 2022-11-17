D = 230;
Dz = 110;
% N=70;
% Nu=5;
% lambda=1;

N=229;
Nu=2;
lambda=0.01;

Ypp = 0;
n=  500;
Y_zad(1:8) = Ypp;
Y_zad(9:n) = 1;

option = 2; % 1 - with error prediction, 2- without error predicition

if option == 1
    [U, Y, E] = DMC_with_error_prediction(D, Dz, N, Nu, lambda);
elseif option == 2
    [U, Y, E] = DMC_without_error_prediction(D, N, Nu, lambda);
end


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
