function [nbrClose, distances, closePoints] = calcDistances(abc, Xs, Ys, t, current_index)
%CALCDISTANCES calculates the number of close points.
%   abc = [a b c] for line that is tested
%   Xs, Ys are all the x and y values that will be tested
%   t is maximal allowed distance
%   current_index are the points that was used to calculate abc.
%   f08 slide 15 (or something similar) was used to do this

distances = abs(abc(1)*Xs + abc(2)*Ys + abc(3))/sqrt(abc(1)^2 + abc(2)^2);
zero_dist = distances(current_index);
TOL = 1e-8;
if max(abs(zero_dist) > TOL)
    disp('The current_index points are too far away from the line');
    zero_dist
end
nbrClose = sum(distances < t) - sum(zero_dist < t);
closePoints = find(distances < t);
end

