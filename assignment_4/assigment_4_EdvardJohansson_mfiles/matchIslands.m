function [newLabeled, newLabels] = matchIslands(intersections, imL, labels_imL)
%MATCHISLANDS Kollar om vissa öar matchar varandra.
    [m,~] = find(intersections);
    newLabeled = zeros(size(imL));
    for i = 1:length(m);
        label_val = labels_imL(i);
        newLabeled = newLabeled + (imL == label_val)*m(i); 
    end
    newLabels = unique(m);
end

