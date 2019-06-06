
[row col] = size(Bscan);
boundaryMin = (min(boundary));
%offset on the values
boundaryOffset = round((boundary - boundaryMin));

for i = 1:col
    %shift each column
    tempCol = Bscan(:,i);
    tempCol = circshift(tempCol,-boundaryOffset(i));
    Bscan(:,i) = tempCol;
    
end

% Bscan2 = circshift(Bscan, boundaryOffset);

maxshift = round(max(boundary-min(boundary)));
if row-maxshift<row
    Bscan(row-maxshift:row,:) = [];
end


