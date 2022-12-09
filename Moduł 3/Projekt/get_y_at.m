function y = get_y_at(u)
    n = 2000;
    Y(1:n) = 0;
    for k = 7:n
        Y(k)=symulacja_obiektu5y_p3(u, u,Y(k-1),Y(k-2));
    end
    y = Y(n);
end