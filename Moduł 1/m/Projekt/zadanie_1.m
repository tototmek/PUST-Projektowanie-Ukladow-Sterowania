clear all;

iterations=250;

Upp=1.5;
Ypp=2.2;

U(1:iterations)=1.5;
Y(1:11)=2.2;
Y(12:iterations)=0;

for k=12:iterations
    Y(k)=symulacja_obiektu5Y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));
end

subplot(2,1,1);
stairs(U, 'LineWidth', 1.5);
xlabel('k');
ylabel('U');
hold on;

subplot(2,1,2);
stairs(Y, 'LineWidth', 1.5);
xlabel('k');
ylabel('Y');
hold on;

%% Zapis do pliku
% u_file = fopen('data/zad1/u_zad1.txt','w');
% fprintf(u_file, '%f %f \n', [1:iterations; U]);
% fclose(u_file);
% 
% y_file = fopen('data/zad1/y_zad1.txt','w');
% fprintf(y_file, '%f %f \n', [1:iterations; Y]);
% fclose(y_file);