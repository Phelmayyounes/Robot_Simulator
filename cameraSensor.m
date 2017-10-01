function [detectedPoint1, detectedPoint2,virtualCenter] = cameraSensor (path, position, orientation)
  ##path should be a matrix like [x1,y1 ; x2,y1 ; ...]
  
  
  %hold;
  %plot(position(1,1),position(1,2),'x-r');
  
  measuringDistance = 300;
  gradArcTolerance = 7;
 
  desiredAngle1 = atan2(sin(orientation + pi/2), cos(orientation + pi/2));
  desiredAngle2 = atan2(sin(orientation - pi/2), cos(orientation - pi/2));
  
  virtualCenter = position + [measuringDistance*cos(orientation), measuringDistance*sin(orientation)];
  
  %plot(virtualCenter(1,1),virtualCenter(1,2),'x-b');
  
  tempDifferences = (path.-virtualCenter);
  angles = atan2(tempDifferences(:,2),tempDifferences(:,1));
  
 
  
  %{
  possiblePoints1 = [0,0];
  possiblePoints2 = [0,0];
  arcAngles1(1) = 0.0;
  arcAngles2(1) = 0.0;
  %}
  %{
  ##how to vectorize this?
  for i = 1:size(angles,1)
  #angles(i) - desiredAngle1
    if(abs(angles(i) - desiredAngle1) < 7*pi/180) 
      possiblePoints1 =  [possiblePoints1; path(i,:)];
      arcAngles1 = [arcAngles1, angles(i)];
    endif
    if(abs(angles(i) - desiredAngle2) < 7*pi/180) 
      possiblePoints2 =  [possiblePoints2; path(i,:)];
      arcAngles2 = [arcAngles2, angles(i)];
    endif
  endfor
  %}
 
  #Improvement for a vectorized way
  
  testAngles1 = -abs(angles - desiredAngle1) + gradArcTolerance*pi/180;
  possiblePoints1 = testAngles1>=0; #Here possiblePoints1 is an array of 1 and 0
  [tempPoints, tempPosition] = sort(possiblePoints1,"descend");
      #tempPoints = 1 if its a possible point, otherwise its cero. tempPoints its not relevant indeed.
      #tempPosition = index number in testAngles1 for the allocation of each possible point.
      #size(possiblePoints1)
      #sum(possiblePoints1)
      #size(angles)
  totalPoints = sum(possiblePoints1);
  tempPosition = tempPosition(1:totalPoints);
  possiblePoints1 = path(tempPosition,:);
      #We just turned possiblePoints1 into a smaller array of relevant points in the path 
  arcAngles1 =  angles(tempPosition);
  
  
  testAngles2 = -abs(angles - desiredAngle2) + gradArcTolerance*pi/180;
  possiblePoints2 = testAngles2>=0;
  [tempPoints, tempPosition] = sort(possiblePoints2,"descend");
 
  totalPoints = sum(possiblePoints2);
  tempPosition = tempPosition(1:totalPoints);
  possiblePoints2 = path(tempPosition,:); 
  arcAngles2 =  angles(tempPosition);
  #This should work as the for loop but in a better/vectorized way
  
  
 
  %{
  possiblePoints1 = [possiblePoints1(2:end,1) , possiblePoints1(2:end,2)];
  arcAngles1 = arcAngles1(2:end);
  %}
  
 
  %plot(possiblePoints1(:,1),possiblePoints1(:,2),'o-g');
 
  %{ 
  possiblePoints2 = [possiblePoints2(2:end,1) , possiblePoints2(2:end,2)];
  arcAngles2 = arcAngles2(2:end);
  %}
  
  %plot(possiblePoints2(:,1),possiblePoints2(:,2),'o-g'); 
 
  #pointsSize1 = size(createLine(),2);  
  #pointsSize2 = size(createLine(),2);

  #possiblePoints1 = [possiblePoints1, possiblePoints1(:,1)*possiblePoints1(:,1) +  possiblePoints1(:,2)*possiblePoints1(:,2) ];
  #fixIt
  #the possible points have to be related to a vector of distances. 
  
  distances1 = (possiblePoints1(:,1)-virtualCenter(1,1)).^2 .+  (possiblePoints1(:,2)-virtualCenter(1,2)).^2;
  distances2 = (possiblePoints2(:,1)-virtualCenter(1,1)).^2 .+  (possiblePoints2(:,2)-virtualCenter(1,2)).^2;
 
  [distances1, indices1] = sort(distances1); 
  [distances2, indices2] = sort(distances2); 
  
  pointsSize1 = 20;
  pointsSize2 = 20; 
   
  if (pointsSize1 > size(distances1, 1) ) 
    pointsSize1 = round(size(distances1,1));
  endif
 
 
  if (pointsSize2 > size(distances2, 1) ) 
    pointsSize2 = round(size(distances2,1));
  endif
  
  #size(indices1)
  #size(arcAngles1)
  closestPoints1 = possiblePoints1(indices1(1:pointsSize1), :);
  arcAngles1 = arcAngles1(indices1(1:pointsSize1));
  
  closestPoints2 = possiblePoints2(indices2(1:pointsSize2), :);
  arcAngles2 = arcAngles2(indices2(1:pointsSize2));
  
  arcAngles1 = abs(arcAngles1'-desiredAngle1);
  arcAngles2 = abs(arcAngles2'-desiredAngle2);
  
  [arcAngles1, indices1] = sort(arcAngles1);
  [arcAngles2, indices2] = sort(arcAngles2);
  
  
  detectedPoint1 = closestPoints1(indices1(1),:);
  detectedPoint2 = closestPoints2(indices2(1),:);
    
  
  %plot(closestPoints1(:,1),closestPoints1(:,2),'o-y','markersize',5);
  %plot(closestPoints2(:,1),closestPoints2(:,2),'o-y','markersize',5);
  %hold on; 
  %plot(detectedPoint1(1,1), detectedPoint1(1,2),'o-r',"markersize",10);
  %plot(detectedPoint2(1,1), detectedPoint2(1,2),'o-r',"markersize",10);
  
  
 endfunction
