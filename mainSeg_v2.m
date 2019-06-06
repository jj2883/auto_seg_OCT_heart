%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%v2: add maximum number of layers to overlay the parameter
 %close all, clc, clear;
tic

%%
%image import
%Bscan2 = imread('14_1_1_105_d1137.tif');
Bscan1 = double(imread('Fig.tif'));

%%
fprintf('--------------imagefiltering-----------\n')
addpath('BM3D');

%im_std = std2(Bscan1);
Bscan = BM3D_filtering(Bscan1).*255;
%      [PSNR, y_est] = BM3D(y, z, sigma);

%%       
fprintf('--------------Detecting the surface-----------\n')
parameter.interval = 3;
parameter.sigma = 5;
parameter.hsize = 10;
boundary = surface_detect(Bscan, parameter);
maxLayer = 2;  %overidethe parameter
%
fprintf('--------------Determine number of layers-----------\n')

%shift Bscan
BscanShift = Bscanshift(Bscan, boundary);
parameterLayer.th = 0.34;
parameterLayer.smPara = 15;
[turningPointFinal, offsetCol] = layerEstimation(BscanShift, boundary, parameterLayer);
%
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

