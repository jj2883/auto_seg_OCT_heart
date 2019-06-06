function [turningPointFinal, offsetCol] = layerEstimation(BscanShift, boundary, parameter)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


[rowImage columnImage] = size(BscanShift);
AlineLeftmost = smooth(mean(BscanShift(:,1:200)')');
B = cumsum(AlineLeftmost);
middle = round(columnImage/2);
ROI = BscanShift(:,middle-100+1:middle+100);
            
offsetCol = boundary-min(boundary);
boundaryRaw = boundary;
%             figure(101), 
%             subplot(2,3,1)
%             imagesc(ROI), colormap(gray)
             %%
%cut ROI to 5 segments, determine the Aline for each segments
for segID =1:5
    Aline = smooth(mean(ROI(:, (segID-1)*40+1:(segID-1)*40+20)'), parameter.smPara);   

    %detect the turning point
     
     [AlineNew, offset] = valideAline(Aline);%truncated Alin
     [numOfSeg turningPoint] = LinearDetection(AlineNew, parameter.th);                 
           
     %run set of criteria to specify boundary of layers
     turningID = [offset turningPoint+offset];  
     [numOfSeg turningID] = process_rules(Aline,numOfSeg, turningID);
     numOflayer(segID) = numOfSeg;  
     turningAll(segID, 1:length(turningID)) = turningID;
     %
%      subplot(2,3,segID+1)
%      plot(Aline)
%      hold on
%      plot(turningID, Aline(turningID),'ro' )
end
%determine the estimated numof layer and starting point

numOfRegion = median(numOflayer);
goodJudge = find(numOflayer == numOfRegion); %find all estimation that has the correct vote;
temp = turningAll(goodJudge,:);           
if size(temp,1) ~=1
   turningPointFinal = round(mean(temp));
else
   turningPointFinal=temp;
end  
turningPointFinal(find(turningPointFinal == 0)) = [];      

%subtitle(strcat(text1, ';  # of layers: ', num2str(numOfRegion), ';  starting: ', num2str(turningPointFinal)));

%%
% imagName =  [pathFigTest '\Valid_' ...
%            num2str(HeartIndex) '_Chamber_' part '_Bscan_' num2str(ii) '.jpg'];
%        print('-dtiff','-r300',imagName)
% close(101)       
numOfTissue = median(numOflayer); 

end



