clear all;

offset = 12;
iterations=300 + offset;

Upp=1.5;
Ypp=2.2;

U_step=1.75;

U(1:iterations)=Upp;
U(12:iterations)=U_step;

Y(1:11)=Ypp;
Y(12:iterations)=0;

for k=12:iterations
    Y(k)=symulacja_obiektu5Y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));
end


%Wyznaczenie zestawu liczb odpowiedzi skokowej dla DMC

for k=13:iterations
    s(k-12)=(Y(k)-Ypp)/0.5;
end

stairs(s, 'LineWidth', 1.1);
xlabel('$k$', 'Interpreter','latex');
ylabel('$s$', 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))


set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 300]);
print('plots/zadanie_3/zad_3_odpowiedz_skokowa_dmc','-depsc','-r400');  % Zapisywanie wykresu


%% Zapis do pliku

% s_file_path = 'data/zad3/u_' + string(U_step) + '_len_' + string(iterations-offset) +'_odp_skok_DMC_zad3.txt';
% 
% s_file = fopen(s_file_path,'w');
% fprintf(s_file, '%f %f \n', [1:iterations-offset; s]);
% fclose(s_file);
