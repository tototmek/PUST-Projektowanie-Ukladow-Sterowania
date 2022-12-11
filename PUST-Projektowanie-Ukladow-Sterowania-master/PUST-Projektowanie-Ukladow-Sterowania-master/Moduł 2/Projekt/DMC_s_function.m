function [s] = DMC_s_function(n)
    Upp=0;
    Ypp=0;
    Zpp=0;

    u_step=1;

    u(1:n)=Upp;
    y(1:n)=Ypp;
    z(1:n)=Zpp;

    u(8:n)=u_step;

    for k=8:n
        y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z(k-3),z(k-4),y(k-1),y(k-2));
    end

    for k=9:n
        s(k-8)=(y(k)-Ypp)/(u_step - Upp);
    end
end

