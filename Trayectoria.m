%----------------------------------------------------------
%----programa de prueba del software de planificación -----
%----interpolación 4-3-4 -----
%----------------------------------------------------------
clear
%---------------------------------------------------------------------
% q1 y q2 son las coordenadas articulares inicial y final
%---------------------------------------------------------------------
  init
  torqLimits=[600 1023 600 600 800]; %L�mite de torque para cada motor
  limitTorque(torqLimits);  
  
  vLimits=[60 60 60 60 60]; %L�mite de torque para cada motor
  limitVelocidad(vLimits);
  %%
  TrayectoriaCuadrado(0.140,0.14,0.20,0.2);
 %%
  TrayectoriaCirculo(0.04,0.24,0)
 
 %%
  TrayectoriaTriangulo(0.150,0.151,0.20,0.22);
