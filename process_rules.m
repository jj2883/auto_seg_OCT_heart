function [numOfSegNew turningPointNew] = process_rules(Aline, numOfSeg, turningPoint)
%set rules to further regulate the layer structure 
%1. only one layer beyond 0.707*peak
%2. add one more point at the first jump
%3. merge the layer that is closer than 20 pixel in dark side.

%%criteria 1: 
maxAline = max(Aline);
turnPointValue = Aline(turningPoint);
[largeId largeVal] = find(turnPointValue > maxAline*0.78);

if length(largeId)>1
   numOfSeg = numOfSeg - length(largeId) + 1;
   turningPoint(1:length(largeId)-1) = [];
end
%criteria 2: add one more point at the first jump
difAline = diff(Aline);
[jumpvalue jumpID] = max(difAline);

turningPoint(2:length(turningPoint)+1) = turningPoint;
turningPoint(1) = jumpID;
numOfSeg = numOfSeg + 1;
%criteria 3:
mergth = 30;
dist = diff(turningPoint);
[mergCandidateID] = find(dist<mergth);

numOfmerg = length(mergCandidateID);

while numOfmerg > 0
    mergID1 = mergCandidateID(1);
    mergID2 = mergCandidateID(1) + 1;
    %set new turningPoint 
    
    turningPoint(mergID1) = round((turningPoint(mergID1)+turningPoint(mergID2))/2);
    %delet one turningPoint
    turningPoint(mergID2) = [];
    numOfSeg = numOfSeg - 1;
    if numOfSeg == 1
       break 
    end
    
    
    dist = diff(turningPoint);
    [mergCandidateID] = find(dist<mergth);
    numOfmerg = length(mergCandidateID);
    
end



numOfSegNew = numOfSeg;
turningPointNew = turningPoint;