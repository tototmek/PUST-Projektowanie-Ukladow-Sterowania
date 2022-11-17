clear all;

iterations=250;

Upp=1.5;
Ypp=2.2;
U(1:14) = Upp;
Y(1:iterations) = Ypp;


% Wyznaczenie różnych odpowiedzi skokowych

for i=-2:2
    U(15:iterations)=Upp+i*0.25;

    for k = 12:iterations
        Y(k) = symulacja_obiektu5Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
    end

    subplot(2,1,1);
    stairs(U, 'LineWidth', 1.1);
    xlabel('$k$', 'Interpreter','latex');
    ylabel('$u$', 'Interpreter','latex');
    ylim([0.8, 2.2])
    hold on;

    subplot(2,1,2);
    stairs(Y, 'LineWidth', 1.1);
    xlabel('$k$', 'Interpreter','latex');
    ylabel('$y$', 'Interpreter','latex');
    ylim([1.7, 2.7])
    hold on;


    % Zapis danych do pliku
    
%     u_file_path = 'data/zad2/u_' + string(Upp+i*0.25) + '_odp_skok_zad2.txt';
%     y_file_path = 'data/zad2/y_' + string(Upp+i*0.25) + '_odp_skok_zad2.txt';
% 
%     u_file = fopen(u_file_path,'w');
%     fprintf(u_file, '%f %f \n', [1:iterations; U]);
%     fclose(u_file);
%     
%     y_file = fopen(y_file_path,'w');
%     fprintf(y_file, '%f %f \n', [1:iterations; Y]);
%     fclose(y_file);

end

set(groot,'defaultAxesTickLabelInterpreter','latex'); 

subplot(2,1,1);
legend({'u = 1','u = 1,25','u = 1,5','u = 1,75','u = 2'}, 'Interpreter','latex')

subplot(2,1,2);
legend({'u = 1','u = 1,25','u = 1,5','u = 1,75','u = 2'}, 'Interpreter','latex')

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 300]);
print('plots/zadanie_2/zad_2_odpowiedzi_skokowe','-depsc','-r400');  % Zapisywanie wykresu
