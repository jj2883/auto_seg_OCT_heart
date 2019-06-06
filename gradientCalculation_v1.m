function [G, Gx, Gy] = gradientCalculation_v1(Im)
%Input: Im
%Output: gradient

Sx = [-1 0 1; -2 0 2; -1 0 1];
Sy = [-1 -2 -1; 0 0 0; 1 2 1];
B = double(Im);
Gx = imfilter(B, Sx, 'replicate');
Gy = imfilter(B, Sy, 'replicate');
G = sqrt(Gx.^2 + Gy.^2);
end

