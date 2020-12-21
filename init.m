%%Subfunción para iniciar conexión 
function response = init 
BAUDNUM=1; 
PORT=10; 
loadlibrary('dynamixel', 'dynamixel.h'); 
%libfunctions('dynamixel'); 
response =calllib('dynamixel', 'dxl_initialize', PORT, BAUDNUM); 
end
