close all;

n=200;

Upp=0;
Ypp=0;
Zpp=0;

u_step=1;
z_step=1;

u(1:n)=Upp;
y(1:n)=Ypp;
z(1:n)=Zpp;

option=2; % 1 - tor wejście - wyjście (s), 2 - tor zakłócenie - wyjście (s_z)

if option == 1

    u(8:n)=u_step;

    for k=8:n
        y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z(k-3),z(k-4),y(k-1),y(k-2));
    end
    
    for k=9:n
        s(k-8)=(y(k)-Ypp)/(u_step - Upp);
    end

    stairs(s);
    xlabel('k');
    ylabel('s');
    title("Odpowiedź skokowa toru wejście - wyjście (s)")

elseif option == 2

    z(8:n)=z_step;

    for k=8:n
        y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z(k-3),z(k-4),y(k-1),y(k-2));
    end
    
    for k=9:n
        s_z(k-8)=(y(k)-Ypp)/(z_step - Zpp);
    end

    stairs(s_z);
    xlabel('k');
    ylabel('s^{z}');
    title("Odpowiedź skokowa toru zakłócenie - wyjście (s^{z})")

end