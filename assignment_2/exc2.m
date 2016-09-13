f = [1 4 6 8 7 5 3]
%plot(f)
%hold on;
%plot(f, 'x')
ylabel('f - värden')

pixs = [0, 1 ,2, 3, 4, 5, 6];

g = @(x) (-1<=x).*(x<0).*(1+x) + (0<=x).*(x<1).*(1-x);
gp = @(x) (-1<x).*(x<0).*(1) + (0<x).*(x<1).*(-1) + 0.5.*((x==-1) -(x==1));
y = @(x) Fg(g,pixs,x);
yp = @(x) Fg(gp,pixs,x);

x = [0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5];

Fgvals = y(x);
Fgvalsp = yp(x);

