%for dont doing the following better call "createPath"
[path(:,1),path(:,2)] = pathGenerator();

position = [-800,-1000];
orientation = pi/4;


plot(path(:,1),path(:,2));
hold on;
oldState =[position(1);position(2);orientation];



for i=1:60
  [detectedPoints1, detectedPoints2, virtualCenter] = cameraSensor(path, [oldState(1),oldState(2)], oldState(3));
  plot(oldState(1),oldState(2),'o-g');
  plot(detectedPoints1(1),detectedPoints1(2),'o-p');
  plot(detectedPoints2(1),detectedPoints2(2),'o-p');
  plot(virtualCenter(1),virtualCenter(2),'o-r');
  detectedPoints = [detectedPoints1, detectedPoints2];
  wheelVels = controlModel(detectedPoints, virtualCenter);
  newState = kinematicModel(oldState, wheelVels, 10);
  oldState = newState;
endfor

