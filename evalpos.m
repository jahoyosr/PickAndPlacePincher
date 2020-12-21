% EVALPOS Funcion que evalua el polinomio de la funcion de posición de
% acuerdo al caso y al tiempo.
% POS=EVALPOS(T,TT,CASO,A) evalúa el polinomio de aceleración.
% A matriz 5x3 que contiene los coeficientes de los polinomios interpolados.
% T vector tiempo normalizado.
% TT segmentos de tiempo de aceleración, velocidad máxima y deceleración.
% caso=1: Cada motor logra alcanzar su velocidad maxima.
% caso=2: No hay tiempo de alcanzar la velocidad maxima de cada motor.
%
% Ver también PLANIFICADOR, CALCULOCOEF, SINCRONIZADOR, EVALVEL, EVALACEL.
function pos = evalpos(t,tt,caso,A)
for i = 1:length(t)
if caso == 1
if (t(i) <= 0)
p = A(1,1);
elseif (t(i)>0)&(t(i)<=tt(1))
ti = t(i)/tt(1);
p = A(1,1)+ A(1,2)*ti+ A(1,3)*ti^2+A(1,4)*ti^3+A(1,5)*ti^4;
elseif (t(i)>tt(1))&(t(i)<=tt(2)+tt(1))
ti = (t(i)-tt(1))/tt(2);
p = A(2,1)+A(2,2)*ti;
elseif (t(i)>tt(2)+tt(1))&(t(i)<=tt(3)+tt(2)+tt(1))
ti = (t(i)-tt(2)-tt(1))/tt(3);
p = A(3,1)+A(3,2)*(ti-1)+A(3,3)*(ti-1).^2+A(3,4)*(ti-1).^3+A(3,5)*(ti-1).^4;
elseif (t(i)>tt(3)+tt(2)+tt(1))
p = A(3,1);
end;
elseif caso==2
if (t(i) <= 0)
p = A(1,1);
elseif (t(i)>0)&(t(i)<=tt(1))
ti = t(i)/tt(1);
p = A(1,1)+ A(1,2)*ti+ A(1,3)*ti^2+A(1,4)*ti^3+A(1,5)*ti^4;
elseif (t(i)>tt(1))&(t(i)<=tt(2)+tt(1))
ti = (t(i)-tt(1))/tt(2);
p = A(2,1)+A(2,2)*(ti-1)+A(2,3)*(ti-1).^2+A(2,4)*(ti-1).^3+A(2,5)*(ti-1).^4;
elseif (t(i)>tt(2)+tt(1))
p = A(2,1);
end;
end;
pos(i)=p;
end;
return