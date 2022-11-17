iterations=300;
resolution = 100;
Upp=1.5;
Ypp=2.2;

u = linspace(1, 2, resolution);
y = zeros(size(u));

for i=1:resolution
    Ut=u(i);
    U(1:iterations)=Upp;
    U(12:iterations)=Ut;
    
    Y(1:11)=Ypp;
    Y(12:iterations)=0;
    
    for k=12:iterations
        Y(k)=symulacja_obiektu5Y_p1(U(k-10),U(k-11),Y(k-1),Y(k-2));
    end
    y(i) = Y(iterations);
end

figure;
plot(u, y);
xlabel('u');
ylabel('y');
title('Charakterystyka statyczna')

%% Zapis do pliku

char_stat_file_path = 'data/zad2/u_charakterystyka_statyczna_zad2.txt';

char_stat_file = fopen(char_stat_file_path,'w');
fprintf(char_stat_file, '%f %f \n', [u; y]);
fclose(char_stat_file);