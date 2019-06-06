function [WeightMatrix, startYAll,numOfLayer] = weightGen(turningPointFinal,BscanShift, parameter)
%generate weight matrix for boundary searching
%   Detailed explanation goes here

LayerWeight = layerWeightCal(turningPointFinal,BscanShift, 10);         
if length(turningPointFinal) == 2
    startYAll = turningPointFinal;
else
startYAll = turningPointFinal(1:end-1);
end
numOfLayer = min(length(startYAll), 4);
lineStyleAll = [{'r-'} {'b:'} {'g-.'} {'y--'}];
 [~, Gx, Gy] = gradientCalculation_v1(BscanShift);
 [G, Gxy, Gyy] = gradientCalculation_v1(Gy);
Gynorm = normalizeIm(abs(Gy));
Gyynorm = normalizeIm(Gyy);
BscanShiftnorm = normalizeIm(BscanShift);

WeightMatrix = parameter.w1.*abs(Gynorm) +  LayerWeight*parameter.w2 - ...
 (1-parameter.w1 -parameter.w2)*BscanShiftnorm;
sigma = 20;
hsize = 40;
blurh = fspecial('gauss',hsize,sigma);
WeightMatrix = imfilter(WeightMatrix,blurh,'replicate');
end

