select *,
right(nombreArchivo, 
locate('.' , reverse(nombreArchivo))) 
from video