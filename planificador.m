% PLANIFICADOR Planificador de trayectorias con interpolador 4-3-4.
%
% [T,POS_PLAN, VEL_PLAN, ACE_PLAN]=PLANIFICADOR(Q1,Q2) calcula las matrices
% de posición, velocidad y aceleración de los puntos nudo que representan
% la planficiación de trayectorias entre los punto Q1 y Q2 cumpliendo con
% las restricciones de trayectoria suave y prestaciones de los actuadores.
% Utiliza los polinomios 4-3-4 en los tres segmentos de trayectoria.
%
% Ver también CALCULOCOEF, SINCRONIZADOR, EVALPOS, EVALVEL, EVALACEL.
function [t, pos_plan, vel_plan, ace_plan] = planificador(q1,q2)
%**********************parámetros de los accionamientos**************
%---------------------------------------------------------------------
% Especificaciones de los tiempos de arranque y frenado de cada motor.
%---------------------------------------------------------------------
tmotor = 0.1*ones(4,2);
%---------------------------------------------------------------------
%Velocidades Maxima de cada motor.
%---------------------------------------------------------------------
velmax = [2.672;2.672;2.672;2.672];
%**********************planificador coordinado***********************
%---------------------------------------------------------------------
% Inicialización de los vectores posicion - Velocidad - aceleracion.
%---------------------------------------------------------------------
q = zeros(4,1);
q0 = [q1 q q];
qf = [q2 q q];
%---------------------------------------------------------------------
% Sincronización de los motores para que realizen un movimiento coordinado
%---------------------------------------------------------------------
[velo2,tmaximo]=sincronizador(q0,qf,velmax);
%---------------------------------------------------------------------
%Inicialización de la escala de tiempo y las matrices.
%---------------------------------------------------------------------
t = 0:0.01:(tmaximo+0.15);
% +0.15 se suma con el fin de aumentar el intervalo de tiempo y muestrear
% todo el intervalo de frenado de la articulación, asumiendo las
% aproximaciones realizadas en la función SINCRONIZADOR.
ini=zeros(length(t),1);
pos_plan(:,1)=ini;
vel_plan(:,1)=ini;
ace_plan(:,1)=ini;
%---------------------------------------------------------------------
% Cálculo de los coeficientes de los polinomios y evaluación de los
% polinomios de interpolación.
%---------------------------------------------------------------------
for i = 1:4
[caso,A,tt] = calculocoef(i,velo2,q0,qf,tmotor);
posi=evalpos(t,tt,caso,A);
pos_plan(:,i)=posi';
ve=evalvel(t,tt,caso,A);
vel_plan(:,i)=ve';
ace=evalacel(t,tt,caso,A);
ace_plan(:,i)=ace';
end;
return