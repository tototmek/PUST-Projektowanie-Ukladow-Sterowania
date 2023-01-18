% %%Socket Communication demo script
% delete(instrfindall)
% pause(2);
% 
% % D114 G1
% % D115 G2
% % D100 T1
% % D101 T3
% 
% close all;
% clear all; 
%   
% t = tcpip('192.168.127.251',4000, 'NetworkRole', 'client');
% 
% t.OutputBufferSize = 3000;
% t.InputBufferSize = 3000;
%  
% fopen(t);
% u1 = [];
% u2 = [];
% y1 = [];
% y2 = [];
% yzad1 = [];
% yzad2 = [];
% 
% figure(1);
% while (true)
%     if (t.BytesAvailable ~= 0)
%         temp = fscanf(t);
%         eval(temp);
%         u1 = [u1; U1/10];
%         u2 = [u2; U2/10];
%         y1 = [y1; Y1/100];
%         y2 = [y2; Y2/100];
% %         yzad1 = [yz1; YZ1];
% %         yzad2 = [yz2; YZ2];
% %         save("odp_skokowa2.mat")
%         
%         subplot(2,1,1); plot(y1); hold on; plot(y2); hold off; title('Wyjscie'); xlabel('iteracja')
%         subplot(2,1,2); stairs(u1); hold on; stairs(u2); hold off; title('Sterowanie'); xlabel('iteracja');
%         drawnow
%     end
%     pause(0.05);
% end
% 
% fclose(t);
% delete(t);
% clear t;

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
u = [];
y = [];
y_zad = [];
u2 = [];
y2 = [];
y_zad2 = [];


figure(1);
while (true)
    if (t.BytesAvailable ~= 0)
        temp = fscanf(t);
        eval(temp);
        u = [u; u_w];
        y = [y; y_w];
        y_zad = [y_zad; y_zad_w];
%         yzad1 = [yz1; YZ1];
%         yzad2 = [yz2; YZ2];
%         save("odp_skokowa2.mat")
        
        subplot(2, 1, 1);
        plot(y);
        hold on;
        plot(y_zad, ':');
        hold off;
        title('Wyjscie'); 
        xlabel('iteracja');
        
        subplot(2, 1, 2);
        stairs(u); title('Sterowanie'); 
        xlabel('iteracja');
        drawnow
    end
    pause(0.05);
end

fclose(t);
delete(t);
clear t;