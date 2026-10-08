function psi = iterSource(psi, Q, mu, N, M, dx, XSec_t)
    for m = 1:M
        if mu(m) > 0
            psi(m, :) = transport_sweep(N, mu(m), 0.5 / mu(m), dx, Q, XSec_t);
        else %mu(m) < 0
            psi(m, :) = flip(transport_sweep(N, -mu(m), 0, dx, flip(Q), XSec_t));
        end
    end
end