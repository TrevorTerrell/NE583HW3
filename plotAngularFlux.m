function plotAngularFlux(x, mu, psi)
    hold on;
    for i = 1:length(mu)
        flux = abs(psi(i, :) * mu(i) * 2);
        plot(x, flux, 'LineWidth', 2);
        if mu(i) > 0
            if flux(end) > 0.05
                text(x(end), flux(end), sprintf('\\mu = %.3f', mu(i)), "VerticalAlignment", "middle")
            end
        else
            if flux(1) > 0.05
                text(0, flux(1), sprintf('\\mu = %.3f', mu(i)), "VerticalAlignment", "bottom")
            end
        end
    end

    xlabel('x');
    ylabel('Source-Normalized Angular Flux');

    grid on;
    box on;
    hold off;
end