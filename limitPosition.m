%%Sunfunción para ángulos límite en cada motor 
function POUT=limitPosition(pos,motor) 
Bpos=3.41*pos; 
limits=[0 1023;120 890; 50 940; 200 800; 15 186]; 
POUT= max(Bpos,limits(motor,1)); 
POUT= min(POUT,limits(motor,2)); 
end
