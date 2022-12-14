function plot_results(Y, U, E, Y_zad)
    figure
    
    subplot(2,1,1);
    stairs(Y);
    xlim([0 length(Y)])
    hold on;
    stairs(Y_zad,':');
    xlim([0 length(Y)])
    ylabel('$y$', 'Interpreter','latex');
    xlabel('$k$', 'Interpreter','latex');
    legend({'$y$', '$y^{zad}$'}, 'Interpreter','latex')
    title(strrep(sprintf("$E=%f$", E), ".", ","), Interpreter="latex");

    
    
    subplot(2,1,2);
    stairs(U, "r");
    ylabel('$u$', 'Interpreter','latex');
    xlabel('$k$', 'Interpreter','latex');
    legend({'$u$'}, 'Interpreter','latex');
    xlim([0 length(U)])
    
    
    set(groot,'defaultAxesTickLabelInterpreter','latex'); 
    set(gcf,'units','points','position',[100 100 450 400]);
end