clear all;
set(groot,'defaultAxesTickLabelInterpreter','latex');  
init;

% Wybór regulatora (1-DMC, 2-PID)
regulator = 1;

% Parametry DMC
% D = 195;
% N = 21;
% Nu = 7;
% lambda = 0.1;

D = 216;
N = 21;
Nu = 7;
lambda = 0.01;

% Nastawy PID i wyliczenie parametrów PID
% K=5; Ti=7; Td=4;

K = 6.019519547;
Ti = 5.903171;
Td = 4.541852;


if regulator == 1
    [U, Y, E] = DMC_function(D, N, Nu, lambda);
else
    [U, Y, E] = PID_function(K, Ti, Td);
end

disp(E);

subplot(2,1,1);
stairs(Y, 'LineWidth', 1.1);
hold on; 
stairs(Y_zad,':', 'LineWidth', 1.1);
xlabel('$k$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
legend('$y$', '$y^{\mathrm{zad}}$', 'Interpreter','latex');
title(strrep(sprintf("$E=%f$", E),'.',','), 'Interpreter','latex')
yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))
xl = get(gca,'XTickLabel');
set(gca, 'XTickLabel', strrep(xl(:),'.',','))
hold on; 

subplot(2,1,2);
stairs(U, 'k', 'LineWidth', 1.1);
xlabel('$k$', 'Interpreter','latex');
ylabel('$u$', 'Interpreter','latex');
legend('$u$', 'Interpreter','latex');
yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))
xl = get(gca,'XTickLabel');
set(gca, 'XTickLabel', strrep(xl(:),'.',','))


set(gcf,'units','points','position',[100 100 450 300]);
print('plots/zadanie_5/zad_6_dmc','-depsc','-r400');  % Zapisywanie wykresu