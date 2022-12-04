clear all;

%Punkty pracy
Upp=0;
Ypp=0;

%Ograniczenia
u_max=1;
u_min=-1;

%Ilość regulatorów lokalnych
regulator=5;

if regulator==1
    u_rozmyte=[-1 -0.9 0.9 1];
    K=0.928371881023764; Ti=1.920104721975397; Td=1.848686338168752;
elseif regulator==2
    u_rozmyte = [-1 -0.9 -0.4 0; -0.4 0 0.9 1];
    K=[0.212231534118323 2.432203063082650];
    Ti=[3.934756512569220 1.683599423360945];
    Td=[1.094639350304888 1.060456552008631];
elseif regulator==3
    u_rozmyte=[-1 -0.9 -0.5 -0.3; -0.5 -0.3 -0.1 0.1; -0.1 0.1 0.9 1];
    K=[0.186679337104905 0.465491313978983 4.996519259673254];
    Ti=[3.715298149849268 1.893450806252958 1.979524080957053];
    Td=[1.129713480486809 1.640877794736797 0.748640683334764];
elseif regulator==4
    u_rozmyte=[-1 -0.9 -0.5 -0.4; -0.5 -0.4 -0.3 -0.2; -0.3 -0.2 0 0.2; 0 0.2 0.9 1];
    K=[0.186679337104905 0.304615343370432 0.692588254022739 9.015656116625067];
    Ti=[3.715298149849268 2.068513949107859 1.750765497764514 2.309244465304164];
    Td=[1.129713480486809 1.867101975042399 1.489920106298647 0.430228365361890];
elseif regulator==5
    u_rozmyte=[-1 -0.9 -0.5 -0.4; -0.5 -0.4 -0.3 -0.2; -0.3 -0.2 -0.1 0; -0.1 0 0.1 0.2; 0.1 0.2 0.9 1];
    K=[0.186679337104905 0.304615343370432 0.589996831455160 1.753508900128951 9.015656116625067];
    Ti=[3.715298149849268 2.068513949107859 1.815619723671430 1.694646262355083 2.309244465304164];
    Td=[1.129713480486809 1.867101975042399 1.604128297190527 1.362996558383740 0.430228365361890];
end

Ts(1:regulator)=0.5;

%Parametry regulatorów
r2=K.*Td./Ts;
r1=K.*(Ts./(2.*Ti)-2.*Td./Ts - 1);
r0=K.*(1+Ts./(2.*Ti) + Td./Ts);

for i=1:regulator
    y_rozmyte(i,:)=[wartosc_y(u_rozmyte(i,1)) wartosc_y(u_rozmyte(i,2)) wartosc_y(u_rozmyte(i,3)) wartosc_y(u_rozmyte(i,4))]; %przypisanie konkretnych granic Y
end
%Pierwszy przedział zaczyna się w -inf, ostatni się kończy w +inf
y_rozmyte(1,1:2)=-inf;
y_rozmyte(regulator,3:4)=inf;

n=1400; %Okres symulacji
U(1:n)=Upp;
Y(1:n)=Ypp;
Y_zad(1:10)=Ypp;
Y_zad(11:250)=-1;
Y_zad(251:500)=-3;
Y_zad(501:750)=-2;
Y_zad(751:1000)=0;
Y_zad(1001:1400)=-2.5;
u=U-Upp;
y_zad=Y_zad-Ypp;
y(1:n)=0;
e(1:n)=0;
mi(1,regulator)=0; 


for k=7:n
    Y(k)=symulacja_obiektu11y(U(k-5),U(k-6),Y(k-1),Y(k-2));
    y(k)=Y(k)-Ypp;
    e(k)=y_zad(k)-y(k); %Uchyb
    
    %Poziom przynależności aktualnego Y do poszczegónych przedziałów
    %rozmytych
    for i=1:size(u_rozmyte,1)
        mi(i)=trapmf(y(k),y_rozmyte(i,:)); 
    end
    
    %Suma ważona
    du=sum(mi.*(r2*e(k-2)+r1*e(k-1)+r0*e(k)));
       
    u(k)=u(k-1)+du;
    
    if u(k)>u_max
        u(k)=u_max;
    end
    if u(k)<u_min
        u(k)=u_min;
    end
    
    U(k)=u(k)+Upp;
end
 
E=(norm(e))^2; %Wskaźnik jakości regulacji

subplot(2,1,1);
stairs(U);
title('u(k)');
xlabel('k');
ylabel('u');
subplot(2,1,2);
stairs(Y);
title('Y(k) i Y_z_a_d');
hold on;
stairs(Y_zad);
xlabel('k');
legend('y','y_z_a_d','Location','southeast');