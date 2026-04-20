clear(); clc(); clf()

x = -4:0.1:4
y = x.^2-3
plot2d(x, y)

h = gce()
line_handle = h.children
line_handle.thickness = 4
line_handle.line_mode = 1
line_handle.foreground = color('blue')

xtitle("Localização das raizes: gráfico de f(x)=x^2-3",...
       "Valores de dominio [-4, 4] ", ...
       "Valores da função da função f(x)=y")

a = gca() // obter o manipulador dos eixos atuais
a.title.font_size = 4 // ajustar o tamanho da fonte do titulo
a.x_label.font_size = 4
a.y_label.font_size = 4

xgrid()
