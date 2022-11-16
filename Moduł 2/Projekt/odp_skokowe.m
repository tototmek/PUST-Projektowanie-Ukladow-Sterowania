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
stairs(u, "LineWidth", 2);
ylabel('u');
title("Sprawdzenie poprawności podanego punku pracy")

hold on;
subplot(3,1,2);
stairs(z, "LineWidth", 2);
ylabel('z');

hold on;
subplot(3,1,3);
stairs(y, "LineWidth", 2);
ylabel('y');
xlabel('k');



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
        stairs(u_tor, "LineWidth", 1.5);
        ylabel('u');
        ylim([-3, 3])
        title("Odpowiedź skokowa dla toru wejście - wyjście")
        hold on;
        
        subplot(3,1,2);
        stairs(z, "LineWidth", 1.5);
        ylabel('z');
        hold on;
    
        subplot(3,1,3);
        stairs(y, "LineWidth", 1.5);
        ylabel('y');
        xlabel('k');
        hold on;
    end
    legend({'u = -2','u = -1','u = 0','u = 1','u = 2'})

elseif tor == 2
    for i=-2:2
        z_tor=z;
        z_tor(8:n)=i;
    
        for k=8:n
            y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z_tor(k-3),z_tor(k-4),y(k-1),y(k-2));
        end
       
        subplot(3,1,1);
        stairs(u, "LineWidth", 1.5);
        ylabel('u');
        title("Odpowiedź skokowa dla toru zakłócenie - wyjście")
        hold on;
        
        subplot(3,1,2);
        stairs(z_tor, "LineWidth", 1.5);
        ylim([-3, 3])
        ylabel('z');
        hold on;
    
        subplot(3,1,3);
        stairs(y, "LineWidth", 1.5);
        ylabel('y');
        xlabel('k');
        hold on;
    end
    legend({'z = -2','z = -1','z = 0','z = 1','z = 2'})
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
    xlabel('u');
    ylabel('y');
    title('Charakterystyka statyczna y(u)');

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
    xlabel('u');
    ylabel('y');
    title('Charakterystyka statyczna y(z)');

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
    xlabel('u');
    ylabel('z');
    zlabel('y');
    title('Charakterystyka statyczna y(u, z)');
    % title('Charakterystyka statyczna ${y(u, z)}$', 'Interpreter', 'Latex');
end