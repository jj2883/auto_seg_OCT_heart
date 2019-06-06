%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%v2: add maximum number of layers to overlay the parameter
%close all, clc, clear;
tic

%%
%image import
Bscan2 = imread('Fig.tif');
Bscan1 = double(imread('Fig.tif'));
%Bscan1 = padarray(Bscan1,50,0,'pre');

%Bscan1 = double(imread('Fig.tif'));

% r = double(Bscan1)./255;              % normalise the image
% c = 1;              % constant
% gamma = 1.1;          % to make image dark take value of gamma > 1, to make image bright take vlue of gamma < 1
% Bscan1 = c*(r).^gamma;   % formula to implement power law transformation


%%
fprintf('--------------imagefiltering-----------\n')
addpath('BM3D');

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
parameter.interval = 3;
parameter.sigma = 5;
parameter.hsize = 10;

%Graph Method
boundary = surface_detect(Bscan, parameter);
maxLayer = 2;  %overidethe parameter


%%
fprintf('--------------Determine number of layers-----------\n')

%shift Bscan
BscanShift = Bscanshift(Bscan, boundary);


[rowBscan columnBscan] = size(Bscan);


parameterLayer.th = 0.34;
parameterLayer.smPara = round(rowBscan/20);
[turningPointFinal, offsetCol] = layerEstimation(BscanShift, boundary, parameterLayer);


%%
fprintf('--------------Boundary searching-----------\n')
%weight matrix generation
parameterWM.w1 = 0.56;
parameterWM.w2 = 0.38;
[weightMatrix, startYAll, numOfLayer]  = weightGen(turningPointFinal,BscanShift, parameterWM);
   
figure(1), imagesc(weightMatrix), colormap(gray), hold on

numOfLayer = maxLayer;
%search
parameterSearch.a = 1;
parameterSearch.b = 1;
parameterSearch.deltaY = 4;
boundaryFinal = boundarySearch( weightMatrix, numOfLayer, parameterSearch, startYAll, offsetCol, Bscan);

