close all;

D=100;
N=29;
Nu=2;
lambda=0.01;

n=1000;

Y_zad(1:49) = 0;
Y_zad(50:249) = 1;
Y_zad(250:599) = 2.5;
Y_zad(600:799) = 0.5;
Y_zad(800:n) = 1.5;
% Y_zad(50:n) = 1;

option = 1; % 1 - normalny, 2 - rozmyty

if option == 1
    [U, Y, E] = DMC_normal(D, N, Nu, lambda);
elseif option == 2
    % TODO
end

disp(E);

subplot(2,1,1);
stairs(Y);
hold on;
stairs(Y_zad,':');
ylabel('$y$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');
legend({'$y$', '$y^{zad}$'}, 'Interpreter','latex')

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))


subplot(2,1,2);
stairs(U, "r");
ylabel('$u$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');
legend({'$u$'}, 'Interpreter','latex')

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

set(groot,'defaultAxesTickLabelInterpreter','latex'); 
set(gcf,'units','points','position',[100 100 450 400]);
% print('plots/zadanie_2/zad_2_odpowiedzi_skokowe','-depsc','-r400'); 
