% SINCRONIZADOR Funcion que sincroniza los movimientos teniendo en consideración
% las condiciones iniciales, finales, características de las articulaciones y
% velocidades nominales.
% [VELO2,TMAXIMO]=SINCRONIZADOR(Q0,QF,VELO) devuelve la nueva velocidad
% máxima de cada motor.
% Q0 posición inicial (coordenadas articulares).
% QF posición final (coordenadas articulares).
% VELO velocidad máxima nominal de cada actuador.
% Ver también PLANIFICADOR, CALCULOCOEF, SINCRONIZADOR, EVALPOS, EVALACEL.
function [velo2,tmaximo]=sincronizador(q0,qf,velo)
%--Calculo de tiempos aproximados.
taprox = abs((qf(:,1)-q0(:,1)))./velo;
tmaximo = max(taprox);
%--Nueva velocidad maxima de cada motor.
velo2=(qf(:,1)-q0(:,1))/tmaximo;
return