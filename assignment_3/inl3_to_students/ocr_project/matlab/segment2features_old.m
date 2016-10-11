function features = segment2features(I)
features = zeros(15, 1);

%Kännetecken: hur många hål bokstaven har:
isl = bwlabel(I == 0, 4);
islandSizes = hist(isl(isl>0), 1:max(max(isl))); %hist för strlek på öar
[~, bgIsland] = max(islandSizes);
islandSizes(bgIsland) = [];
nbrisl = numel(islandSizes);
features(1) = nbrisl;
%kännetecken: summan av alla dessa öar delat med summan av alla
%bokstavspixlar
colored = sum(sum(I));
features(2) = sum(islandSizes)/colored;


%Följande rader tar reda på området som är det minsta möjliga som
%innehåller hela bokstaven
[i, j] = find(I);
minRow = min(i);
minCol = min(j);
maxRow = max(i);
maxCol = max(j);
I = I(minRow:maxRow, minCol:maxCol);

%Kännetecken, hur stor andel av pixlar som är färgade och utgör bokstaven. 

features(3) = colored/numel(I);

%Kännetecken: hur många hål kantområden bokstaven har
isl = bwlabel(I == 0, 4);
islandSizes = hist(isl(isl>0), 1:max(max(isl)));

islandSizeLimit = 4;
islandSizes(islandSizes < islandSizeLimit) = [];
nbrEdgeIsl = numel(islandSizes) -nbrisl; %nbrisl - öar inom bokstav
features(4) = nbrEdgeIsl;
features(5) = sum(islandSizes)/colored;
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
features(6) = max(sameCols) + 1;

%one more feature while i and j are sorted columnwise:
%Kännetecken: högsta minsta höjd (W har högsta minsta höjd precis på
%mitten) [Studera fallet för "R", om R har fnuttar längst ner är det inte
%säkert att den kommer på det den högsta höjden av det nedre utrymmet, den
%kommer någonstans mellan där fnuttarna har tagit slut]
newCol = [1; j(2:end) - j(1:end-1)];
[maxminheight, maxminheightcol] = max(i(newCol==1));


%Kännetecken: minsta högsta höjd: (Y har minsta högsta höjd precis på
%mitten) [ungefär som med fallet för "R" och högsta höjd så tillåter denna
%att fnuttar blockerar, så att högsta höjden kan "gömmas" pga fnuttar.]
[minmaxheight, minmaxheightcol] = min(i([newCol(2:end); 1] == 1));
height = size(I, 1);
width = size(I, 2);

features(7:10) = [maxminheight/height, minmaxheight/height, maxminheightcol/width, minmaxheightcol/width];

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
features(11) = max(sameRows) + 1; %Detta var alltså antalet streck på bredden


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



features(12) = (corners(2) - corners(1) + 1)/height;
features(13) = (corners(4) - corners(3) + 1)/height;
%densitet i ovan- respektive nederkant
features(14) = sum(I(1,:))/width;
features(15) = sum(I(end,:))/width;