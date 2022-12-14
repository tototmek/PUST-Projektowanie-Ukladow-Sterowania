%% Zadanie 1

clear all;
close all;

n=200;

Upp=0;
Ypp=0;
Zpp=0;

u(1:n)=Upp;
y(1:n)=Ypp;
z(1:n)=Zpp;


% Sprawdzenie poprawności podanego punku pracy

for k=8:n
    y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z(k-3),z(k-4),y(k-1),y(k-2));
end

subplot(3,1,1);
stairs(u, "r");
ylabel('$u$', 'Interpreter','latex');
ylim([-1, 1])
hold on;

% yl = get(gca,'YTickLabel');
% set(gca, 'YTickLabel', strrep(yl(:),'.',','))


subplot(3,1,2);
stairs(z, "g");
ylabel('$z$', 'Interpreter','latex');
ylim([-1, 1])
hold on;

% yl = get(gca,'YTickLabel');
% set(gca, 'YTickLabel', strrep(yl(:),'.',','))


subplot(3,1,3);
stairs(y, "b");
ylabel('$y$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');
ylim([-1, 1])
hold on;

% yl = get(gca,'YTickLabel');
% set(gca, 'YTickLabel', strrep(yl(:),'.',','))


set(groot,'defaultAxesTickLabelInterpreter','latex'); 
set(gcf,'units','points','position',[100 100 450 450]);
% print('plots/zadanie_1/zad_1_punkt_pracy','-depsc','-r400');  % Zapisywanie wykresu

%% Zadanie 2 - Wyznaczenie odpowiedzi skokowych różnych torów

tor = 1; % 1 - tor wejście-wyjście, 2 - zakłócenie-wyjście

n = 200;

u(1:n)=Upp;
y(1:n)=Ypp;
z(1:n)=Zpp;

if tor == 1
    for i=-2:2
        u_tor=u;
        u_tor(8:n)=i;
    
        for k=8:n
            y(k)=symulacja_obiektu5y_p2(u_tor(k-6),u_tor(k-7),z(k-3),z(k-4),y(k-1),y(k-2));
        end
       
        subplot(3,1,1);
        stairs(u_tor);
        ylabel('$u$', 'Interpreter','latex');
        xlabel('$k$', 'Interpreter','latex');
        ylim([-3, 3])
%         yl = get(gca,'YTickLabel');
%         set(gca, 'YTickLabel', strrep(yl(:),'.',','))
        hold on;
        
        subplot(3,1,2);
        stairs(z);
        ylabel('$z$', 'Interpreter','latex');
        xlabel('$k$', 'Interpreter','latex');
        ylim([-3, 3])
%         yl = get(gca,'YTickLabel');
%         set(gca, 'YTickLabel', strrep(yl(:),'.',','))
        hold on;
    
        subplot(3,1,3);
        stairs(y);
        ylabel('$y$', 'Interpreter','latex');
        xlabel('$k$', 'Interpreter','latex');
        ylim([-4.5, 4.5])
%         yl = get(gca,'YTickLabel');
%         set(gca, 'YTickLabel', strrep(yl(:),'.',','))
        hold on;
    
    end
    subplot(3,1,1);
    legend({'$u = -2$','$u = -1$','$u = 0$','$u = 1$','$u = 2$'}, 'Interpreter','latex')

    subplot(3,1,3);
    legend({'$u = -2$','$u = -1$','$u = 0$','$u = 1$','$u = 2$'}, 'Interpreter','latex')

    set(groot,'defaultAxesTickLabelInterpreter','latex'); 
    set(gcf,'units','points','position',[100 100 450 450]);
%     print('plots/zadanie_2/zad_2_wej_wyj','-depsc','-r400');  % Zapisywanie wykresu

elseif tor == 2
    for i=-2:2
        z_tor=z;
        z_tor(8:n)=i;
    
        for k=8:n
            y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z_tor(k-3),z_tor(k-4),y(k-1),y(k-2));
        end
       
        subplot(3,1,1);
        stairs(u);
        ylabel('$u$', 'Interpreter','latex');
        xlabel('$k$', 'Interpreter','latex');
        ylim([-3, 3])
%         yl = get(gca,'YTickLabel');
%         set(gca, 'YTickLabel', strrep(yl(:),'.',','))
        hold on;
        
        subplot(3,1,2);
        stairs(z_tor);
        ylim([-3, 3])
        ylabel('$z$', 'Interpreter','latex');
        xlabel('$k$', 'Interpreter','latex');
%         yl = get(gca,'YTickLabel');
%         set(gca, 'YTickLabel', strrep(yl(:),'.',','))
        hold on;
    
        subplot(3,1,3);
        stairs(y);
        ylabel('$y$', 'Interpreter','latex');
        xlabel('$k$', 'Interpreter','latex');
        ylim([-2, 2])
%         yl = get(gca,'YTickLabel');
%         set(gca, 'YTickLabel', strrep(yl(:),'.',','))
        hold on;

    end

    subplot(3,1,2);
    legend({'$z = -2$','$z = -1$','$z = 0$','$z = 1$','$z = 2$'}, 'Interpreter','latex')

    subplot(3,1,3);
    legend({'$z = -2$','$z = -1$','$z = 0$','$z = 1$','$z = 2$'}, 'Interpreter','latex')

    set(groot,'defaultAxesTickLabelInterpreter','latex'); 
    set(gcf,'units','points','position',[100 100 450 450]);
%     print('plots/zadanie_2/zad_2_zak_wyj','-depsc','-r400');  % Zapisywanie wykresu

end


%% Zadanie 2 - Wyznaczanie charakterystyk statycznych

option = 3; % 1 - y(u), 2 - y(z), 3 - y(u, z)

n = 100;

u(1:n)=Upp;
y(1:n)=Ypp;
z(1:n)=Zpp;

u_stat(1:n)=0;
z_stat(1:n)=0;
y_stat(1:n)=0;


if option == 1

    for i=1:n
        u(8:n)=i*0.01;
    
        for k=8:n
            y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z(k-3),z(k-4),y(k-1),y(k-2));
        end
    
        u_stat(i)=u(n);
        y_stat(i)=y(n);
    end
    
    K_stat_u = (y_stat(n) - y_stat(1))/(u_stat(n) - u_stat(1))
    
    plot(u_stat,y_stat);
    xlabel('$u$', 'Interpreter','latex');
    ylabel('$y$', 'Interpreter','latex');

    set(groot,'defaultAxesTickLabelInterpreter','latex'); 
    set(gcf,'units','points','position',[100 100 450 300]);
%     print('plots/zadanie_2/zad_2_chka_yu','-depsc','-r400');  % Zapisywanie wykresu

elseif option == 2 

    for i=1:n
        z(8:n)=i*0.01;
    
        for k=8:n
            y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z(k-3),z(k-4),y(k-1),y(k-2));
        end
    
        z_stat(i)=z(n);
        y_stat(i)=y(n);
    end
    
    K_stat_z = (y_stat(n) - y_stat(1))/(z_stat(n) - z_stat(1))
    
    plot(z_stat,y_stat);
    xlabel('$z$', 'Interpreter','latex');
    ylabel('$y$', 'Interpreter','latex');

    set(groot,'defaultAxesTickLabelInterpreter','latex'); 
    set(gcf,'units','points','position',[100 100 450 300]);
%     print('plots/zadanie_2/zad_2_chka_yz','-depsc','-r400');  % Zapisywanie wykresu

elseif option == 3     

    y_stat(n,n)=0;
    
    for i=1:n
        u(8:n)=i*0.01;
    
        for j=1:n
            z(8:n)=j*0.01;
            y(1:n)=0;
    
            for k=8:n
                y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z(k-3),z(k-4),y(k-1),y(k-2));
            end
    
            z_stat(j)=z(n);
            y_stat(i,j)=y(n);
        end
    
        u_stat(i)=u(n);
    end
    
    surf(u_stat, z_stat, y_stat);
    xlabel('$u$', 'Interpreter','latex');
    ylabel('$z$', 'Interpreter','latex');
    zlabel('$y$', 'Interpreter','latex');

    set(groot,'defaultAxesTickLabelInterpreter','latex'); 
    set(gcf,'units','points','position',[100 100 450 300]);
%     print('plots/zadanie_2/zad_2_chka_yuz','-depsc','-r400');  % Zapisywanie wykresu

end