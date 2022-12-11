clear all;

offset = 12;
iterations=300 + offset;

Upp=1.5;
Ypp=2.2;

U_step=1.75;

s = DMC_s(iterations, U_step);

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
