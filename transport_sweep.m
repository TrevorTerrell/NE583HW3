function psi = transport_sweep(N, mu, psi_in, dx, Q, xsec_t)
    psi = zeros(1, N);
    for i = 1:N
        psi(1, i) = (mu * psi_in + dx * Q(i)) / (mu + xsec_t * dx);
        psi_in = psi(1, i);
    end
end