dx = 0.1;
XSec_c = 0.1;
XSec_s = 0.1;
XSec_t = 0.4;
nu_XSec_f = 0.4;
M = 12; % discretizations in µ
N_min = 1;
N_max = 100;
Nx = -1;

[mu, w] = lgwt(M, -1, 1);

for iter = 1:1e5
    N_mid = ceil((N_max - N_min) / 2) + N_min;
    if N_mid == N_max || N_mid == N_min
        Nx = N_mid
        break
    end

    psi = solveFlux(N_mid, M, mu, w, XSec_t, XSec_c, nu_XSec_f, dx, 0);

    T = (w(1:M/2) .* mu(1:M/2))' * psi(1:M/2, end) .* 2;

    if T > 1
        N_max = N_mid;
    elseif T < 1
        N_min = N_mid;
    end
end
Jr = zeros(Nx + 1, 1); % +1 for 0 incoming current
Jr(1) = 0.5; % by definition
mult = zeros(Nx + 1, 1);
mult(1) = 0; %by definition
for N = 1:Nx
    psi = solveFlux(N, M, mu, w, XSec_t, XSec_c, nu_XSec_f, dx, 0);
    phi = w' * psi;
    Jr(N + 1) = (w(1:M/2) .* mu(1:M/2))' * psi(1:M/2, end);
    mult(N + 1) = dx * sum(phi) / sum(w(1:M/2) ./ mu(1:M/2));
end

psi_half = solveFlux(Nx / 2, M, mu, w, XSec_t, XSec_c, nu_XSec_f, dx, 0);

figure(1)
plotCurrentOfN(Jr)
figure(2)
plotMultiplicationOfN(mult)
figure(3)
plotMultOfCurrent(Jr, mult)
figure(4)
plotAngularFlux(dx:dx:Nx * dx, mu(1:M/2), psi(1:M/2, :))
figure(5)
plotAngularFlux(dx:dx:Nx * dx, mu(M/2 + 1:M), psi(M/2 + 1:M, :))
figure(6)
plotScalarFlux(dx:dx:dx * Nx, w' * psi)
plotScalarFlux(dx:dx:dx * Nx / 2, w' * psi_half)
legend(["Full", "Half"])
figure(7)
plotScalarFlux(dx:dx:dx * Nx, (w(1:M/2) .* mu(1:M/2))' * psi(1:M/2, :) + abs((w(M/2 + 1:M) .* mu(M/2 + 1:M))' * psi(M/2 + 1:M, :)))
plotScalarFlux(dx:dx:dx * Nx / 2, (w(1:M/2) .* mu(1:M/2))' * psi_half(1:M/2, :) + abs((w(M/2 + 1:M) .* mu(M/2 + 1:M))' * psi_half(M/2 + 1:M, :)))
plotScalarFlux(dx:dx:dx * Nx, (w(1:M/2) .* mu(1:M/2))' * psi(1:M/2, :))
plotScalarFlux(dx:dx:dx * Nx / 2, (w(1:M/2) .* mu(1:M/2))' * psi_half(1:M/2, :))
plotScalarFlux(dx:dx:dx * Nx, abs((w(M/2 + 1:M) .* mu(M/2 + 1:M))' * psi(M/2 + 1:M, :)))
plotScalarFlux(dx:dx:dx * Nx / 2, abs((w(M/2 + 1:M) .* mu(M/2 + 1:M))' * psi_half(M/2 + 1:M, :)))
legend(["Full - Total", "Half - Total", "Full - Right", "Half - Right", "Full - Left", "Half - Left"])

mult_source_pos = zeros(Nx + 1, 1);
mult_source_pos(1) = dx * sum(phi) / sum(w(1:M/2) ./ mu(1:M/2));
for N = 1:Nx
    psi = solveFlux(Nx, M, mu, w, XSec_t, XSec_c, nu_XSec_f, dx, N);
    phi = w' * psi;
    mult_source_pos(N + 1) = dx * sum(phi) / sum(abs(w ./ mu));
end

figure(8)
plotMultiplicationOfN(mult_source_pos)