clear all;
close all;

D = 140;
Dz = 80;
N = 10;
Nu = 2;
lambda = 0.001;

n=300;
Ypp=0;
Y_zad(1:8)=Ypp;
Y_zad(9:n)=1;

option = 1; % 1 - with error prediction, 2- without error predicition

if option == 1
    [U, Y, E] = DMC_with_error_prediction(D, Dz, N, Nu, lambda);
elseif option == 2
    [U, Y, E] = DMC_without_error_prediction(D, N, Nu, lambda);
end


disp(E);

subplot(2,1,1);
stairs(Y);
hold on;
stairs(Y_zad,':');
ylim([0, 1.3])
xlabel('$k$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
title(strrep(sprintf("$E=%f$", E),'.',','), 'Interpreter','latex')
legend({'$y$', '$y^{zad}$'}, 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))


subplot(2,1,2);
stairs(U, "r");
xlabel('$k$', 'Interpreter','latex');
ylabel('$u$', 'Interpreter','latex');
legend('$u$', 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))


set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 300]);
% print('plots/zadanie_4/zad_4_wersja_D140_N10_Nu2_L0001','-depsc','-r400');  % Zapisywanie wykresu

