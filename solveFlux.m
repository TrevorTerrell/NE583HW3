function psi = solveFlux(N, M, mu, w, Xsec_t, Xsec_c, nu_Xsec_f, dx, source_n)
    phi = ones(N, 1);
    psi = zeros(M, N);
    source = zeros(N, 1);
    doIn = true;
    if source_n > 0
        source(1) = 1/dx;
        doIn = false;
    end
    for iter = 1:1e5
        phi_old = phi;
        Q = 0.5 * (Xsec_c + nu_Xsec_f) * phi + source';
        psi = iterSource(psi, Q, mu, N, M, dx, Xsec_t, doIn);
        phi = w' * psi;
        if (max(abs(phi - phi_old)) / max(abs(phi)) < 1e-8)
            break
        end
    end
end