function overlap = findMatches(I, y)
%FINDMMATCHES returns a logic matrix for the places where the intensity in
%I was the same as y, for all layers. 

N = length(y); 
layeroverlap = zeros(size(I));
[m, n] = find((I(:,:,1) == y(1)).*(I(:,:,2)==y(2)).*(I(:,:,3)==y(3)) == 1);
for i = 1:N
    layeroverlap(:,:,i) = (I(:,:,i) == y(i));
end

%test
[m, n] = find(layeroverlap(:,:,1) == 1);

[m, n, ~] = size(I);
overlap = ones(m, n);
for i = 1:N
    overlap = overlap.*layeroverlap(:,:,i);
end

end