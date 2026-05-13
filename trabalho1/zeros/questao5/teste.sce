// --------------------------------------------------------
// FUNÇÕES BASE
// --------------------------------------------------------
function y = f(c)
    y = 4*c^3 - 30*c^2 + 85*c - 160;
endfunction

function y = df(c) // Derivada para Newton-Raphson
    y = 12*c^2 - 60*c + 85;
endfunction

// Configurações Globais
tol = 1e-6;
max_iter = 100;

// --------------------------------------------------------
// 1. MÉTODO DA BISSECÇÃO
// --------------------------------------------------------
disp("=== MÉTODO DA BISSECÇÃO ===");
a = 4.0; b = 5.0; iter_bis = 0;
while (b - a)/2 > tol & iter_bis < max_iter
    iter_bis = iter_bis + 1;
    c_bis = (a + b) / 2;
    if f(a) * f(c_bis) < 0 then
        b = c_bis;
    else
        a = c_bis;
    end
end
mprintf("Raiz: %.6f | Iterações: %d\n\n", c_bis, iter_bis);

// --------------------------------------------------------
// 2. MÉTODO DA FALSA POSIÇÃO
// --------------------------------------------------------
disp("=== MÉTODO DA FALSA POSIÇÃO ===");
a = 4.0; b = 5.0; iter_fp = 0;
c_fp = a; erro_fp = 1;
while erro_fp > tol & iter_fp < max_iter
    iter_fp = iter_fp + 1;
    c_old = c_fp;
    c_fp = (a*f(b) - b*f(a)) / (f(b) - f(a));
    
    if f(a) * f(c_fp) < 0 then
        b = c_fp;
    else
        a = c_fp;
    end
    erro_fp = abs(c_fp - c_old);
end
mprintf("Raiz: %.6f | Iterações: %d\n\n", c_fp, iter_fp);

// --------------------------------------------------------
// 3. MÉTODO DE NEWTON-RAPHSON
// --------------------------------------------------------
disp("=== MÉTODO DE NEWTON-RAPHSON ===");
// Condição inicial: c0 = 5.0 
// Escolhemos 5.0 pois f(5) > 0 e a concavidade f''(5) = 24(5)-60 = 60 > 0.
c_nr = 5.0; iter_nr = 0; erro_nr = 1;
while erro_nr > tol & iter_nr < max_iter
    iter_nr = iter_nr + 1;
    c_old = c_nr;
    c_nr = c_nr - f(c_nr)/df(c_nr);
    erro_nr = abs(c_nr - c_old);
end
mprintf("Raiz: %.6f | Iterações: %d\n\n", c_nr, iter_nr);

// --------------------------------------------------------
// 4. MÉTODO DA SECANTE
// --------------------------------------------------------
disp("=== MÉTODO DA SECANTE ===");
// Condições iniciais: extremos do intervalo
c0 = 4.0; c1 = 5.0; iter_sec = 0; erro_sec = 1;
while erro_sec > tol & iter_sec < max_iter
    iter_sec = iter_sec + 1;
    c_sec = c1 - (f(c1) * (c1 - c0)) / (f(c1) - f(c0));
    erro_sec = abs(c_sec - c1);
    c0 = c1;
    c1 = c_sec;
end
mprintf("Raiz: %.6f | Iterações: %d\n", c_sec, iter_sec);
