%%Subfunción para terminar conexión 
function terminate 
calllib('dynamixel','dxl_terminate')
unloadlibrary('dynamixel')
end
