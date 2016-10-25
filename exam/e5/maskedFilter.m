function I = maskedFilter(I, indI, filter)
%maskedFilter applies filter to I then returns Imasked which has only been
%changed at indicies indI.

Ifiltered = imfilter(I, filter, 'same');
I(indI) = Ifiltered(indI);


end

