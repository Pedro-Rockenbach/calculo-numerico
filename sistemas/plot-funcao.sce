clear();clc();clf()

// Define os intervalos para os x
x1 = linspace(-5, 5, 200);
x2 = linspace(-5, 5, 200);

// Calcula y para cada equacao
y1 = -x1;
y2 = 1-x1;

//y1 = -x1;
//y2 = +x2;

//y1 = -x1;
//y2 = -x2; // equacao 2x + 2y = 0

// Plota as linhas para as equacoes
plot(x1, y1, 'b');
h1 = gce();
h1.children.thickness = 3;

plot(x2, y2, 'r--'); // reta vermelha para a linha
h2 = gce();
h2.children.thickness = 3;

// Adcona rotulos, legenda e grade
xlabel('Eixo X');
ylabel('Eixo Y');
legend(['x + y = 0', '2x + 2y = 0']);
xtitle('Graficos de x + y = 0 e 2x + 2y = 0');
a = gce(); // obter o manipulador dos eixos atuais
a.title.font_size = 4;
a.x_label.font_size = 4;
a.y_label.font_size = 4;
xgrid();
