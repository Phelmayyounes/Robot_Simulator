function [dotsX, dotsY] = arcGenerator(x0, y0, r, theta, thetaCero, direction)
  
  angleIncrement = 0.001;
  
  dotsX(1) = x0 ;
  dotsY(1) = y0 ; 
  
  arcEndPointsX(1) = x0;
  arcEndPointsY(1) = y0;
 
  betaCero = thetaCero + pi/2*direction;
  xCenter = x0 + r*cos(betaCero);
  yCenter = y0 + r*sin(betaCero);
  
  interpolationAngle = atan2(y0-yCenter, x0-xCenter);
  initialAngle = interpolationAngle;
  
  angleCounter = 2;
  angleCounterMax =  round(theta/angleIncrement) + 1;
  
  while(angleCounter <= angleCounterMax) 
    interpolationAngle = interpolationAngle + angleIncrement*direction;
    
    if(abs(interpolationAngle-initialAngle) > theta)
      interpolationAngle = theta*direction + initialAngle;
      arcEndPointsX(angleCounter) = round(xCenter + r*cos(interpolationAngle));
      arcEndPointsY(angleCounter) = round(yCenter + r*sin(interpolationAngle));
      break;
    endif
    
    arcEndPointsX(angleCounter) = round(xCenter + r*cos(interpolationAngle));
    arcEndPointsY(angleCounter) = round(yCenter + r*sin(interpolationAngle));
    
    angleCounter = angleCounter + 1;
    
    #if(angleCounter > 75) 
      #printf("Error ending the arc")
      #break;
    #endif
    
    
   endwhile
   
   for i = i:size(arcEndPointsX,2)-1
    [tempDotsX, tempDotsY] = createLine(dotsX(size(dotsX,2)), dotsY(size(dotsY,2)), arcEndPointsX(i+1), arcEndPointsY(i+1));
    dotsX = [dotsX, tempDotsX];
    dotsY = [dotsY, tempDotsY];
   endfor
   
 endfunction
