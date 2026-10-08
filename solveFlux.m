function psi = solveFlux(N, M, mu, w, Xsec_t, Xsec_c, nu_Xsec_f, dx)
    phi = ones(N, 1);
    psi = zeros(M, N);
    for iter = 1:1e5
        phi_old = phi;
        Q = 0.5 * (Xsec_c + nu_Xsec_f) * phi;
        psi = iterSource(psi, Q, mu, N, M, dx, Xsec_t);
        phi = w' * psi;
        if (max(abs(phi - phi_old)) / max(abs(phi)) < 1e-8)
            break
        end
    end
end