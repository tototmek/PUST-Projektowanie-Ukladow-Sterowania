clear all;
init;

% Wybór regulatora (1-DMC, 2-PID)
regulator = 2;

% Parametry DMC
D = 195;
N = 100;
Nu = 4;
lambda = 5;

% Nastawy PID i wyliczenie parametrów PID
K = 0.9;
Ti = 10;
Td = 0.6;

% K = 6.019547;
% Ti = 5.903171;
% Td = 4.541852;


if regulator == 1
    [U, Y, E] = DMC_function(D, N, Nu, lambda);
else
    [U, Y, E] = PID_function(K, Ti, Td);
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