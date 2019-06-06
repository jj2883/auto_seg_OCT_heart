function [p res ] =  linearFitFunc_r_2( x,y, method )
% This function fits x to y linearly based on linear least square fit.
% Return the slop ut and r square value

    
   
%     xx = 1:dataLength;
%     b = inv(transpose(x)*x)*transpose(x)*y;
    p = polyfit(x, y,1);
    ut = -p(1);  %the real ut needed in paper is a positive value
   
    
    
    yEst = polyval(p,x);
    figureplot = 0;
    if figureplot == 1
    figure(10)
   % xx = 0:0.1:max(x);
    plot(x,y,'x',x,polyval(p,x))
    end
    
    if strcmp(method, 'rms')
    res = sqrt((sum((yEst - y).^2))/length(y));
    elseif strcmp(method, 'r^2')
    SS_res = sum((yEst - y).^2);
    SS_tot = sum((y - mean(y)).^2);
    res =  1 - SS_res/SS_tot;
    end


end
