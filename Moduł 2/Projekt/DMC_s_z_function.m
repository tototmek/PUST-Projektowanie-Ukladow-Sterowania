function [s_z] = DMC_s_z_function(n)
    Upp=0;
    Ypp=0;
    Zpp=0;
    
    z_step=1;

    u(1:n)=Upp;
    y(1:n)=Ypp;
    z(1:n)=Zpp;
    z(8:n)=z_step;

    for k=8:n
        y(k)=symulacja_obiektu5y_p2(u(k-6),u(k-7),z(k-3),z(k-4),y(k-1),y(k-2));
    end
    
    for k=9:n
        s_z(k-8)=(y(k)-Ypp)/(z_step - Zpp);
    end

end

