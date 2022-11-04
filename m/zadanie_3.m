clear all;

iterations=500;

Upp=1.5;
Ypp=2.2;

U(1:iterations)=Upp;
U(12:iterations)=2;

Y(1:11)=Ypp;
Y(12:iterations)=0;

for k=12:iterations
    Y(k)=symulacja_obiektu5Y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));
end

%Rysowanie wykresu odpowiedzi skokowej
wykres=0;
if wykres==1   
    subplot(2,1,1);
    stairs(U);
    xlabel('k');
    ylabel('U');
    title('Sterowanie')

    subplot(2,1,2);
    stairs(Y);
    xlabel('k');
    ylabel('Y');
    title('Odpowiedz skokowa')
end


%Wyznaczenie zestawu liczb odpowiedzi skokowej dla DMC

for k=13:iterations
    s(k-12)=(Y(k)-Ypp)/0.5;
end

if wykres==2
    stairs(s);
    xlabel('k');
    ylabel('s');
end