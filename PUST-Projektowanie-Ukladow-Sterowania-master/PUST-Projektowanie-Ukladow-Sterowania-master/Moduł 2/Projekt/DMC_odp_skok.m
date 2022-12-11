close all;

offset = 8;
n=200 + offset;

Upp=0;
Ypp=0;
Zpp=0;

u_step=1;
z_step=1;

u(1:n)=Upp;
y(1:n)=Ypp;
z(1:n)=Zpp;

option=1; % 1 - tor wejście - wyjście (s), 2 - tor zakłócenie - wyjście (s_z)

if option == 1

    u(8:n)=u_step;

    for k=8:n
        y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z(k-3),z(k-4),y(k-1),y(k-2));
    end
    
    for k=9:n
        s(k-8)=(y(k)-Ypp)/(u_step - Upp);
    end

    stairs(s);
    xlabel('$k$', 'Interpreter','latex');
    ylabel('$s$', 'Interpreter','latex');

    yl = get(gca,'YTickLabel');
    set(gca, 'YTickLabel', strrep(yl(:),'.',','))

    set(groot,'defaultAxesTickLabelInterpreter','latex');  
    set(gcf,'units','points','position',[100 100 450 300]);
    print('plots/zadanie_3/zad_3_odp_wej_wyj','-depsc','-r400');  % Zapisywanie wykresu

elseif option == 2

    z(8:n)=z_step;

    for k=8:n
        y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z(k-3),z(k-4),y(k-1),y(k-2));
    end
    
    for k=9:n
        s_z(k-8)=(y(k)-Ypp)/(z_step - Zpp);
    end

    stairs(s_z);
    xlabel('$k$', 'Interpreter','latex');
    ylabel('$s^{z}$', 'Interpreter','latex');

    yl = get(gca,'YTickLabel');
    set(gca, 'YTickLabel', strrep(yl(:),'.',','))

    set(groot,'defaultAxesTickLabelInterpreter','latex');  
    set(gcf,'units','points','position',[100 100 450 300]);
    print('plots/zadanie_3/zad_3_odp_zak_wyj','-depsc','-r400');  % Zapisywanie wykresu

end