function boundaryFinal = boundarySearch( WeightMatrix, numOfLayer, parameter, startYAll, offsetCol, Bscan)
%Search the boundary based on the weight matrix and number of layers
%
LayerCnt = 0;
cnt = 0;
lineStyleAll = [{'r-'} {'b:'} {'g-.'} {'y--'}];
[rowImage columnImage] = size(Bscan);
for i = 1:numOfLayer
       startY = startYAll(i); %the shift for the first point
       for  dirIn = 1:2
          WeightMatrixHalf = WeightMatrix(:,(dirIn-1)*round(columnImage/2)+1:(dirIn)*round(columnImage/2));
          boundaryDetected = boundaryDetectionMinCost_v4(WeightMatrixHalf, startY, parameter.a, parameter.b, dirIn, parameter.deltaY); 
          boundaryDetected = smooth(boundaryDetected, 15);
          boundary(i,(dirIn-1)*round(columnImage/2)+1:(dirIn)*round(columnImage/2)) = boundaryDetected;

       end

      lineStyle = lineStyleAll{i}(1,:);
      plot(1:columnImage,boundary(i,:), lineStyle,'Linewidth', 2) 
end
%combine the boundaries that merged
boundTemp = boundary;
boundTemp2 = boundary;
invalidLay = zeros(1,4);
for i = 1:numOfLayer
    for j = i+1:numOfLayer
       dif = abs(boundary(i,:) - boundary(j,:));
       if min(min(dif)) == 0
          invalidLay(i+1) =  1;
       end   
    end
end     
boundary(find(invalidLay == 1), :) = [];
numOfLayer = numOfLayer - sum(find(invalidLay == 1)>0) ;

figure(21)
imagesc(Bscan)
colormap(gray)
hold on
for i = 1:numOfLayer
   boundaryFinal(i,:) = boundary(i,:) + offsetCol';
   lineStyle = lineStyleAll{i}(1,:);
   lineBound = boundaryFinal(i,:);
   lineBound = smooth(lineBound, 21);        
   plot(1:columnImage, lineBound, lineStyle,'Linewidth', 4)
end

end

