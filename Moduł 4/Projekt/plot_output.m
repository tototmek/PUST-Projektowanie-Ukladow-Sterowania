function plot_output(u, y, y_zad)
    figure;
    set(gcf,'Position',[100 100 500 700])
    set(groot,'defaultAxesTickLabelInterpreter', 'latex'); 
    ny = size(y, 1);
    nu = size(u, 1);
    length = size(y, 2);
    E = 0;
    for i = 1:ny
        E = E + sum((y_zad(i, :) - y(i, :)).^2);
    end
    first = true;
    for y_index = 1:ny
        subplot(ny+1,1,y_index);
        stairs(y(y_index, :));
        hold on;
        stairs(y_zad(y_index, :),':');
        xlim([0 length])
        ylim([-0.15, 1.15])
        yl = get(gca, "YTickLabel");
        yl = strrep(yl, ".", ",");
        set(gca, "YTickLabel", yl);
        ylabel(sprintf('$y_%d$', y_index), Interpreter='latex');
        xlabel('$k$', Interpreter='latex');
        legend({sprintf('$y_%d$', y_index), sprintf('$y^{zad}_%d$', y_index)}, Interpreter='latex')
        if first
            first = false;
            title(append(strrep(strrep(sprintf("$E=%.2e", E), ".", ","), "e+0", "\cdot 10^{"), "}$"), Interpreter="latex");
        end
    end
    
    subplot(ny+1,1,ny+1);
    for u_index = 1:nu
        stairs(u(u_index, :));
        hold on;
        legnd{u_index} = sprintf('$u_%d$', u_index);
    end
    xlim([0 length])
    xlabel('$k$', Interpreter="latex");
    ylabel('$u$', Interpreter="latex")
    yl = get(gca, "YTickLabel");
    yl = strrep(yl, ".", ",");
    set(gca, "YTickLabel", yl);
    legend(legnd, Interpreter="latex");
end