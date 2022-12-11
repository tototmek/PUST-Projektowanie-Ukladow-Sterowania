Upp=1.5;
Ypp=2.2;
U_min=1;
U_max=2;
dU_max=0.1;
Tp=0.5;
T=1000;

Y_zad(1:60) = Ypp;
Y_zad(60:360) = 2.4;
Y_zad(360:660) = 2.1;
Y_zad(660:T) = 2.3;