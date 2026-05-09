clear(); clc(); clf()

c = 4:0.1:5;
f = 4*(c.^3) - 30*(c.^2) + 85*c - 160;

plot2d(c, f)

h = gce()
line_handle = h.children
line_handle.thickness = 4
line_handle.line_mode = 1
line_handle.foreground = color('blue')

xtitle("Localização da raiz: latência f(c) = 4c³ - 30c² + 85c - 160",...
       "Carga simultânea c (centenas) [4, 5] ", ...
       "Diferença do limiar f(c)")

a = gca() // obter o manipulador dos eixos atuais
a.title.font_size = 6 // ajustar o tamanho da fonte do titulo
a.x_label.font_size = 6
a.y_label.font_size = 6
a.font_size = 6

xgrid()
