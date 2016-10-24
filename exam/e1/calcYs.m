function Y = calcYs(abc, X)
%CALCYS for a given X and abc vector (containing a, b, c) calculates
%y-values
%   abc = [a b c]
%   X = x values;

if (abc(2) == -1)
    Y = abc(1)*X + abc(3);
else
    disp('abc(2) is not -1')
    abc
    Y = (abc(1)*X + abc(3))/(-abc(2));
end
end

