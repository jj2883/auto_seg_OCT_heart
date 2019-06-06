%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%v2: add maximum number of layers to overlay the parameter
close all, clc, clear;
tic

%%
%image import
Bscan2 = imread('Fig.tif');
Bscan1 = double(imread('14_1_1_105_d1252.tif'));
%Bscan1 = padarray(Bscan1,50,0,'pre');

%Bscan1 = double(imread('Fig.tif'));

% r = double(Bscan1)./255;              % normalise the image
% c = 1;              % constant
% gamma = 1.1;          % to make image dark take value of gamma > 1, to make image bright take vlue of gamma < 1
% Bscan1 = c*(r).^gamma;   % formula to implement power law transformation


%%
fprintf('--------------imagefiltering-----------\n')
addpath('BM3D');

%im_std = std2(Bscan1)+30;
im_std = std2(Bscan1);
Bscan = Jun_BM3D_filtering(Bscan1,im_std).*255;
%      [PSNR, y_est] = BM3D(y, z, sigma);


% r = double(Bscan)./255;              % normalise the image
% c = 1;              % constant
% gamma = 1.5;          % to make image dark take value of gamma > 1, to make image bright take vlue of gamma < 1
% Bscan = c*(r).^gamma;   % formula to implement power law transformation
% figure(3); imshow(Bscan);
%%       
fprintf('--------------Detecting the surface-----------\n')
%downsampling interval
parameter.interval = 1;
%blurring gaussian mask std and mask size
parameter.sigma = 5;
parameter.hsize = 20;

%Graph Method
boundary = surface_detect(Bscan, parameter);
maxLayer = 1;  %overidethe parameter



%%
fprintf('--------------Determine number of layers-----------\n')

%shift Bscan
%BscanShift = Bscanshift(Bscan, boundary);

% 
[rowBscan columnBscan] = size(Bscan);
% 
% 
% %parameterLayer.th = 0.34;
parameterLayer.th = 0.34;

% 
% parameterLayer.smPara = round(rowBscan/20);
% %[turningPointFinal, offsetCol] = layerEstimation(BscanShift, boundary, parameterLayer);
% [turningPointFinal, offsetCol] = layerEstimation(Bscan, boundary, parameterLayer);
% 
% % 

figure(222)
imshow(Bscan1./255)
colormap(gray)
hold on
for i = 1:1
%   boundaryFinal(i,:) = boundary(i,:) - offsetCol';
   boundaryFinal(1,:) = boundary(:,1);
   %lineStyle = lineStyleAll{i}(1,:);
   lineBound = boundaryFinal(i,:);
   lineBound = smooth(lineBound, 21);        
   plot(1:columnBscan, lineBound, 'Linewidth', 2)
end

label = zeros([rowBscan,columnBscan]);
for i = 1:columnBscan
    for j = 1:rowBscan
        
        if lineBound(i)<j
            label(j,i)=0;
            
        else lineBound(i)>=j
            label(j,i)=1;
            
        end
            
        
        
        
        
    
    
    
    end
end

% 

% 
% 
% %
% fprintf('--------------Boundary searching-----------\n')
% %weight matrix generation
% parameterWM.w1 = 0.56;
% parameterWM.w2 = 0.38;
% %[weightMatrix, startYAll, numOfLayer]  = weightGen(turningPointFinal,BscanShift, parameterWM);
% [weightMatrix, startYAll, numOfLayer]  = weightGen(turningPointFinal,Bscan, parameterWM);
%    
% figure(1), imagesc(weightMatrix), colormap(gray), hold on
% 
% numOfLayer = maxLayer;
% %search
% parameterSearch.a = 1;
% parameterSearch.b = 1;
% parameterSearch.deltaY = 4;
% boundaryFinal = boundarySearch( weightMatrix, numOfLayer, parameterSearch, startYAll, offsetCol, Bscan);
% 
