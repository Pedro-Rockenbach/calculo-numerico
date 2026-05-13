// --------------------------------------------------------
// FUNÇÕES BASE
// --------------------------------------------------------
function y = f(d)
    y = 5 - 20*(exp(-0.2*d) - exp(-0.75*d));
endfunction

function y = df(d) // Derivada para o método de Newton
    y = 4*exp(-0.2*d) - 15*exp(-0.75*d);
endfunction

// Configurações Globais
tol = 1e-6;
max_iter = 100;

// --------------------------------------------------------
// 1. MÉTODO DA BISSECÇÃO
// --------------------------------------------------------
disp("=== MÉTODO DA BISSECÇÃO ===");
a = 0.0; b = 1.0; iter_bis = 0;
while (b - a)/2 > tol & iter_bis < max_iter
    iter_bis = iter_bis + 1;
    d_bis = (a + b) / 2;
    if f(a) * f(d_bis) < 0 then
        b = d_bis;
    else
        a = d_bis;
    end
end
mprintf("Raiz: %.6f | Iterações: %d\n\n", d_bis, iter_bis);

// --------------------------------------------------------
// 2. MÉTODO DA FALSA POSIÇÃO
// --------------------------------------------------------
disp("=== MÉTODO DA FALSA POSIÇÃO ===");
a = 0.0; b = 1.0; iter_fp = 0;
d_fp = a; erro_fp = 1;
while erro_fp > tol & iter_fp < max_iter
    iter_fp = iter_fp + 1;
    d_old = d_fp;
    d_fp = (a*f(b) - b*f(a)) / (f(b) - f(a));
    
    if f(a) * f(d_fp) < 0 then
        b = d_fp;
    else
        a = d_fp;
    end
    erro_fp = abs(d_fp - d_old);
end
mprintf("Raiz: %.6f | Iterações: %d\n\n", d_fp, iter_fp);

// --------------------------------------------------------
// 3. MÉTODO DE NEWTON-RAPHSON
// --------------------------------------------------------
disp("=== MÉTODO DE NEWTON-RAPHSON ===");
// Condição inicial: d0 = 0.5 
d_nr = 0.5; iter_nr = 0; erro_nr = 1;
while erro_nr > tol & iter_nr < max_iter
    iter_nr = iter_nr + 1;
    d_old = d_nr;
    d_nr = d_nr - f(d_nr)/df(d_nr);
    erro_nr = abs(d_nr - d_old);
end
mprintf("Raiz: %.6f | Iterações: %d\n\n", d_nr, iter_nr);

// --------------------------------------------------------
// 4. MÉTODO DA SECANTE
// --------------------------------------------------------
disp("=== MÉTODO DA SECANTE ===");
// Condições iniciais: extremos do intervalo
d0 = 0.0; d1 = 1.0; iter_sec = 0; erro_sec = 1;
while erro_sec > tol & iter_sec < max_iter
    iter_sec = iter_sec + 1;
    d_sec = d1 - (f(d1) * (d1 - d0)) / (f(d1) - f(d0));
    erro_sec = abs(d_sec - d1);
    d0 = d1;
    d1 = d_sec;
end
mprintf("Raiz: %.6f | Iterações: %d\n", d_sec, iter_sec);
