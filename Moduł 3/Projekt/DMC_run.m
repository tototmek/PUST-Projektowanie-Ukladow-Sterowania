D=100;
N=74;
Nu=2;
lambda=10;

[U, Y, E] = DMC_normal(D, N, Nu, lambda);
Y_zad = get_steering_trajectory();

disp(E);

plot_results(Y, U, E, Y_zad);
