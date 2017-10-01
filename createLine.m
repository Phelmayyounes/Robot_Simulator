function [dotsX, dotsY] = createLine( x0, y0, x1, y1 )

  dx = x1 - x0; 
  dy = y1 - y0;
  
  if(abs(dx) > abs(dy)) 
    steps = abs(dx);
  else
    steps = abs(dy);
  endif
  
  xIncrement = dx/(steps);
  yIncrement = dy/(steps);
  
  dotsX(1) = x0;
  dotsY(1) = y0; 
  
  currentX = x0;
  currentY = y0;
  
  position = 1;
  
  for i = 2:(steps);
    
    currentX = currentX + xIncrement;
    currentY = currentY + yIncrement;
    if( (round(currentX) != dotsX(position))  ) #or operator was giving error of division by cero
        
        position++;
        dotsX(position) = round(currentX);
        dotsY(position) = round(currentY);
        
    elseif(round(currentY) != dotsY(position))
        position++;
        dotsX(position) = round(currentX);
        dotsY(position) = round(currentY);
    
    endif
    
    if(position != 1) 
      if(dotsX(position) - dotsX(position-1) > 1) #or operator was giving error of division by cero
         printf("error: isolated points were found"); 
       elseif(dotsY(position) - dotsY(position-1) > 1)
         printf("error: isolated points were found"); 
      endif
    endif
  endfor
  
endfunction
