Aline = AlineNew;
r2Th= parameter.th;
%get the number of piecewised linear function and the turning point
%input: Aline
%         rmsTh: threshold for determining an fair estimation
%output: numOfSeg, turning point (along axial axis)
rowNum = length(Aline);
anchor = 1;
turningPoint = [];
searchWValue = 10;

searchW = searchWValue;
%transW = 10; %transW: skip strong variation between end of first band and start of next band
transW = 10;
winStep = 3;
numOfSeg = 0;
while 1 % search to the end of Aline
              searchData = Aline(anchor:anchor + searchW - 1);
              x = (1:length(searchData))';
              
              method = 'rms';
              [p res ] =  linearFitFunc_r_2( x,searchData, method);
              if res < r2Th  %if this rms is small, forward the searching window
                   searchW = searchW + winStep;
              else %this rms is large and the fit should stop, record the turning point
               
                  numOfSeg = numOfSeg + 1;
                  turningPoint(numOfSeg) = anchor + searchW - winStep - 1;
                  anchor =  turningPoint(numOfSeg) + transW;   %set new anchor
                  pCoef(numOfSeg, :) = p;
                  searchW = searchWValue;
                 
              end
           if anchor > rowNum || anchor + searchW > rowNum

                  break 
           end


end
numOfSeg = numOfSeg + 1;
pCoef(numOfSeg, :) = p;
turningPoint(numOfSeg) = rowNum;
