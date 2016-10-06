function [Yclass] = classify(X,g)
%classify Klassifierar datan X med hjälp av funktionen g.

Yclass = 2*(g(X)>0)-1;
end

