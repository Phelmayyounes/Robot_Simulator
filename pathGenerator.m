function [pathX, pathY] = pathGenerator 

  pathWidth = 450; 
  
  #Fist segment
  [pathLeftX, pathLeftY] = createLine(0,0,1000,1000);
  lastAngle =  atan2(pathLeftY(size(pathLeftY,2))-pathLeftY(size(pathLeftY,2)-1) , pathLeftX(size(pathLeftX,2))-pathLeftX(size(pathLeftX,2)-1));
  [pathRightX, pathRightY] = createLine(pathLeftX(1) + round(pathWidth*cos(lastAngle-pi/2)), pathLeftY(1) + round(pathWidth*sin(lastAngle-pi/2)), pathLeftX(size(pathLeftX,2)) + round(pathWidth*cos(lastAngle-pi/2)), pathLeftY(size(pathLeftY,2)) + round(pathWidth*sin(lastAngle-pi/2)));  
  
  #Second Segment
  [tempPathLeftX, tempPathLeftY] = arcGenerator(pathLeftX(size(pathLeftX,2)),pathLeftY(size(pathLeftY,2)),500,pi,lastAngle,-1);
  [tempPathRightX, tempPathRightY] = arcGenerator(pathRightX(size(pathRightX,2)),pathRightY(size(pathRightY,2)),500-pathWidth,pi,lastAngle,-1);
  
  pathLeftX = [pathLeftX, tempPathLeftX(2:size(tempPathLeftX,2))];
  pathLeftY = [pathLeftY, tempPathLeftY(2:size(tempPathLeftY,2))];
  
  pathRightX = [pathRightX, tempPathRightX(2:size(tempPathRightX,2))];
  pathRightY = [pathRightY, tempPathRightY(2:size(tempPathRightY,2))];
  
  #Third Segment
  [tempPathLeftX, tempPathLeftY] = createLine(pathLeftX(size(pathLeftX,2)),pathLeftY(size(pathLeftY,2)), pathLeftX(size(pathLeftX,2)) - 2000, pathLeftY(size(pathLeftY,2)) - 2000 );
  pathLeftX = [pathLeftX, tempPathLeftX(2:size(tempPathLeftX,2))];
  pathLeftY = [pathLeftY, tempPathLeftY(2:size(tempPathLeftY,2))];
  
  lastAngle =  atan2(pathLeftY(size(pathLeftY,2))-pathLeftY(size(pathLeftY,2)-1) , pathLeftX(size(pathLeftX,2))-pathLeftX(size(pathLeftX,2)-1));
  
  [tempPathRightX, tempPathRightY] = createLine(pathRightX(size(pathRightX,2)),  pathRightY(size(pathRightY,2)),    tempPathLeftX(size(tempPathLeftX,2)) + round(pathWidth*cos(lastAngle-pi/2)), tempPathLeftY(size(tempPathLeftY,2)) + round(pathWidth*sin(lastAngle-pi/2)));  
  
  pathRightX = [pathRightX, tempPathRightX(2:size(tempPathRightX,2))];
  pathRightY = [pathRightY, tempPathRightY(2:size(tempPathRightY,2))];
  
  
  #Fourth Segment
  [tempPathLeftX, tempPathLeftY] = arcGenerator(pathLeftX(size(pathLeftX,2)),pathLeftY(size(pathLeftY,2)),500,pi,lastAngle,-1);
  [tempPathRightX, tempPathRightY] = arcGenerator(pathRightX(size(pathRightX,2)),pathRightY(size(pathRightY,2)),500-pathWidth,pi,lastAngle,-1);
  
  pathLeftX = [pathLeftX, tempPathLeftX(2:size(tempPathLeftX,2))];
  pathLeftY = [pathLeftY, tempPathLeftY(2:size(tempPathLeftY,2))];
  
  pathRightX = [pathRightX, tempPathRightX(2:size(tempPathRightX,2))];
  pathRightY = [pathRightY, tempPathRightY(2:size(tempPathRightY,2))];
  
  
  #Fifth Segment
  [tempPathLeftX, tempPathLeftY] = createLine(pathLeftX(size(pathLeftX,2)),pathLeftY(size(pathLeftY,2)), pathLeftX(1), pathLeftY(1) );
  pathLeftX = [pathLeftX, tempPathLeftX(2:size(tempPathLeftX,2)-1)];
  pathLeftY = [pathLeftY, tempPathLeftY(2:size(tempPathLeftY,2)-1)];
  
  lastAngle =  atan2(pathLeftY(size(pathLeftY,2))-pathLeftY(size(pathLeftY,2)-1) , pathLeftX(size(pathLeftX,2))-pathLeftX(size(pathLeftX,2)-1));
  
  [tempPathRightX, tempPathRightY] = createLine(pathRightX(size(pathRightX,2)),  pathRightY(size(pathRightY,2)),  pathRightX(1), pathRightY(1)   );  
  
  pathRightX = [pathRightX, tempPathRightX(2:size(tempPathRightX,2)-1)];
  pathRightY = [pathRightY, tempPathRightY(2:size(tempPathRightY,2)-1)];
  
  pathX = [pathLeftX, pathRightX]';
  pathY = [pathLeftY, pathRightY]';

  
  
  endfunction
