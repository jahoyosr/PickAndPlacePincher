%%Subfunci�n para terminar conexi�n 
function terminate 
calllib('dynamixel','dxl_terminate')
unloadlibrary('dynamixel')
end
