init
  torqLimits=[600 1023 600 600 800]; %Límite de torque para cada motor
  limitTorque(torqLimits);  
  
  vLimits=[20 20 20 20 20]; %Límite de torque para cada motor
  limitVelocidad(vLimits);
  q=zeros(1,5);
  q=PincherCI(0.2,0.18,-0.02,0,0)
  
SyncWrite([floor(195.38*q(1,1)+512) floor(195.38*q(1,2)+512) floor(195.38*q(1,3)+512) floor(195.38*q(1,4)+512) 200])%%170 cierre gripper