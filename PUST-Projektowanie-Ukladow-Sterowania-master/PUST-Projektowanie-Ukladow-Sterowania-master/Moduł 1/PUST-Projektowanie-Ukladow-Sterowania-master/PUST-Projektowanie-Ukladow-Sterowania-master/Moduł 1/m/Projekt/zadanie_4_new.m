clear all;
init;

% Wybór regulatora (1-DMC, 2-PID)
regulator = 1;

% Parametry DMC
D = 195;
N = 21;
Nu = 7;
lambda = 0.1;

% Nastawy PID i wyliczenie parametrów PID
K=5; Ti=7; Td=4;

% K = 6.019519547;
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