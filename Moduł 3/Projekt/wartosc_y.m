function y = wartosc_y(u)
    u_tmp(1:100)=u;
    y_tmp(1:100)=0;
    for k=7:100
        y_tmp(k)=symulacja_obiektu11y(u_tmp(k-5),u_tmp(k-6),y_tmp(k-1),y_tmp(k-2));
    end
    y=y_tmp(100);
end