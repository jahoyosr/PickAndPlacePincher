function [x,y]=PosActual(q1,q2,q3,q4)
  x=cos(q1)*(0.108*sin(q2+q3)+0.108*sin(q2));
  y=sin(q1)*(0.108*sin(q2+q3)+0.108*sin(q2));
  %z=0.108*cos(q3+q2)+0.108*cos(q2);
end