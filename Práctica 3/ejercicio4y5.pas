program Ejercicio4y5Practica3;
type
    reg_flor = record
        nombre:string[45];
        codigo:integer;
    end;
    tArchFlores = file of reg_flor;

procedure crearArchivo(var name:tArchFlores);
var
    flor:reg_flor;
begin
    assign(name,'ArchivoEjercicio4y5');
    rewrite(name);
    flor.codigo:=0;
    flor.nombre:='';
    write(name,flor);
    close(name);
end;

function existeFlor(var name:tArchFlores;codigoFlor:integer):boolean;
var
    flor:reg_flor;
begin
    reset(name);
    existeFlor:=false;
    while (not eof(name) and (not existeFlor)) do begin
        read(name,flor);
        if (flor.codigo=codigoFlor) then existeFlor:=true;
    end; //no lo cierro para no perder el puntero cuando borro
end;

procedure agregarFlor(var a:tArchFlores;nombre:string;codigo:integer);
var
    flor,nueva:reg_flor;
begin
    if (not existeFlor(a,codigo)) then begin
        reset(a);
        read(a,flor); //leo la cabecera
        nueva.nombre:=nombre;
        nueva.codigo:=codigo;
        if (flor.codigo=0) then begin //si la cabecera=0 -> tengo que agregar al final porque no hay registros libres
            seek(a,filesize(a));
            write(a,nueva);
        end
        else begin // si la cabecera<0 -> encontrar el registro libre e insertar la nueva flor ahi
            seek(a,flor.codigo*-1); // la cabecera va a tener la posicion libre pero negativa: lo multiplico por -1 y me posiciono
            read(a,flor); //leo lo que hay en el registro libre
            seek(a,filepos(a)-1); //me posiciono en el registro libre
            write(a,nueva); //escribo la nueva flor
            seek(a,0); // me posiciono en la cabecera
            write(a,flor); //escribo en la cabecera lo que habia en el registro libre: proximo registro libre
        end;
        writeln('Se agrego la flor correctamente.');
        close(a);
    end
    else
        writeln('No se puede agregar la flor ',nombre,' con el codigo ',codigo,' debido a que ya existe en el archivo.');
end;

procedure listarFlores(var name:tArchFlores);
var
    flor:reg_flor;
begin
    reset(name);
    read(name,flor); //salteo la cabecera
    while (not eof(name)) do begin
        read(name,flor);
        if (flor.codigo>0) then 
            writeln('Flor con nombre: ',flor.nombre,' y codigo: ',flor.codigo);
    end;
    close(name);
end;

procedure eliminarFlor(var name:tArchFlores; flor:reg_flor);
var
    florLeida,cabeceraLista:reg_flor;
begin
    reset(name);
    read(name,cabeceraLista); // me salteo la cabecera
    if (existeFlor(name,flor.codigo)) then begin
        seek(name,filepos(name)-1); //me posiciono en el registro a borrar
        write(name,cabeceraLista); //escribo la cabecera en el registro a borrar
        cabeceraLista.codigo:=(filepos(name)-1)*-1;// pongo el indice del registro en negativo
        seek(name,0); // me posiciono en la cabecera
        write(name,cabeceraLista); //el registro cabecera almacena el indice del registro que acabo de borrar (el libre)
        writeln('Se elimino la flor correctamente.');
        close(name);
    end
    else 
        writeln('No se encontro una flor con esos datos.');
end;

var
    archivo:tArchFlores;
    florEliminar:reg_flor;
begin
    crearArchivo(archivo);
    agregarFlor(archivo,'Antonia',1);
    agregarFlor(archivo,'Bautista',2);
    agregarFlor(archivo,'Celeste',3);
    agregarFlor(archivo,'Dorada',4);
    agregarFlor(archivo,'Plateada',4); // no se va a poder agregar porque ya existe el codigo
    florEliminar.codigo:=3;
    eliminarFlor(archivo,florEliminar);
    florEliminar.codigo:=9;
    eliminarFlor(archivo,florEliminar); //no se va a poder eliminar porque no existe el codigo
    agregarFlor(archivo,'Margarita',7);
    listarFlores(archivo);
end.