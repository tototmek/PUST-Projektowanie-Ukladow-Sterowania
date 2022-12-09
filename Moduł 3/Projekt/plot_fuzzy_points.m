function plot_fuzzy_points(u, y)
    figure;
    u_all = (-1:0.01:1);
    y_all = u_all;
    for i = 1:size(u_all, 2)
        y_all(i) = wartosc_y(u_all(i));
    end
    plot(u_all, y_all, ":");
    hold on;
    plot(u, y, 'o');
    legend("Ch-ka statyczna", "Punkty rozmycia", Interpreter="latex", Location="northwest");
    yl = get(gca, "YTickLabel");
    yl = strrep(yl, ".", ",");
    set(gca, "YTickLabel", yl);
    xl = get(gca, "XTickLabel");
    xl = strrep(xl, ".", ",");
    set(gca, "XTickLabel", xl);
end