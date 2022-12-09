function s = lokalny_model_odp_skok(upp, ypp, n)

    du = 0.05;

    y(1:n) = ypp;
    u(1:6) = upp;
    u(7:n) = upp + du;
    for k=7:n
        y(k)=symulacja_obiektu5y_p3(u(k-5),u(k-6),y(k-1),y(k-2));
    end
    s = (y(7:n) - ypp*ones(1, n-6)) / du;
end