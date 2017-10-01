function [newState] = kinematicModel(oldState, wheelVels, dt)
  #oldState(1):  x position respect to inertial frame
  #oldState(2):  y position respect to inertial frame
  #oldState(3):  orientation respect to inertial frame
  #wheelVels(1):  d(ThetaRightWheel)/dt (positive if makes the robot go forward)
  #wheelVels(2):  d(ThetaLeftWheel)/dt (positive if makes the robot go forward)
  #dt: time step 
  
  
  R = 50; %wheel radious 
  L = 100; %distante between wheels along their axes 
  oldState(3) = atan2(sin(oldState(3)),cos(oldState(3)));
  
  v = R/2*(wheelVels(1) + wheelVels(2))/2;
  w = R/2*(wheelVels(1) - wheelVels(2))/2;
  
  
  theta = oldState(3);
  transformationMatrix = [cos(theta),0;sin(theta),0;0,1];
  
  #xVel, yVel and thetaVel are defined respect to the inertial frame
  stateVector =[v;w]; 
  
  stateDerivative = (transformationMatrix*stateVector);
  
  newState = oldState + [stateDerivative(1); stateDerivative(2); stateDerivative(3)]*dt;
  newState(3) = atan2(sin(newState(3)), cos(newState(3)));
 
 
 endfunction
