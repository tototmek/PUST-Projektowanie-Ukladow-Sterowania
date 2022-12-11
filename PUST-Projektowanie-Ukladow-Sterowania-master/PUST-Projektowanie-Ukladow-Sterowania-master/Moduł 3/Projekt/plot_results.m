function plot_results(Y, U, E, Y_zad)
    figure
    
    subplot(2,1,1);
    stairs(Y);
    hold on;
    stairs(Y_zad,':');
    ylabel('$y$', 'Interpreter','latex');
    xlabel('$k$', 'Interpreter','latex');
    legend({'$y$', '$y^{zad}$'}, 'Interpreter','latex')
    title(strrep(sprintf("$E=%f$", E), ".", ","), Interpreter="latex");
    ylim([-0.5, 3.5]);
    
    
    subplot(2,1,2);
    stairs(U, "r");
    ylabel('$u$', 'Interpreter','latex');
    xlabel('$k$', 'Interpreter','latex');
    legend({'$u$'}, 'Interpreter','latex');
    
    yl = get(gca,'YTickLabel');
    set(gca, 'YTickLabel', strrep(yl(:),'.',','))
    
    set(groot,'defaultAxesTickLabelInterpreter','latex'); 
    set(gcf,'units','points','position',[100 100 450 400]);
end