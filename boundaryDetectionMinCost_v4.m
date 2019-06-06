function [boundaryFirst] = boundaryDetectionMinCost_v4(G, startY, a, b, direct, deltaY)
%Detect the boundaries based on the searching minimum cost, search in a
%neigbourhood of deltaY
%  G: gradient, showing the weight for each node
%startY: show the leftmost point for the edge
% a, b: weighting for bounary searching
%direction of search
[numOfRow numOfColumn] = size(G);
% a = 0.8;
% b = 0.5;

if direct == 2%start from leftmost to right most      
    boundaryFirst(1) = startY;
    for i = 1:numOfColumn-1
%          switch boundaryFirst(i)
%                 case 1
%                     pool = [b*G(boundaryFirst(i), i+1) G(boundaryFirst(i)+1, i+1)]; %0 1
%                     index = find(pool == min(pool));
%                     boundaryFirst(i+1) =  boundaryFirst(i) + index - 1;
%                 case numOfRow
%                     pool = [b*G(boundaryFirst(i)-1, i+1) G(boundaryFirst(i), i+1)]; %-1 0
%                     index = find(pool == min(pool));
%                     boundaryFirst(i+1) =  boundaryFirst(i) + index-2;
%                     boundaryFirst(i+1)
%    
%                 otherwise
%                     pool = [a*G(boundaryFirst(i)-1, i+1) b*G(boundaryFirst(i), i+1) G(boundaryFirst(i)+1, i+1)]; % -1 0 1
%                     index = find(pool == max(pool));
%                     boundaryFirst(i+1) =  boundaryFirst(i) + index-2;
%          end
         startID = max(1, boundaryFirst(i) - deltaY);
         endID = min(boundaryFirst(i) + deltaY, numOfRow);
         candidate = G(startID:endID, i+1);
         [minVal minID] = max(candidate);
         boundaryFirst(i+1) = startID + minID - 1;

    end
elseif direct == 1
    boundaryFirst(numOfColumn) = startY;
    for i = 1:numOfColumn-1
        indexC =  numOfColumn - i + 1;           
%         switch boundaryFirst(indexC)
%                 case 1
%                     pool = [b*G(boundaryFirst(indexC), indexC-1) G(boundaryFirst(indexC)+1, indexC - 1)]; %0 1
%                     index = find(pool == min(pool));
%                     boundaryFirst(indexC-1) =  boundaryFirst(indexC) + index - 1;
%                 case numOfRow
%                     pool = [b*G(boundaryFirst(indexC)-1, indexC-1) G(boundaryFirst(indexC), indexC-1)]; %-1 0
%                     index = find(pool == min(pool));
%                     boundaryFirst(indexC - 1) =  boundaryFirst(indexC) + index-2;
%                    % boundaryFirst(i+1)
%    
%                 otherwise
%                     pool = [a*G(boundaryFirst(indexC)-1, indexC-1) b*G(boundaryFirst(indexC), indexC-1) G(boundaryFirst(indexC)+1, indexC-1)]; % -1 0 1
%                     index = find(pool == max(pool));
%                     boundaryFirst(indexC - 1) =  boundaryFirst(indexC) + index-2;
%          end

         startID = max(1, boundaryFirst(indexC) - deltaY);
         endID = min(boundaryFirst(indexC) + deltaY, numOfRow);
         candidate = G(startID:endID, indexC-1);
         [minVal minID] = max(candidate);
         boundaryFirst(indexC-1) = startID + minID - 1;
    end
    
    
    
end
    
    
end

