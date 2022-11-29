close all;

K=0.27;
Ti=5;
Td=0.1;

n=1000;

Y_zad(1:49) = 0;
Y_zad(50:249) = 1;
Y_zad(250:599) = 2.5;
Y_zad(600:799) = 0.5;
Y_zad(800:n) = 1.5;
% Y_zad(50:n) = 1;


[U, Y, E] = PID_normal(K, Ti, Td);

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
