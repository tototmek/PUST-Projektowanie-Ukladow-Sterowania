clear all;

n=200;

Upp1=0;
Upp2=0;
Upp3=0;
Upp4=0;

Ypp1=0;
Ypp2=0;
Ypp3=0;

unused_input = 1;

% create for all inputs
Tp = [0.5, 0.5, 0.5];
K = [2, 1, 1.5];
Ti = [4, 0.5, 2];
Td = [0.2, 0.4, 0.1];

r0 = K .* (1 + (Tp./(2*Ti)) + (Td./Tp));
r1 = K .* ((Tp./(2*Ti)) - 2 * (Td./Tp) - 1);
r2 = K .* Td ./ Tp;

y1_zad(1:50)=0;
y1_zad(50:400)=0.5;
y1_zad(400:800)=1;
y1_zad(800:1200)=1.5;
y1_zad(1200:1600)=0.5;

y2_zad(1:50)=0;
y2_zad(50:400)=1;
y2_zad(400:800)=1.5;
y2_zad(800:1200)=1;
y2_zad(1200:1600)=0.5;

y3_zad(1:50)=0;
y3_zad(50:400)=1;
y3_zad(400:800)=0.5;
y3_zad(800:1200)=0;
y3_zad(1200:1600)=1;

y1(1:n)=0;
y2(1:n)=0;
y3(1:n)=0;

e(3:n) = 0;

for k=5:n
    [y1(k), y2(k), y3(k)] = symulacja_obiektu5y_p4(...
       u1(k-1), u1(k-2), u1(k-3), u1(k-4), ...
       u2(k-1), u2(k-2), u2(k-3), u2(k-4), ...
       u3(k-1), u3(k-2), u3(k-3), u3(k-4), ...
       u4(k-1), u4(k-2), u4(k-3), u4(k-4), ...
       y1(k-1), y1(k-2), y1(k-3), y1(k-4), ...
       y2(k-1), y2(k-2), y2(k-3), y2(k-4), ...
       y3(k-1), y3(k-2), y3(k-3), y3(k-4));
   
   e(1, k) = y1_zad(k) - y1(k);
   e(2, k) = y2_zad(k) - y2(k);
   e(3, k) = y3_zad(k) - y3(k);
   
   if wejscie==1
        du1=0; 
    elseif wejscie==2
         du1=0; 
    elseif wejscie==3
         du1=0; 
    elseif wejscie==4
         du1=0; 
    end 
end


