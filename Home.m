function Home()
  init
  torqLimits=[750 750 750 750 500]; %L�mite de torque para cada motor
  limitTorque(torqLimits);    
  vLimits=[60 60 60 60 60]; %L�mite de torque para cada motor
  limitVelocidad(vLimits);
  SyncWrite([512 512 512 512 512]);
  terminate
end