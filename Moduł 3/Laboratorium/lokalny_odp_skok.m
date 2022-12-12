function s = lokalny_odp_skok(filename)
    data = load(filename);
    y = data.y;
    u = data.u;
    ypp = y(1) * ones(size(y));
    upp = 25;
    du = u - upp;
    s = (y - ypp) / du;
end