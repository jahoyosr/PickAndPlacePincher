%%Subfunción de torque límite 
function response=limitVelocidad(Vlimit) 
if(length(Vlimit)==5) 
for ID=1:5 
calllib('dynamixel' , 'dxl_write_word' , ID , 32, Vlimit(ID)); 
end 
response=1; 
else 
response=0; 
end 
end
