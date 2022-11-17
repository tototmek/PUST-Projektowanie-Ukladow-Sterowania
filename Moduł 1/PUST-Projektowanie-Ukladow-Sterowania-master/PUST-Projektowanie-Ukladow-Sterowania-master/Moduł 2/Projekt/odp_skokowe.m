clear all;
close all;

%% Zadanie 1

n=200;

Upp=0;
Ypp=0;
Zpp=0;

U(1:n)=Upp;
Y(1:n)=Ypp;
Z(1:n)=Zpp;


% Sprawdzenie poprawności podanego punku pracy

for k=8:n
    Y(k)=symulacja_obiektu5y_p2(U(k-3),U(k-4),Z(k-1),Z(k-2),Y(k-1),Y(k-2));  % trzeba sprawdzić czy to jest prawidłowe, albo napisać do chabra
end

subplot(3,1,1);
stairs(U, "LineWidth", 2);
ylabel('U');
title("Sprawdzenie poprawności podanego punku pracy")

hold on;
subplot(3,1,2);
stairs(Z, "LineWidth", 2);
ylabel('Z');

hold on;
subplot(3,1,3);
stairs(Y, "LineWidth", 2);
ylabel('Y');
xlabel('k');



%% Zadanie 2

% pass