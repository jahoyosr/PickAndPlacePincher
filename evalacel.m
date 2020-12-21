%	EVALACEL funcion que evalua el polinomio de la funcion de aceleracion de
%	acuerdo al caso y al tiempo.
%		ACE=EVALACEL(T,TT,CASO,A) evalúa el polinomio de aceleración.
%		A matriz 5x3 que contiene los coeficientes de los polinomios interpolados.
%		T vector tiempo normalizado.
%		TT segmentos de tiempo de aceleración, velocidad máxima y deceleración.
%		caso=1: Cada motor logra alcanzar su velocidad maxima.
%		caso=2: No hay tiempo de alcanzar la velocidad maxima de cada motor.
%
%		Ver también PLANIFICADOR, CALCULOCOEF, SINCRONIZADOR, EVALPOS, EVALVEL.

function ace = evalacel(t,tt,caso,A)

for i = 1:length(t)

if caso == 1
  if (t(i) <= 0)
     a = 0;
  elseif (t(i)>0)&(t(i)<=tt(1))
    ti = t(i)/tt(1);
     a = (2*A(1,3)+6*A(1,4)*ti+12*A(1,5)*ti^2)/tt(1)^2;
  elseif (t(i)>tt(1))&(t(i)<=tt(2)+tt(1))
    ti = (t(i)-tt(1))/tt(2);
     a = (2*A(2,3)+6*A(2,4)*ti)/tt(2)^2;
  elseif (t(i)>tt(2)+tt(1))&(t(i)<=tt(3)+tt(2)+tt(1))
    ti = (t(i)-tt(2)-tt(1))/tt(3);
     a = (2*A(3,3)+6*A(3,4)*(ti-1)+12*A(3,5)*(ti-1).^2)/tt(3)^2;
  elseif (t(i) > tt(3)+tt(2)+tt(1))
     a = 0;
 end;
 elseif caso == 2
  if (t(i) <= 0)
     a = A(1,3)/tt(1)^2;
  elseif (t(i) > 0) & (t(i) <= tt(1))
    ti = t(i)/tt(1);
     a = (2*A(1,3)+6*A(1,4)*ti+12*A(1,5)*ti.^2)/tt(1)^2;
  elseif (t(i) > tt(1)) & (t(i) <= tt(2)+tt(1))
    ti = (t(i)-tt(1))/tt(2);
     a = (2*A(2,3)+6*A(2,4)*(ti-1)+12*A(2,5)*(ti-1).^2)/tt(2)^2;
  elseif (t(i) > tt(2)+tt(1))
     a = A(2,3)/tt(2)^2;
 end;

end;

ace(i)=a;
end;
 
