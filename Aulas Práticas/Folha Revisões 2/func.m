function derivadas = func(t, solucao, K, alpha)
    % Inicialização do vetor das derivadas
    % derivadas(1) = dy/dt
    % derivadas(2) = dv/dt
    derivadas = zeros(2, 1);
    
    x = solucao(1);
    v = solucao(2);
    
    % Preenchimento do vetor das derivadas
    derivadas(1) = v;
    derivadas(2) = -K * x * (1 + (3/2) * alpha * x);
end

