function poseRobot(pos) 
%plotPos=pos*pi/180;
%figure(1);
%Robot.plot(plotPos) %Diversas rotaciones
%init %Iniciar conexi�n con los motores 
%torqLimits=[450 450 300 250 150]; %L�mite de torque para cada motor 
%limitTorque(torqLimits); 
setPosition(pos); %Establecer la pose deseada del robot 
%terminate %Finalizar conexi�n con los motores 
end
