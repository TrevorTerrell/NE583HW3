function plotAngularFlux(x, mu, psi)
    hold on;
    for i = 1:length(mu)
        flux = psi(i, :);
        plot(x, flux, 'LineWidth', 2);
        if (mod(i, 2) == 1) && (flux(end) > 0.05)
            text(x(end), flux(end), sprintf('\\mu = %.3f', mu(i)), "VerticalAlignment", "middle")
        end
    end

    xlabel('x');
    ylabel('Angular Flux');

    grid on;
    box on;
    hold off;
end