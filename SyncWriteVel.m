function SyncWriteVel(motorVel)
% tic
		%MX64.syncWritePosition Set the position of multiple consecutive actuators simultaneously.
            
			motorCount = length(motorVel);                            %numero de motores

            calllib('dynamixel','dxl_set_txpacket_id',254);					% Broadcast ID (fijo)
            calllib('dynamixel','dxl_set_txpacket_instruction',131);		% Sync Command (fijo)
            calllib('dynamixel','dxl_set_txpacket_parameter',0,32);	        % Primera direccion de escritura (en este caso posicion baja 30)

            paramNumber = 3;                                                % Numero de parametros por motor->3 (ID, Posicion baja, Posicion Alta)%para el for
                                                                            %%Si fuera velocidad serian 5 (ID posbaja, posalta, velbaja, velalta )
            calllib('dynamixel','dxl_set_txpacket_parameter',1,paramNumber - 1);    	%Cantidad de Parametros en un motor->2 (Posicion baja, Posicion Alta)
			% loop over each motor position given
			for id = 1:motorCount
                vel = motorVel(id); %obtiene velocidad objetivo del motor

                calllib('dynamixel','dxl_set_txpacket_parameter',(3*id)-1,id);          % ID of motor we want to address
                                                                                        %3*id-1 es el numero del parametro
                lowByte = calllib('dynamixel','dxl_get_lowbyte',vel);                 % calculate low byte (LSB) of 2 byte word
                highByte = calllib('dynamixel','dxl_get_highbyte',vel);               % calculate high byte (MSB) of 2 byte word
                calllib('dynamixel','dxl_set_txpacket_parameter',3*id,lowByte);         % write low byte
                calllib('dynamixel','dxl_set_txpacket_parameter',(3*id)+1,highByte);    % write high byte
            end

            % length = (L+1) X N + 4 | L = length of subPacket, N = number of servos
            calllib('dynamixel','dxl_set_txpacket_length',(paramNumber*motorCount)+4);  % Tama;o del paquete total
            calllib('dynamixel','dxl_txrx_packet');                                     % Transmit packet
%             toc
