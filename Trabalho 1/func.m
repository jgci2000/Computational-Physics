function derivadas = func(t, solucao, m, K, alpha, mu, F0, w0)
    % Inicialização do vetor das derivadas
    % derivadas(1) = dy/dt
    % derivadas(2) = dv/dt
    derivadas = zeros(2, 1);
    
    y = solucao(1);
    v = solucao(2);
    
    % Preenchimento do vetor das derivadas
    derivadas(1) = v;
    derivadas(2) = m^-1 * (mu * v * cos(v) - K *(y + alpha * y^3) + F0 * cos(w0 * t));
end

