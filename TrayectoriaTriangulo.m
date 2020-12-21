function TrayectoriaTriangulo(p1x,p1y,p2x,p2y)
PuntosOperacional=zeros(20,5);
PuntosArticular=zeros(4,20);

pcx=(p1x+p2x)/2;
pcy=(p1y+p2y)/2;

recx=(p1x-p2x)/2;
recy=(p1y-p2y)/2;

p3x=pcx+(-recy);
p3y=pcy+(recx);
%Punto arriba o abajo
% p4x=centrox-(-recy);
% p4y=centroy-(recx);
VectorZ=-0.04*ones(5,1);

VectorX13=linspace(p1x,p3x,5);VectorY13=linspace(p1y,p3y,5);

VectorX32=linspace(p3x,p2x,5);VectorY32=linspace(p3y,p2y,5);

VectorX2C=linspace(p2x,pcx,5);VectorY2C=linspace(p2y,pcy,5);

VectorXC1=linspace(pcx,p1x,5);VectorYC1=linspace(pcy,p1y,5);

MatrizPosiciones=[VectorX13' VectorY13' VectorZ zeros(5,1) zeros(5,1);
                  VectorX32' VectorY32' VectorZ zeros(5,1) zeros(5,1); 
                  VectorX2C' VectorY2C' VectorZ zeros(5,1) zeros(5,1);
                  VectorXC1' VectorYC1' VectorZ zeros(5,1) zeros(5,1);]
for i=1:20
    PuntosOperacional(i,1:5)=PincherCI(MatrizPosiciones(i,1),MatrizPosiciones(i,2),MatrizPosiciones(i,3),MatrizPosiciones(i,4),MatrizPosiciones(i,5));
    PuntosArticular(1:4,i)=PuntosOperacional(i,1:4)';
    if i>1
      [t,pos, vel, ace] = planificador(PuntosArticular(1:4,i-1),PuntosArticular(1:4,i));

     for i= 1:length(t)
      SyncWrite([floor(195.38*pos(i,1)+512) floor(195.38*pos(i,2)+512) floor(195.38*pos(i,3)+512) floor(195.38*pos(i,4)+512) 180]) ;%%170 cierre gripper
      SyncWriteVel([floor(abs(vel(i,1)*1023/11.93805207)) floor(abs(vel(i,2)*1023/11.93805207)) floor(abs(vel(i,3)*1023/11.93805207)) floor(abs(vel(i,4)*1023/11.93805207))]);
      %SyncWriteVel([50 50 50 50]);
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
      %SyncWriteVel([50 50 50 50]);
      pause(0.05);
     end
   end
end
