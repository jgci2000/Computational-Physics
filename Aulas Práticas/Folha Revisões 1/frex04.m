function derivadas = frex04(t, solucao, w0, q, wd, Fd)
    derivadas = zeros(2, 1);
    theta = solucao(1);
    theta_dot = solucao(2);
    
    derivadas(1) = theta_dot;
    derivadas(2) = -w0 * sin(theta) - q * theta_dot + Fd * sin(wd * t);
end
