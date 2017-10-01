function [wheelVels] = controlModel (detectedPoints, virtualCenter)
  
  
  
  d1 = norm([detectedPoints(1),detectedPoints(2)] - virtualCenter);
  d2 = norm([detectedPoints(3),detectedPoints(4)] - virtualCenter);
  
  error = 1*(d1-d2);
  %if d1 > d2 >> error > 0 >> turn left
  %if di < d2 >> error < 0 >> turn right
  
  wheelVels(1) = 0.5 + 0.000005*error; %leftWheel 
  wheelVels(2) = 0.5 - 0.000005*error; %rightWheel
  
  
  
  
endfunction 
