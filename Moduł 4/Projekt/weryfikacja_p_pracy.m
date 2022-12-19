%% Zadanie 1-2 - Sprawdzenie poprawności podanego punku pracy i wyznaczenie odpowiedzi skokowej

clear all;
close all;

n=200;

Upp1=0;
Upp2=0;
Upp3=0;
Upp4=0;

Ypp1=0;
Ypp2=0;
Ypp3=0;

u1(1:n)=Upp1;
u2(1:n)=Upp2;
u3(1:n)=Upp3;
u4(1:n)=Upp4;

y1(1:n)=Ypp1;
y2(1:n)=Ypp2;
y3(1:n)=Ypp3;

for k=5:n
   [y1(k), y2(k), y3(k)] = symulacja_obiektu5y_p4(...
       u1(k-1), u1(k-2), u1(k-3), u1(k-4), ...
       u2(k-1), u2(k-2), u2(k-3), u2(k-4), ...
       u3(k-1), u3(k-2), u3(k-3), u3(k-4), ...
       u4(k-1), u4(k-2), u4(k-3), u4(k-4), ...
       y1(k-1), y1(k-2), y1(k-3), y1(k-4), ...
       y2(k-1), y2(k-2), y2(k-3), y2(k-4), ...
       y3(k-1), y3(k-2), y3(k-3), y3(k-4));
end

figure;
hold on;
subplot(2,4,1);
stairs(u1, Color="#D95319");
ylabel('$u_1$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

subplot(2,4,2);
stairs(u2, Color="#D95319");
ylabel('$u_2$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

subplot(2,4,3);
stairs(u3, Color="#D95319");
ylabel('$u_3$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

subplot(2,4,4);
stairs(u4, Color="#D95319");
ylabel('$u_4$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

subplot(2,4,5);
stairs(y1);
ylabel('$y_1$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

subplot(2,4,6);
stairs(y2);
ylabel('$y_2$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

subplot(2,4,7);
stairs(y3);
ylabel('$y_3$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

% powtórzenie kodu, wiem :)