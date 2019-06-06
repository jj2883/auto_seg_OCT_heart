
%detect the surface of a Bscan
% -input 
% Bscan
% parameter.interval: interval for downsampling
% parameter.hsize and parameter.sigma: parameter for filtering
[rowImage columnImage] = size(Bscan);

lineStyleAll = [{'r-'} {'b:'} {'g-.'} {'y--'}];

%%
%downsampling
BscanDown = Bscan(1:parameter.interval:end, 1:parameter.interval:end);
[G11, Gx1, Gy1] = gradientCalculation_v1(BscanDown);
%edge detection
blurh = fspecial('gauss',parameter.hsize,parameter.sigma);
G1 = imfilter(G11,blurh,'replicate'); 
AlineLeftmost = smooth(mean(G1(:,1:10)')');
[value startY]= max(AlineLeftmost);

boundaryDetected = boundaryDetectionMinCost_v2(G1, startY); 
boundaryDetected = smooth(boundaryDetected);
length_boundaryDetected = length(boundaryDetected);
boundary(length_boundaryDetected.*parameter.interval:columnImage) = ...
boundaryDetected(end).*ones(columnImage-length_boundaryDetected.*parameter.interval+1);
boundary = repmat(boundaryDetected', [parameter.interval 1]);
boundary = boundary(:).*parameter.interval;%interpolate back
%lineStyle = lineStyleAll{i}(1,:);
% 
if length_boundaryDetected*3>columnImage
    boundary(columnImage + 1:end) = [];
end
% plotSurface = 0;
% if plotSurface == 1
%     hold on
%     pathFigSurface = [pathFigure '\SurfaceRawDetect\'];
%     plot(1:columnImage,boundary, lineStyle,'Linewidth', 2)
%     if exist(pathFigSurface) == 0
%         mkdir(pathFigSurface)
%     end
%     imagName =  [pathFigSurface '\Surface_' ...
%            num2str(HeartIndex) '_Chamber_' part '_Bscan_' num2str(ii) '.jpg'];
%        print('-dtiff','-r300',imagName)
% end

