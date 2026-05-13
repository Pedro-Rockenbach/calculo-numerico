clear(); clc(); clf()

x = 0.2:0.001:0.3;
y = 25*(x.^2) + log(x) - 1.5e-6;
plot2d(x, y)

h = gce()
line_handle = h.children
line_handle.thickness = 4
line_handle.line_mode = 1
line_handle.foreground = color('blue')

xtitle("Localização da raiz (escolhido): f(d) = 25*x^2 + ln(x) - 1.5e-6",...
       "Diâmetro d (mm) [0.2, 0.3] ", ...
       "Valores de pressão f(d)")

a = gca() // obter o manipulador dos eixos atuais
a.title.font_size = 6 // ajustar o tamanho da fonte do titulo
a.x_label.font_size = 6
a.y_label.font_size = 6
a.font_size = 6

xgrid()
