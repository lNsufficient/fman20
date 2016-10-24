clear;
clf;
%RANSAC implementerad med hjälp av föreläsning 8 extra, slide 43, algorithm
%15.4

load('tentadata2016okt.mat')
Xs = pointx;
Ys = pointy;

n = 2;
k = 5000;
t = 0.29/2; %Got this by testing. 
d = 500; %Got this by testing (for the last line, d ends up 
%being around 215)

nbrPoints = numel(Xs);
current_best = 0;

nbrLines = 5;
abcS = zeros(nbrLines, n+1);

plot(Xs,Ys, 'o')

hold on;
current_close = [];

for j = 1:nbrLines;
    
    while (isempty(current_close))
        %perform ransac to find the best current line
        for i = 1:k;
            current = randi(nbrPoints, [1 n]); %väljer index att använda som punkter för att passa en kurva efter;
            abc = fitCurve(Xs(current), Ys(current));
            [nbr_close_points, ~, closePoints] = calcDistances(abc, Xs, Ys, t, current);
            if (nbr_close_points > d)
                abc_new = totalLsq(Xs(closePoints), Ys(closePoints));
                [nbr_close_points, ~, closePoints] = calcDistances(abc, Xs, Ys, t, []);
                if nbr_close_points > current_best
                    current_best = nbr_close_points;
                    current_abc = abc_new;
                    current_abc_old = abc;
                    current_close = closePoints;
                end
            end
        end
        if isempty(current_close)
            disp('found no good enough points, decreasing d, press space')
            d = d*0.9;
            pause;
            continue;
        end
    end
    
    abc = current_abc;
    abcS(j,:) = abc;
    abc = current_abc;

    plotX = linspace(-5,5);
    plotY = calcYs(abc, plotX);

    plot(Xs(current_close),Ys(current_close), 'ro');
    plot(plotX, plotY, 'g');
    disp('points red, line green, press space')
    pause;
    
    %get ready for new run:
    Xs(current_close) = [];
    Ys(current_close) = [];
    nbrPoints = numel(Xs);
    current_best = 0;
    d = d*1; %change this if cannot find lines;
    current_close = [];
    
    clf;
    plot(Xs, Ys, 'o');
    hold on;
    disp('this is the new dataset, press space')
    pause;
    disp('found a line for j:')
    j
end

clf;

plot(pointx, pointy, 'o');
x = linspace(-5,5);
Ys = zeros(nbrLines, length(x));
hold on;
for i = 1:nbrLines
    Ys(i,:) = calcYs(abcS(i,:), x);
end
plot(x, Ys,'r');