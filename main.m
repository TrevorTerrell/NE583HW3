dx = 0.1;
XSec_c = 0.1;
XSec_s = 0.1;
XSec_t = 0.4;
nu_XSec_f = 0.4;
M = 24; % discretizations in µ
N_min = 1;
N_max = 100;

[mu, w] = lgwt(M, -1, 1);

Jr = [];

% Don't know shape, so use trisection routine
psi_bottom = solveFlux(N_min, M, mu, w, XSec_t, XSec_c, nu_XSec_f, dx);
psi_top = solveFlux(N_max, M, mu, w, XSec_t, XSec_c, nu_XSec_f, dx);
for iter = 1:1e5
    N_lower = floor((N_max - N_min) / 3.0) + N_min;
    N_upper = N_max - ceil((N_max - N_min) / 3.0);
    psi_lower = solveFlux(N_lower, M, mu, w, XSec_t, XSec_c, nu_XSec_f, dx);
    psi_upper = solveFlux(N_upper, M, mu, w, XSec_t, XSec_c, nu_XSec_f, dx);

    slope_lower = sign((w(1:M/2) .* mu(1:M/2))' * (psi_bottom(1:M/2, end) - psi_lower(1:M/2, end)));
    slope_middle = sign((w(1:M/2) .* mu(1:M/2))' * (psi_lower(1:M/2, end) - psi_upper(1:M/2, end)));
    slope_upper = sign((w(1:M/2) .* mu(1:M/2))' * (psi_upper(1:M/2, end) - psi_top(1:M/2, end)));
end
for N = 1:50
    psi = solveFlux(N, M, mu, w, XSec_t, XSec_c, nu_XSec_f, dx);
    phi = w' * psi;
    Jr(end + 1) = (w(1:M/2) .* mu(1:M/2))' * psi(1:M/2, end);
end
semilogy(Jr)