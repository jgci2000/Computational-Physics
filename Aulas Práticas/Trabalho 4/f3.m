function derivadas = f3(t, solucao, c)
    derivadas = zeros(3, 1);
    
    x = solucao(1);
    y = solucao(2);
    z = solucao(3);
    
    derivadas(1) = - y - z;
    derivadas(2) = x + 0.2 * y;
    derivadas(3) = 0.2 + (x - c) * z;
end

