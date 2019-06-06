
%can fix this parameter
noise2peak = 30; %suppose the noise is 50 pixels before the peak
noisewidth = 10; 
num = length(Aline);

difAline = diff(Aline);
[value IDstart] = max(Aline);
[jumpvalue jumpID] = max(difAline);

noiseend = max(1, jumpID-noise2peak);
noisestart = max(1, noiseend-noisewidth);

if noiseend ~= noisestart
    noisSeg = Aline(noisestart:noiseend);
else
    noisSeg = Aline(end-50:end);
end
fprintf('jump at  = %d, noise level = %d \n', jumpID, mean(noisSeg));


noiseValue = mean(noisSeg).*1.05 + std(noisSeg).*4;  %times 1.05 in case the length of noise equal to 1
noiseID = find(Aline<noiseValue);
IDsearch = find(noiseID>IDstart);

if isempty(IDsearch) == 1
   IDend = num;
else
    IDend = noiseID(IDsearch(1));
end
AlineNew = Aline(IDstart:IDend);
offset = IDstart-1;

% if length(AlineNew) < 10;
%     AlineNew = Aline;
% end


