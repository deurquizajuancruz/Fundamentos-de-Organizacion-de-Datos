program Ejercicio1Practica2;
const 
    valoralto=999;
type
    empleado = record
        codigo:integer;
        nombre:string;
        monto:real;
    end;
    archivoComisiones = file of empleado;

{CREANDO EL ARCHIVO QUE HAY QUE RECORRER

procedure cargarEmpleado(var e:empleado;aux:integer);
begin
    writeln('Ingrese codigo del empleado: ');
    readln(e.codigo);
    if ((e.codigo<>aux) and (e.codigo<>0)) then begin
        writeln('Ingrese nombre del empleado: ');
        readln(e.nombre);
    end;
    e.monto:=Random()*100;
end;

procedure crearArchivoComisiones(var viejo:archivoComisiones;name:string);
var
    e:empleado;
    aux:integer;
begin
    rewrite(viejo);
    aux:=-1;
    cargarEmpleado(e,aux);
    while (e.codigo<>0) do begin
        write(viejo,e);
        aux:=e.codigo;
        cargarEmpleado(e,aux);
    end;
    close(viejo);
end;

procedure imprimirArchivo(var viejo:archivoComisiones);
var
    e:empleado;
begin
    reset(viejo);
    while (not eof(viejo)) do begin
        read(viejo,e);
        writeln('Codigo del empleado: ',e.codigo,'. Nombre: ',e.nombre,'. Monto: ',e.monto:0:2);
    end;
    close(viejo);
end;}

procedure leer(var viejo:archivoComisiones;var e:empleado);
begin
    if (not eof(viejo)) then 
        read(viejo,e)
    else 
        e.codigo:=valoralto;
end;

procedure recorrerArchivo(var nuevo,viejo:archivoComisiones);
var
    e,aux:empleado;
begin
    reset(viejo);
    leer(viejo,e);
    while (e.codigo<>valoralto) do begin
        aux:=e;
        aux.monto:=0;
        while (aux.codigo=e.codigo) do begin
            aux.monto+=e.monto;
            leer(viejo,e);
        end;
        write(nuevo,aux);
    end;
    close(nuevo);
    close(viejo);
end;

var
    archivoRecorrer,archivoNuevo: archivoComisiones;
begin
    {randomize;
    assign(archivoRecorrer,'ArchivoMaestroEjercicio1');
    crearArchivoComisiones(archivoRecorrer,'ArchivoMaestroEjercicio1');
    imprimirArchivo(archivoRecorrer);}
    assign(archivoNuevo,'ArchivoMaestroEjercicio1Compactado');
    rewrite(archivoNuevo);
    recorrerArchivo(archivoNuevo,archivoRecorrer);
    //imprimirArchivo(archivoNuevo);
end.