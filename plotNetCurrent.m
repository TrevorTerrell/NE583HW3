function plotNetCurrent(x, curr)
    hold on;
    plot(x, curr, "LineWidth", 2);

    xlabel('x');
    ylabel('Current');

    grid on;
    box on;
    hold off;
end