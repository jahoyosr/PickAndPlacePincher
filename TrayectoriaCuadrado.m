function TrayectoriaCuadrado(p1x,p1y,p2x,p2y)
PuntosOperacional=zeros(20,5);
PuntosArticular=zeros(4,20);

centrox=(p1x+p2x)/2;
centroy=(p1y+p2y)/2;

recx=(p1x-p2x)/2;
recy=(p1y-p2y)/2;

p3x=centrox+(-recy);
p3y=centroy+(recx);

p4x=centrox-(-recy);
p4y=centroy-(recx);
VectorZ=-0.04*ones(5,1);
VectorX13=linspace(p1x,p3x,5);VectorY13=linspace(p1y,p3y,5);

VectorX32=linspace(p3x,p2x,5);VectorY32=linspace(p3y,p2y,5);

VectorX24=linspace(p2x,p4x,5);VectorY24=linspace(p2y,p4y,5);

VectorX41=linspace(p4x,p1x,5);VectorY41=linspace(p4y,p1y,5);

MatrizPosiciones=[VectorX13' VectorY13' VectorZ zeros(5,1) zeros(5,1);
                  VectorX32' VectorY32' VectorZ zeros(5,1) zeros(5,1); 
                  VectorX24' VectorY24' VectorZ zeros(5,1) zeros(5,1);
                  VectorX41' VectorY41' VectorZ zeros(5,1) zeros(5,1);];
for i=1:20
    PuntosOperacional(i,1:5)=PincherCI(MatrizPosiciones(i,1),MatrizPosiciones(i,2),MatrizPosiciones(i,3),MatrizPosiciones(i,4),MatrizPosiciones(i,5))
    PuntosArticular(1:4,i)=PuntosOperacional(i,1:4)';
    if i>1
      [t,pos, vel, ace] = planificador(PuntosArticular(1:4,i-1),PuntosArticular(1:4,i));

     for i= 1:length(t)
      SyncWrite([floor(195.38*pos(i,1)+512) floor(195.38*pos(i,2)+512) floor(195.38*pos(i,3)+512) floor(195.38*pos(i,4)+512) 180]) ;%%170 cierre gripper
      SyncWriteVel([floor(abs(vel(i,1)*1023/11.93805207)) floor(abs(vel(i,2)*1023/11.93805207)) floor(abs(vel(i,3)*1023/11.93805207)) floor(abs(vel(i,4)*1023/11.93805207))]);
      pause(0.05);
     end
     %pause(0.3);
   end
   
end
 if i==20
       [t,pos, vel, ace] = planificador(PuntosArticular(1:4,i),PuntosArticular(1:4,1));

     for i= 1:length(t)
      SyncWrite([floor(195.38*pos(i,1)+512) floor(195.38*pos(i,2)+512) floor(195.38*pos(i,3)+512) floor(195.38*pos(i,4)+512) 180]) ;%%170 cierre gripper
      SyncWriteVel([floor(abs(vel(i,1)*1023/11.93805207)) floor(abs(vel(i,2)*1023/11.93805207)) floor(abs(vel(i,3)*1023/11.93805207)) floor(abs(vel(i,4)*1023/11.93805207))]);
      pause(0.05);
     end
   end
end
% %%Cuadrado pruebas
%  p1=PincherCI(p1x,p1y,-0.04,0,0);
%  p2=PincherCI(p2x,p2y,-0.04,0,0);
%  p3=PincherCI(p3x,p3y,-0.04,0,0);
%  p4=PincherCI(p4x,p4y,-0.04,0,0);  
% 
% q1=p1(1,1:4)';
% q2=p2(1,1:4)';
% q3=p3(1,1:4)';
% q4=p4(1,1:4)';
% %--------------------------------------------------------
% % Llamada a la función PLANIFICADOR
% %---------------------------------------------------------------------
% [t,pos, vel, ace] = planificador(q1,q3);
% 
%  for i= 1:length(t)
%      SyncWrite([floor(195.38*pos(i,1)+512) floor(195.38*pos(i,2)+512) floor(195.38*pos(i,3)+512) floor(195.38*pos(i,4)+512) 500]) ;%%170 cierre gripper
%      SyncWriteVel([floor(abs(vel(i,1)*1023/11.93805207)) floor(abs(vel(i,2)*1023/11.93805207)) floor(abs(vel(i,3)*1023/11.93805207)) floor(abs(vel(i,4)*1023/11.93805207))]);
%      pause(0.05);
%  end
%  pause(1);
%  [t,pos, vel, ace] = planificador(q3,q2);
%   for i= 1:length(t)
%      SyncWrite([floor(195.38*pos(i,1)+512) floor(195.38*pos(i,2)+512) floor(195.38*pos(i,3)+512) floor(195.38*pos(i,4)+512) 500]) ;%%170 cierre gripper
%      SyncWriteVel([floor(abs(vel(i,1)*1023/11.93805207)) floor(abs(vel(i,2)*1023/11.93805207)) floor(abs(vel(i,3)*1023/11.93805207)) floor(abs(vel(i,4)*1023/11.93805207))]);
%      pause(0.05);
%  end
% pause(1);
%   [t,pos, vel, ace] = planificador(q2,q4);
%   for i= 1:length(t)
%      SyncWrite([floor(195.38*pos(i,1)+512) floor(195.38*pos(i,2)+512) floor(195.38*pos(i,3)+512) floor(195.38*pos(i,4)+512) 500]) ;%%170 cierre gripper
%      SyncWriteVel([floor(abs(vel(i,1)*1023/11.93805207)) floor(abs(vel(i,2)*1023/11.93805207)) floor(abs(vel(i,3)*1023/11.93805207)) floor(abs(vel(i,4)*1023/11.93805207))]);
%      pause(0.05);
%   end
%  pause(1);
%    [t,pos, vel, ace] = planificador(q4,q1);
%   for i= 1:length(t)
%      SyncWrite([floor(195.38*pos(i,1)+512) floor(195.38*pos(i,2)+512) floor(195.38*pos(i,3)+512) floor(195.38*pos(i,4)+512) 500]) ;%%170 cierre gripper
%      SyncWriteVel([floor(abs(vel(i,1)*1023/11.93805207)) floor(abs(vel(i,2)*1023/11.93805207)) floor(abs(vel(i,3)*1023/11.93805207)) floor(abs(vel(i,4)*1023/11.93805207))]);
%      pause(0.05);
%  end
%end