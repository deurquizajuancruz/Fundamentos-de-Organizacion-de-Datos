program Ejercicio4Practica2;
const valoralto=999;
type 
    infoDetalle = record
        cod_usuario:integer;
        fecha:string;
        tiempo_sesion:integer;
    end;
    
    infoMaestro = record
        cod_usuario:integer;
        fecha:string;
        tiempo_total_de_sesiones_abiertas:integer;
    end;

    archivoDetalle = file of infoDetalle;
    archivoMaestro = file of infoMaestro;
    arrayDetalles = array[1..5] of archivoDetalle;
    arrayRegistrosDetalles = array[1..5] of infoDetalle;
    

//ARCHIVOS DETALLES CON INFORMACION DE USUARIOS: SE DISPONE
{
procedure cargarUsuarioDetalle(var i:infoDetalle);
begin
    writeln('Ingrese codigo de usuario: ');readln(i.cod_usuario);
    if (i.cod_usuario<>0) then begin
        writeln('Ingrese fecha: ');readln(i.fecha);
        i.tiempo_sesion:=random(60)+1;
    end;
end;

procedure cargarArchivoDetalle(var name:archivoDetalle;num:integer);
var
    i:infoDetalle;
    nombre,numString:string;

begin
    nombre:='ArchivoDetalleEjercicio4Numero';
    str(num,numString);
    nombre+=numString;
    assign(name,nombre);
    rewrite(name);
    cargarUsuarioDetalle(i);
    while (i.cod_usuario<>0) do begin
        write(name,i);
        cargarUsuarioDetalle(i);    
    end;
    close(name);
end;
}

procedure imprimirArchivoDetalle(var name:archivoDetalle);
var
    i:infoDetalle;
begin
    reset(name);
    while (not eof(name)) do begin
        read(name,i);
        writeln('Codigo de usuario: ',i.cod_usuario,'. Fecha: ',i.fecha,'. Tiempo de la sesion: ',i.tiempo_sesion);
    end;
    close(name);
end;

procedure leer(var d:archivoDetalle;var i:infoDetalle);
begin
    if (not eof(d)) then read(d,i)
    else i.cod_usuario:=valoralto;
end;

procedure buscarMinimo(var vectorDetalles:arrayDetalles; var registroDetalles:arrayRegistrosDetalles; var min: infoDetalle);
var
    i,minPos:integer;
begin
    min.cod_usuario:=valoralto;
    min.fecha:='zzzz';
    for i := 1 to 5 do begin
        if (registroDetalles[i].cod_usuario<>valoralto) then begin
            if (registroDetalles[i].cod_usuario<min.cod_usuario) and (registroDetalles[i].fecha<min.fecha) then begin //busco el minimo entre todos las primeras informaciones de usuario
                min:=registroDetalles[i];
                minPos:=i;
            end;
        end;
    end;
    if (min.cod_usuario<>valoralto) then leer(vectorDetalles[minPos],registroDetalles[minPos]); //si se encontro un minimo, avanzo en el archivo q contiene ese minimo
end;

procedure inicializarArchivosDetalles(var vectorDetalles:arrayDetalles; var registroDetalles:arrayRegistrosDetalles);
var
    i:integer;

begin
    for i := 1 to 5 do begin
        reset(vectorDetalles[i]);
        leer(vectorDetalles[i],registroDetalles[i]); // leo la primera informacion de usuario y la guardo en el vector de registros
    end;
end;

procedure cerrarArchivosDetalles(var vectorDetalles:arrayDetalles);
var
    i:integer;

begin
    for i := 1 to 5 do begin
        close(vectorDetalles[i]);
    end;
end;

procedure crearArchivoMaestro(var maestro:archivoMaestro;var vectorDetalles:arrayDetalles;var vectorRegistros:arrayRegistrosDetalles);
var
    min:infoDetalle;
    actual:infoMaestro;

begin
    assign(maestro,'ArchivoMaestroEjercicio4');
    rewrite(maestro);
    inicializarArchivosDetalles(vectorDetalles,vectorRegistros);
    buscarMinimo(vectorDetalles,vectorRegistros,min);
    while (min.cod_usuario<>valoralto) do begin
        actual.cod_usuario:=min.cod_usuario;
        while (min.cod_usuario<>valoralto) and (actual.cod_usuario=min.cod_usuario) do begin
            actual.fecha:=min.fecha;
            actual.tiempo_total_de_sesiones_abiertas:=0;
            while (min.cod_usuario<>valoralto) and (actual.cod_usuario=min.cod_usuario) and (actual.fecha=min.fecha) do begin
                actual.tiempo_total_de_sesiones_abiertas+=min.tiempo_sesion;
                buscarMinimo(vectorDetalles,vectorRegistros,min);
            end;
            write(maestro,actual);
        end;
    end;
    cerrarArchivosDetalles(vectorDetalles);
    close(maestro);
end;

procedure imprimirArchivoMaestro(var name:archivoMaestro);
var
    i:infoMaestro;
begin
    reset(name);
    while (not eof(name)) do begin
        read(name,i);
        writeln('El usuario con codigo ',i.cod_usuario,' en la fecha ',i.fecha,' tuvo un tiempo total de: ',i.tiempo_total_de_sesiones_abiertas);
    end;
    close(name);
end;

var
    i:integer;
    vectorDetalles:arrayDetalles;
    nombre,numString:string;
    vectorRegistros:arrayRegistrosDetalles;
    maestro: archivoMaestro;

begin
    randomize;
    for i := 1 to 5 do begin
        //writeln('Cargando el archivo detalle numero: ',i);
        //cargarArchivoDetalle(vectorDetalles[i],i);
        nombre:='ArchivoDetalleEjercicio4Numero';
        str(i,numString);
        nombre+=numString;
        assign(vectorDetalles[i],nombre);
        writeln('---------------------');
        writeln('Informacion del archivo detalle numero: ',i);
        imprimirArchivoDetalle(vectorDetalles[i]);
    end;
    crearArchivoMaestro(maestro,vectorDetalles,vectorRegistros);
    writeln('---------------------');
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);
end.