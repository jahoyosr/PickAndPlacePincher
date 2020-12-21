function poseRobot(pos) 
%plotPos=pos*pi/180;
%figure(1);
%Robot.plot(plotPos) %Diversas rotaciones
%init %Iniciar conexión con los motores 
%torqLimits=[450 450 300 250 150]; %Límite de torque para cada motor 
%limitTorque(torqLimits); 
setPosition(pos); %Establecer la pose deseada del robot 
%terminate %Finalizar conexión con los motores 
end
