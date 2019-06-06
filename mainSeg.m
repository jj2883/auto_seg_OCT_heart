close all, clc, clear;
tic

%%
%image import

Bscan = double(imread('Fig.tif'));

%%
fprintf('--------------imagefiltering-----------\n')
addpath('BM3D');
Bscan = BM3D_filtering(Bscan).*255;

%%       
fprintf('--------------Detecting the surface-----------\n')
parameter.interval = 3;
parameter.sigma = 5;
parameter.hsize = 10;
boundary = surface_detect(Bscan, parameter);
            
        
%%
fprintf('--------------Determine number of layers-----------\n')

%shift Bscan
BscanShift = Bscanshift(Bscan, boundary);
parameterLayer.th = 0.34;
parameterLayer.smPara = 15;
[turningPointFinal, offsetCol] = layerEstimation(BscanShift, boundary, parameterLayer);
%%
fprintf('--------------Boundary searching-----------\n')
%weight matrix generation
parameterWM.w1 = 0.56;
parameterWM.w2 = 0.38;
[weightMatrix, startYAll, numOfLayer]  = weightGen(turningPointFinal,BscanShift, parameterWM);
   
figure(1), imagesc(weightMatrix), colormap(gray), hold on
%search
parameterSearch.a = 1;
parameterSearch.b = 1;
parameterSearch.deltaY = 4;
boundaryFinal = boundarySearch( weightMatrix, numOfLayer, parameterSearch, startYAll, offsetCol, Bscan);

