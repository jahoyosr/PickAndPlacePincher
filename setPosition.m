%%Subfunción para multiplexar el comando a cada motor 
function response= setPosition(pos) 
if(length(pos)==5) %Ángulos cero de posición home, en este 
ceros=[150 150 150 150 0]; %caso [150 150 150 150 0] 
pos=ceros+pos;
for ID=1:5 
npos=limitPosition(pos(ID),ID); 
calllib('dynamixel' , 'dxl_write_word', ID , 30 , npos); 
end 
response=1; 
else 
response=0; 
end 
end
