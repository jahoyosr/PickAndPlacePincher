function Q=PincherCI(x,y,z,theta,gripper)
% longitudes del pincher
% longitudes del pincher
L1=0.14;L2=0.106;L3=0.106;L4=0.108;

r=sqrt(x^2 + y^2);
Q1=atan2(y,x);                          % hallamos Q1

rw=r-L4*cos(theta);
zw=z-L4*sin(theta);

p=sqrt(rw^2 + zw^2);
alpha=atan2(zw,rw);

c3=(p^2 - L2^2 - L3^2)/(2*L2*L3);

s3=sqrt(1- c3^2);

Q3=atan2(s3,c3);                        % hallamos Q3

sB=L3*s3/p; %seno de Betha

cB=sqrt(1- sB^2); %coseno de Betha
B=atan2(sB,cB);
q2=B+alpha;  
Q2=pi/2-q2;                             % hallamos Q2
Q4=pi/2 - theta-Q2-Q3;                  % hallamos Q4;
Q5=gripper;
                
Q=[Q1 Q2 Q3 Q4 Q5];  %se envia el arreglo con los valores de las articualciones    
end