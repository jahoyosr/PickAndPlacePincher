%	EVALVEL Funcion que evalua el polinomio de la funcion de velocidad de
%	acuerdo al caso y al tiempo.
%		VEL=EVALVEL(T,TT,CASO,A) evalúa el polinomio de aceleración.
%		A matriz 5x3 que contiene los coeficientes de los polinomios interpolados.
%		T vector tiempo normalizado.
%		TT segmentos de tiempo de aceleración, velocidad máxima y deceleración.
%		caso=1: Cada motor logra alcanzar su velocidad maxima.
%		caso=2: No hay tiempo de alcanzar la velocidad maxima de cada motor.
%
%		Ver también PLANIFICADOR, CALCULOCOEF, SINCRONIZADOR, EVALPOS, EVALACEL.

function vel = evalvel(t,tt,caso,A)

for i = 1:length(t)

 if caso == 1
  if (t(i) <= 0)
     v = 0;
  elseif (t(i) > 0) & (t(i) <= tt(1))
    ti = t(i)/tt(1);
     v = (A(1,2)+2*A(1,3)*ti+3*A(1,4)*ti.^2+4*A(1,5)*ti.^3)/tt(1);
  elseif (t(i) > tt(1)) & (t(i) <= tt(2)+tt(1))
    ti = (t(i)-tt(1))/tt(2);
     v = (A(2,2)+2*A(2,3)*ti+3*A(2,4)*ti.^2)/tt(2);
  elseif (t(i) > tt(2)+tt(1)) & (t(i) <= tt(3)+tt(2)+tt(1))
    ti = (t(i)-tt(2)-tt(1))/tt(3);
     v = (A(3,2)+2*A(3,3)*(ti-1)+3*A(3,4)*(ti-1).^2+4*A(3,5)*(ti-1).^3)/tt(3);
  elseif (t(i) > tt(3)+tt(2)+tt(1))
     v = 0;
 end;
 elseif caso == 2
  if (t(i) <= 0)
    v = A(1,2)/tt(1);
  elseif (t(i) > 0) & (t(i) <= tt(1))
    ti = t(i)/tt(1);
     v = (A(1,2)+2*A(1,3)*ti+3*A(1,4)*ti.^2+4*A(1,5)*ti.^3)/tt(1);
  elseif (t(i) > tt(1)) & (t(i) <= tt(2)+tt(1))
    ti = (t(i)-tt(1))/tt(2);
     v = (A(2,2)+2*A(2,3)*(ti-1)+3*A(2,4)*(ti-1).^2+4*A(2,5)*(ti-1).^3)/tt(2);
  elseif (t(i) > tt(2)+tt(1))
     v = A(2,2)/tt(2);
 end;
    
end;

vel(i)=v;
end;
