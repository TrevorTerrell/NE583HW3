function plotScalarFlux(x, phi)
    hold on;

    plot(x, phi, "LineWidth", 2);

    xlabel('x');
    ylabel('Scalar Flux');

    grid on;
    box on;
    hold off;
end