function features = segment2features(I)

%Första kännetecken, hur många pixlar som är färgade och utgör bokstaven. 
features(1) = sum(sum(I));

%nästa kännetecken: maximalt antal streck (efter hål) på rad respektive
%kolumn
[i, j] = find(I);
rowdiffs = i(2:end) - i(1:end-1);
interestingDiffs = find(rowdiffs > 1);
if(~isempty(interestingDiffs))
    diffsCols = j(interestingDiffs);
    %följande två rader var för att försöka få koden att bli snabbare än en
    %for-loop. Dock har jag inte så god koll på hur hist eller unique funkar,
    %säg gärna till om de är långsamma så for-loop hade varit att föredra.
    sameCols = hist(diffsCols, unique(diffsCols));
else 
    sameCols = 0;
end
features(2) = max(sameCols) + 1;

[i, index] = sort(i);
j = j(index);
coldiffs = j(2:end) - j(1:end-1);
interestingDiffs = find(coldiffs > 1);
if(~isempty(interestingDiffs))
    diffsRows = i(interestingDiffs);
    sameRows = hist(diffsRows, unique(diffsRows));
else
    sameRows = 0;
end
features(3) = max(sameRows) + 1;


%Nästa kännetecken, hur bred bokstaven är i ovankant och nederkant:
corners = zeros(4,1);
%topleft corner:
corners(1) = j(1);

%topright corner
t = find(i > i(1),1);
corners(2) = j(t-1);

%buttom right corner
corners(4) = j(end);

t = find(i == i(end), 1);
corners(3) = j(t);

features(4) = corners(2) - corners(1);
features(5) = corners(4) - corners(3);





%Kännetecken: hur många hål bokstaven har:
isl = bwlabel(I == 0);
nbrisl = max(max(isl)) -1; %här kan man få problem om det bara är en liten ö
features(6) = nbrisl;



