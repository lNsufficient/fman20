function y = Fg(g,f,x)
%Returnerar y precis på samma sätt som F_g(x) är definierad på s 2 i
%handledningen.
y = 0;
    for i = 1:length(f)
        y = y + (g(x - i + 1)*f(i));
    end
end

