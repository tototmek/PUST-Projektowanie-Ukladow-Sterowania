clear all;
iterations=200;

Upp=1.5;
Ypp=2.2;
figure
U(1:14) = Upp;
Y(1:iterations) = Ypp;
%Wyznaczenie różnych odpowiedzi skokowych
for i=1:1:5
    u_d=i*0.1;
    U(15:iterations)=1.3+u_d;
    for k = 12:iterations
        Y(k) = symulacja_obiektu5Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
    end

    subplot(2,1,1);
    stairs(U);
    xlabel('k');
    ylabel('U');
    hold on;
    subplot(2,1,2);
    stairs(Y);
    xlabel('k');
    ylabel('Y');
    hold on;
end
legend({'TODO2','TODO2','TODO2','TODO2','TODO2'})