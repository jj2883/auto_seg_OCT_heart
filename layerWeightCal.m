function c = layerWeightCal(turningPoint,BscanShift, d)
%calculate an weight matrix to contrain the search area
%  

[row col] = size(BscanShift);
x = 1:col;
%y = 1 ./(1-exp(-abs(x - turningPoint)/100));
% y = 1 - (x - turningPoint).^2;%
% figure
% plot(y)
Point = [1 turningPoint row];
for i = 1:length(turningPoint)+1 %for each segment it is a sine function
    period = Point(i+1) - Point(i) + 1;
    x = 1:period;
    wave = 0.75 + 0.1*cos(x/period*(2*pi));
    AlineWeight(Point(i):Point(i+1)) = wave;
    
end
AlineWeight = AlineWeight/ max(AlineWeight);
% figure
% plot(AlineWeight)
% axis([0 row 0 1])
% 
 c = repmat(AlineWeight, [col 1])';
% figure
% imagesc(c)
end

