close all;

offset = 7;
n=200 + offset;

Upp=0;
Ypp=0;

u_step=1;

u(1:n)=Upp;
y(1:n)=Ypp;

u(7:n)=u_step;

for k=7:n
    y(k)=symulacja_obiektu5y_p3(u(k-5),u(k-6),y(k-1),y(k-2));
end

for k=8:n
    s(k-7)=(y(k)-Ypp)/(u_step - Upp);
end

stairs(s);
xlabel('$k$', 'Interpreter','latex');
ylabel('$s$', 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 300]);
% print('plots/zadanie_3/zad_3_odp_wej_wyj','-depsc','-r400');  % Zapisywanie wykresu
