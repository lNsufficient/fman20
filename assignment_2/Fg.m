function y = Fg(g,f,x)
%Returnerar y precis p� samma s�tt som F_g(x) �r definierad p� s 2 i
%handledningen.
y = 0;
    for i = 1:length(f)
        y = y + (g(x - i + 1)*f(i));
    end
end

