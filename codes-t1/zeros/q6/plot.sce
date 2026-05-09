clear(); clc(); clf()

d = 0:0.1:1;
y = 5 - 20*(exp(-0.2*d) - exp(-0.75*d));

plot2d(d, y)

h = gce()
line_handle = h.children
line_handle.thickness = 4
line_handle.line_mode = 1
line_handle.foreground = color('blue')

xtitle("Localização da raiz (escolhido): f(d) = 5 - 20*(exp(-0.2d) - exp(-0.75d))",...
       "Distância d (km) [0, 1] ", ...
       "Concentração ajustada f(d)")

a = gca() // obter o manipulador dos eixos atuais
a.title.font_size = 6 // ajustar o tamanho da fonte do titulo
a.x_label.font_size = 6
a.y_label.font_size = 6
a.font_size = 6

xgrid()
