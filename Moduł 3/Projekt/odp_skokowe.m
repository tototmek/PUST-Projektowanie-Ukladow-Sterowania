%% Zadanie 1 - Sprawdzenie poprawności podanego punku pracy

clear all;
close all;

n=200;

Upp=0;
Ypp=0;

u(1:n)=Upp;
y(1:n)=Ypp;


for k=7:n
    y(k)=symulacja_obiektu5y_p3(u(k-5),u(k-6),y(k-1),y(k-2));
end

subplot(2,1,1);
stairs(u, "r");
ylabel('$u$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');
hold on;

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))


subplot(2,1,2);
stairs(y, "b");
ylabel('$y$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');
hold on;

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))


set(groot,'defaultAxesTickLabelInterpreter','latex'); 
set(gcf,'units','points','position',[100 100 450 300]);
% print('plots/zadanie_1/zad_1_punkt_pracy','-depsc','-r400');  % Zapisywanie wykresu

%% Zadanie 2 - Wyznaczenie odpowiedzi skokowych

clear all;
close all;

n = 200;

Upp=0;
Ypp=0;

y(1:n)=Ypp;
u(1:9)=Upp;


for i=-3:2
    u(10:n)=i*0.25;

    for k=7:n
        y(k)=symulacja_obiektu5y_p3(u(k-5),u(k-6),y(k-1),y(k-2));
    end

    subplot(2,1,1);
    stairs(u);
    ylabel('$u$', 'Interpreter','latex');
    xlabel('$k$', 'Interpreter','latex');
    ylim([-1, 0.75])
    hold on;

    subplot(2,1,2);
    stairs(y);
    ylabel('$y$', 'Interpreter','latex');
    xlabel('$k$', 'Interpreter','latex');
    ylim([-0.3, 1.3])
    hold on;

end

subplot(2,1,1);
legend({'$u = -0,75$','$u = -0,5$','$u = -0,25$','$u = 0$','$u = 0,25$', '$u = 0,5$'}, 'Interpreter','latex')
    
yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))


subplot(2,1,2);
legend({'$u = -0,75$','$u = -0,5$','$u = -0,25$','$u = 0$','$u = 0,25$', '$u = 0,5$'}, 'Interpreter','latex')

    
yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))


set(groot,'defaultAxesTickLabelInterpreter','latex'); 
set(gcf,'units','points','position',[100 100 450 300]);
% print('plots/zadanie_2/zad_2_odpowiedzi_skokowe','-depsc','-r400');  % Zapisywanie wykresu



%% Zadanie 2 - Wyznaczanie charakterystyk statycznych

clear all;
close all;

n = 100;

Upp=0;
Ypp=0;

u(1:n)=Upp;
y(1:n)=Ypp;

u_stat(1:n)=0;
y_stat(1:n)=0;


for i=1:n
    u(7:n)=i*0.01;
    
    for k=7:n
        y(k)=symulacja_obiektu5y_p3(u(k-5),u(k-6),y(k-1),y(k-2));
    end
    
    u_stat(i)=u(n);
    y_stat(i)=y(n);
end

% K_stat_u = (y_stat(n) - y_stat(1))/(u_stat(n) - u_stat(1))

plot(u_stat,y_stat);
xlabel('$u$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');

xl = get(gca,'XTickLabel');
set(gca, 'XTickLabel', strrep(xl(:),'.',','))

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

set(groot,'defaultAxesTickLabelInterpreter','latex'); 
set(gcf,'units','points','position',[100 100 450 300]);
% print('plots/zadanie_2/zad_2_chka_stat','-depsc','-r400');  % Zapisywanie wykresu
