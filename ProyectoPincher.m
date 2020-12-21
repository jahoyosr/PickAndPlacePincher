% PRUEBAS DYNAMIXEL
% Siguiendo lineamientos de la guia de Dynamixel

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CARGAR LIBRERIA DE DYNAMIXEL
loadlibrary('dynamixel', 'dynamixel.h');
libfunctions('dynamixel');

% VALORES DE CONEXIÓN
DEFAULT_PORTNUM = 15;  %COM3 Cambiar si es un puerto diferente                                     %AJUSTAR COM
DEFAULT_BAUDNUM = 1;  %1Mbps Baudrate por defecto

% DIRECCIONES DE REGISTROS DE MOVIMIENTO
GOAL_POSITION = 30; % Posición objetivo
MOVING_SPEED = 32; % Velocidad angular
CW_ANGLE_LIMIT = 6; % Límite de ángulo clockwise
CCW_ANGLE_LIMIT = 8; % Límite de ángulo counterclockwise
PRESENT_POSITION = 36; % Posición actual (sólo lectura)
PRESENT_SPEED = 38; % Velocidad actual (sólo lectura)
MOVING = 46; % 1 si se está moviendo (sólo lectura)
TORQUE = 34;
PMAX = 14;

ID1 = 1;
ID2 = 2;
ID3 = 3;
ID4 = 4;
ID5 = 5;

% Variables para guardar los datos leídos
int32 Posicion;
int32 Velocidad;

% Velocidad final
velFinal = 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INICIAR CONEXIÓN 
% Abrir dispositivo
res = calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);
    if (res == 1) % Corroborar que se ha inicializado la conexión
        % Mensaje para conexión exitosa
        disp('Conectado a USB2Dynamixel!');

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % EJECUTAR FUNCIONES
        % Establecer par máximo y límite del torque
        calllib('dynamixel', 'dxl_write_word', ID1, TORQUE, int32(1023));                                   %AJUSTAR TORQUES
        calllib('dynamixel', 'dxl_write_word', ID2, TORQUE, int32(1023));
        calllib('dynamixel', 'dxl_write_word', ID3, TORQUE, int32(1023));
        calllib('dynamixel', 'dxl_write_word', ID4, TORQUE, int32(1023));
        calllib('dynamixel', 'dxl_write_word', ID5, TORQUE, 300);

        calllib('dynamixel', 'dxl_write_word', ID1, PMAX, int32(1023));
        calllib('dynamixel', 'dxl_write_word', ID2, PMAX, int32(1023));
        calllib('dynamixel', 'dxl_write_word', ID3, PMAX, int32(1023));
        calllib('dynamixel', 'dxl_write_word', ID4, PMAX, int32(1023));
        calllib('dynamixel', 'dxl_write_word', ID5, PMAX, 300);

        % Cambiar el valor de la velocidad angular
        calllib('dynamixel', 'dxl_write_word', ID1, MOVING_SPEED, int32(velFinal));                  %AJUSTAR VELOCIDADES
        calllib('dynamixel', 'dxl_write_word', ID2, MOVING_SPEED, int32(velFinal));
        calllib('dynamixel', 'dxl_write_word', ID3, MOVING_SPEED, int32(velFinal));
        calllib('dynamixel', 'dxl_write_word', ID4, MOVING_SPEED, int32(velFinal));
        calllib('dynamixel', 'dxl_write_word', ID5, MOVING_SPEED, int32(velFinal));
        
        clc
        %% LAB 4  
        
        velocidadPincher = 5; %rapido 0.04 , lento 0.01
        t=0;
        umbral = 40;                                                    %AJUSTAR EL UMBRAL PARA MOVIMIENTO FLUIDO
              
        numCaminos=4;
        
        suelo=0.2;                                                     %AJUSTAR la separacion del suelo
        
        for repeticiones = 0 : 3
        
        for camino=1:numCaminos
t=0;
            while t<=1
                
                %DEPRONTO AJUSTAR 0.2
               %% x y z orientacion
        if(camino==0)
            puntoA = [17 0 -(0) pi/2.5]; %HOME
            puntoB = [15 7 -(-6+suelo) 0];
        else if(camino==1)
                puntoA = [15 7 -(-6+suelo-0.2) 0];
                puntoB = [15 -7 -(-6+suelo-0.2) 0]; 
vel = [0 velocidadPincher 0 0 0 0]'; % Velocidad del efector final en el eje +y (5 cm/s)
        else if(camino==2)
                puntoA = [15 -7 -(-6+suelo) 0];
                puntoB = [22  -7 -(-6+suelo) 0];
vel = [velocidadPincher 0 0 0 0 0]'; % Velocidad del efector final en el eje +y (5 cm/s)
        else if(camino==3)
                puntoA = [22  -7 -(-6+suelo) 0];
                puntoB = [22  7 -(-6+suelo) 0]; %Poner vela
vel = [0 velocidadPincher 0 0 0 0]'; % Velocidad del efector final en el eje +y (5 cm/s)
        else if(camino==4)
                puntoA = [22  7 -(-6+suelo) 0];
                puntoB = [15  7 -(-6+suelo) 0];
vel = [velocidadPincher 0 0 0 0 0]'; % Velocidad del efector final en el eje +y (5 cm/s)
            end
            end
            end
            end
        end

                restaC = [puntoB(1,1)-puntoA(1,1), puntoB(1,2)-puntoA(1,2), puntoB(1,3)-puntoA(1,3), puntoB(1,4)-puntoA(1,4)];

                coordenadas = [puntoA(1,1)+t*restaC(1,1), puntoA(1,2)+t*restaC(1,2), puntoA(1,3)+t*restaC(1,3), puntoA(1,4)+t*restaC(1,4)];
                x = coordenadas(1,1);
                y = coordenadas(1,2);
                z = coordenadas(1,3);
                alfacero = coordenadas(1,4);

               %% Calculo de jacobiano
               
               J = jacobianoCalculo;
                
                
                %% Cin INV

                %PARAMETROS DEL ROBOT
                L1=10.8;
                L2=10.8;
                L3=7.5;

                q1=atan2(y,x);
                d=L3*cos(alfacero);
                xp=sqrt(x^2+y^2)-d;

                zp=z-L3*sin(alfacero);
                beta=atan2(zp,xp);
                Cgamma=(L1^2-L2^2+(xp^2+zp^2))/(2*L1*sqrt(xp^2+zp^2));
                Sgamma=sqrt(1-Cgamma^2);
                gamma=atan2(Sgamma,Cgamma);
                q2=beta-gamma;

                Cq3=(zp^2+xp^2-(L1^2+L2^2))/(2*L1*L2);
                Sq3=sqrt(1-Cq3^2);
                q3=atan2(Sq3,Cq3);

                q4=alfacero-(q2+q3);
                q2 = q2+pi/2;

                %%
                
                
            qpunto = pinv(eval(J))*vel;
% Conversión para pasar de rad/s a valor digital (0-1023)

            velenviar = [abs(qpunto(1)*1023/11.93805207) abs(qpunto(2)*1023/11.93805207) abs(qpunto(3)*1023/11.93805207) abs(qpunto(4)*1023/11.93805207)];

                %% Simulacion Pincher 3D

               %sim('Pincher_SOLID');

%                 q=[q1 q2 q3 q4]
                qenviar=[3.4222*(q1*180/pi)+512, -3.4222*(q2*180/pi)+512, -3.4222*(q3*180/pi)+512, -3.4222*(q4*180/pi)+512];

                %% Cin Directa enviar datos al robot
                
%                 SyncWrite(qenviar+5);
                SyncWrite1(velenviar);
                SyncWrite(qenviar);
                
                
                %%DETECCION DE MANO
                
                
img=snapshot(cam); %cargar la imagen
hsv_image = rgb2hsv(img);
hue=hsv_image(:,:,1);
height = length(img(:,1));
width = length(img(1,:,:));
%filtra que quita cosas muy negra y muy blancas 

    for w=1:width
        for h=1:height
               if hue(h,w) >0.66 || hue(h,w) <0.03
                   hue(h,w) = 0.66;
               end
        end
    end
            median = medfilt2(hue);  % quitar ruido con algo que se llama mascara 3x3 por defecto, entiendo que saca un promedo con una matriz de 3x3 para cada pixel, y asi filtra, hay que encontrar el tamano de la matriz que sea mejor para el filtro

 bajo = (1/360)*25;
 alto = (1/360)*240;

img_range = ones(height,width);
for h=1:height;
    for w=1:width;
        if (median(h,w) >= bajo && median(h,w) <= alto);
            img_range(h,w) = 0;
        end
    end
end

%Quitar areas que son muy pequenas
binaryImage = bwareaopen(img_range, 500);
% dilatacion , para hacer crecer los bordes y unmir areas
se = strel('square',8); 

dilatedI = imdilate(binaryImage, se);
%   figure,
imshow(dilatedI), title('dilatedI image');
yapaso=0;

                   
    for w=200:width-200
        for h=150:height-150
               if dilatedI(h,w) == 1 && yapaso==0
                   velocidadPincher = 2.5;
                   display('Cuidado!!');
                   yapaso=1;
               elseif  yapaso==0
                   velocidadPincher = 5;
               end
        end
    end
    hold on;
    plot(200,150,'*r');
    plot(200,height-150,'*r');
    plot(width-200,150,'*r');
    plot(width-200,height-150,'*r');
   drawnow
   
   t=t+velocidadPincher;
    
                
                
%                 calllib('dynamixel','dxl_write_word',ID1,GOAL_POSITION,int32(  qenviar(1,1)  ));
%                 calllib('dynamixel','dxl_write_word',ID2,GOAL_POSITION,int32(  qenviar(1,2)  ));
%                 calllib('dynamixel','dxl_write_word',ID3,GOAL_POSITION,int32(  qenviar(1,3)  ));
%                 calllib('dynamixel','dxl_write_word',ID4,GOAL_POSITION,int32(  qenviar(1,4)  ));
                
                %posicion presente de cada motor
                %condicion si no ha llegado no sigue
               while(int32(calllib('dynamixel','dxl_read_word',ID1,PRESENT_POSITION))>qenviar(1,1)+umbral || int32(calllib('dynamixel','dxl_read_word',ID1,PRESENT_POSITION))<qenviar(1,1)-umbral)
                   
                end
                while(int32(calllib('dynamixel','dxl_read_word',ID2,PRESENT_POSITION))>qenviar(1,2)+umbral || int32(calllib('dynamixel','dxl_read_word',ID2,PRESENT_POSITION))<qenviar(1,2)-umbral)
                   
                end
                while(int32(calllib('dynamixel','dxl_read_word',ID3,PRESENT_POSITION))>qenviar(1,3)+umbral || int32(calllib('dynamixel','dxl_read_word',ID3,PRESENT_POSITION))<qenviar(1,3)-umbral)
                    
                end
                while(int32(calllib('dynamixel','dxl_read_word',ID4,PRESENT_POSITION))>qenviar(1,4)+umbral || int32(calllib('dynamixel','dxl_read_word',ID4,PRESENT_POSITION))<qenviar(1,4)-umbral)
                    
                end
                
            end
            %POSICIONES DEL GRIPPER
                calllib('dynamixel','dxl_write_word',ID5,GOAL_POSITION,int32(200));
%                 while(int32(calllib('dynamixel','dxl_read_word',ID5,PRESENT_POSITION))>311+umbral || int32(calllib('dynamixel','dxl_read_word',ID5,PRESENT_POSITION))<311-umbral)
%                     
%                 end
        end
       
        camino=1;
    end
        
        
    else
        % Mensaje para fallo en la conexión
        disp('Falló la conexión a USB2Dynamixel!');
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % TERMINAR CONEXIÓN
% % Cerrar dispositivo
% calllib('dynamixel', 'dxl_terminate');
% disp('Dynamixel terminado');
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % LIBERAR LIBRERIA DE DYNAMIXEL
% unloadlibrary('dynamixel');


