G = G1;
%Detect the boundaries based on the searching minimum cost
%  G: gradient, showing the weight for each node
%startY: show the leftmost point for the edge
% a, b: weighting for bounary searching
[numOfRow numOfColumn] = size(G);
% a = 0.8;
% b = 0.5;

if numOfColumn == 1
    boundaryFirst(1) = startY;
else
    boundaryFirst(1) = startY;
    for i = 1:numOfColumn-1
         switch boundaryFirst(i)
                case 1
                    pool = [G(boundaryFirst(i), i+1) G(boundaryFirst(i)+1, i+1)]; %0 1
                    index = find(pool == min(pool));
                    boundaryFirst(i+1) =  boundaryFirst(i) + index - 1;
                case numOfRow
                    pool = [G(boundaryFirst(i)-1, i+1) G(boundaryFirst(i), i+1)]; %-1 0
                    index = find(pool == min(pool));
                    boundaryFirst(i+1) =  boundaryFirst(i) + index-2;
                    boundaryFirst(i+1)
   
                otherwise
                    pool = [G(boundaryFirst(i)-1, i+1) G(boundaryFirst(i), i+1) G(boundaryFirst(i)+1, i+1)]; % -1 0 1
                    index = find(pool == max(pool));
                    boundaryFirst(i+1) =  boundaryFirst(i) + index-2;
         end


    end
end


