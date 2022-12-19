%%Socket Communication demo script
delete(instrfindall)
pause(2);

% D114 G1
% D115 G2
% D100 T1
% D101 T3

close all;
clear all; 
  
t = tcpip('192.168.127.251',4000, 'NetworkRole', 'client');

t.OutputBufferSize = 3000;
t.InputBufferSize = 3000;
 
fopen(t);
u1 = [];
u2 = [];
y1 = [];
y2 = [];
yzad1 = [];
yzad2 = [];

figure(1);
while (true)
    if (t.BytesAvailable ~= 0)
        temp = fscanf(t);
        eval(temp);
        u1 = [u1; U1];
        u2 = [u2; U2];
        y1 = [y1; Y1];
        y2 = [y2; Y2];
        yzad1 = [yzad1; Yz1];
        yzad2 = [yzad2; Yz2];
        %save("skok_u123.mat", "u1", "u2", "y1", "y2")
        
        subplot(3,1,1); plot(y1); hold on; plot(y2); hold off; title('Wyj?cie'); xlabel('iteracja');
        subplot(3,1,2); stairs(yzad1); hold on; stairs(yzad2); hold off; title('Wartosc zadana'); xlabel('iteracja');
        subplot(3,1,3); stairs(u1); hold on; stairs(u2); hold off; title('Sterowanie'); xlabel('iteracja');
        drawnow
    end
    pause(0.05);
end

fclose(t);
delete(t);
clear t;