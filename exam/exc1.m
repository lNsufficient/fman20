clear;
%RANSAC implementerad med hjälp av föreläsning 8 extra, slide 43, algorithm
%15.4

load('tentadata2016okt.mat')
Xs = pointx;
Ys = pointy;

n = 2;
k = 100;
t = 0.4/2; %Got this by zooming and guessing. 
d = 1e3; %Don't know this yet.

nbrPoints = numel(Xs);

for i = 1:k;
    current = randi(nbrPoints, [1 n]); %väljer index att använda som punkter för att passa en kurva efter;
    abc = fitCurve(Xs(current), Ys(current));
    small_distance_points = calcDistances(abc, Xs, Ys, t, current);
    if small_distance_points > current_best
        current_best = small_distance_ponts;
        current_abc = abc;
    end
end

plotX = linspace(-5,5);
plotY = calcYs(abc, plotX);

plot(plotX, plotY, 'r');


plot(Xs,Ys, 'o')
