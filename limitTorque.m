%%Subfunción de torque límite 
function response=limitTorque(Tlimit) 
if(length(Tlimit)==5) 
for ID=1:5 
calllib('dynamixel' , 'dxl_write_word' , ID , 34, Tlimit(ID)); 
end 
response=1; 
else 
response=0; 
end 
end
