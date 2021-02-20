% João Inácio
% 93039
% PL7
function derivadas = func(t, solucao, m, K, beta, mu)
    % Inicialização do vetor das derivadas
    % derivadas(1) = dy/dt
    % derivadas(2) = dv/dt
    derivadas = zeros(2, 1);
    
    y = solucao(1);
    v = solucao(2);
    
    % Preenchimento do vetor das derivadas
    derivadas(1) = v;
    derivadas(2) = m^-1 * (mu * (1 - v^2) * v - K * (y + beta * y^3));
end

