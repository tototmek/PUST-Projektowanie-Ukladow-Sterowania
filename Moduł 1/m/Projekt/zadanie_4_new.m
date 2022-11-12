clear all;
init;

% Wybór regulatora (1-DMC, 2-PID)
regulator = 1;

% Parametry DMC
D = 195;
N = 17;
Nu = 17;
lambda = 0.01;

% Nastawy PID i wyliczenie parametrów PID
K=3.000000; Ti=15.000000; Td=0.000000;

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