function class = classVote(k_closest, Y)
%CLASSVOTE Y:s corresponding to indices in k_closest votes for a class.

y = Y(k_closest);
classes = unique(y);
if (numel(classes) == 2 && mod(numel(k_closest),2) == 1)
    class = median(y); %this works because there are only two classes. AND 
    %the number of neigbours is odd. Otherwise it could return mean. 
else
    h = hist(y, classes);
    [~, i] = max(h);
    class = classes(i);
end
end