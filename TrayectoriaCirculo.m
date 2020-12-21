function TrayectoriaCirculo(r,centrox,centroy)
PuntosOperacional=zeros(30,5);
PuntosArticular=zeros(4,30);
for i=1:30
    x=r*cos(i*12*pi/180)+centrox;
    y=r*sin(i*12*pi/180)+centroy;
    PuntosOperacional(i,1:5)=PincherCI(x,y,-0.04,0,0);
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
 if i==30
       [t,pos, vel, ace] = planificador(PuntosArticular(1:4,i),PuntosArticular(1:4,1));

     for i= 1:length(t)
      SyncWrite([floor(195.38*pos(i,1)+512) floor(195.38*pos(i,2)+512) floor(195.38*pos(i,3)+512) floor(195.38*pos(i,4)+512) 180]) ;%%170 cierre gripper
      SyncWriteVel([floor(abs(vel(i,1)*1023/11.93805207)) floor(abs(vel(i,2)*1023/11.93805207)) floor(abs(vel(i,3)*1023/11.93805207)) floor(abs(vel(i,4)*1023/11.93805207))]);
      pause(0.05);
     end
   end

end