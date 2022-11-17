clear all;
init;

% Wybór regulatora (1-DMC, 2-PID)
regulator = 2;

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

subplot(2,1,1);
stairs(U, 'k', 'LineWidth', 1.5);
xlabel('$k$', 'Interpreter','latex');
ylabel('$u$', 'Interpreter','latex');
legend('$u$', 'Interpreter','latex');

% set(groot,'defaultAxesTickLabelInterpreter','latex');  
% set(gcf,'units','points','position',[100 100 450 300]);
% print('plots/zadanie_5/zad_5_u','-depsc','-r400');  % Zapisywanie wykresu

subplot(2,1,2);
stairs(Y, 'LineWidth', 1.5);
hold on; 
stairs(Y_zad,':', 'LineWidth', 1.5);
xlabel('$k$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
legend('$y$', '$y^{\mathrm{zad}}$', 'Interpreter','latex');

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 300]);
print('plots/zadanie_5/zad_5_pid','-depsc','-r400');  % Zapisywanie wykresu