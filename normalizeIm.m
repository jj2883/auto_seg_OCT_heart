function Im = normalizeIm(input)
%normalize image to (0,1)
minVal = min(min(input));
maxVal = max(max(input));

Im = (input - minVal)/(maxVal - minVal);
