program Ejercicio11Practica2;
const
    valoralto='zz';
type
    infoMaestro = record
        nombreProvincia:string;
        alfabetizados:integer;
        encuestados:integer;
    end;
    infoDetalle = record
        nombreProvincia:string;
        localidad:integer;
        alfabetizados:integer;
        encuestados:integer;
    end;
    archivoMaestro = file of infoMaestro;
    archivoDetalle = file of infoDetalle;

{ARCHIVO MAESTRO: SE DISPONE

procedure cargarInfoMaestro(var info:infoMaestro);
begin
    writeln('Ingrese nombre de la provincia: ');readln(info.nombreProvincia);
    if (info.nombreProvincia<>'zz') then begin
        info.alfabetizados:=random(1000)+1;
        info.encuestados:=random(5000)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    rewrite(m);
    cargarInfoMaestro(info);
    while (info.nombreProvincia<>'zz') do begin
        write(m,info);
        cargarInfoMaestro(info);
    end;
    close(m);
end;

ARCHIVOS DETALLES: SE DISPONEN

procedure cargarInfoDetalle(var info:infoDetalle);
begin
    writeln('Ingrese nombre de la provincia: ');readln(info.nombreProvincia);
    if (info.nombreProvincia<>'zz') then begin
        info.localidad:=random(50)+1;
        info.alfabetizados:=random(500)+1;
        info.encuestados:=random(1000)+1;
    end;
end;

procedure cargarArchivoDetalle(var d:archivoDetalle);
var
    info:infoDetalle;
begin
    rewrite(d);
    cargarInfoDetalle(info);
    while (info.nombreProvincia<>'zz') do begin
        write(d,info);
        cargarInfoDetalle(info);
    end;
    close(d);
end;
}

procedure imprimirArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    reset(m);
    while (not eof(m)) do begin
        read(m,info);
        writeln('Nombre de la provincia: ',info.nombreProvincia,' Alfabetizados: ',info.alfabetizados,' Encuestados: ',info.encuestados);
    end;
    close(m);
end;

procedure imprimirArchivoDetalle(var d:archivoDetalle);
var
    info:infoDetalle;
begin
    reset(d);
    while (not eof(d)) do begin
        read(d,info);
        writeln('Nombre de la provincia: ',info.nombreProvincia,' Localidad: ',info.localidad,' Alfabetizados: ',info.alfabetizados,' Encuestados: ',info.encuestados);
    end;
    close(d);
end;

procedure leer(var d:archivoDetalle; var info:infoDetalle);
begin
    if (not eof(d)) then 
        read(d,info)
    else 
        info.nombreProvincia:=valoralto;
end;

procedure actualizarMaestro(var m:archivoMaestro;var d:archivoDetalle);
var
    infoD:infoDetalle;
    infoM:infoMaestro;
begin
    reset(m); 
    reset(d);
    leer(d,infoD);
    read(m,infoM);
    while (infoD.nombreProvincia<>valoralto) do begin
        while (infoM.nombreProvincia<>infoD.nombreProvincia) do
            read(m,infoM);
        while (infoM.nombreProvincia=infoD.nombreProvincia) do begin
            infoM.alfabetizados+=infoD.alfabetizados;
            infoM.encuestados+=infoD.encuestados;
            leer(d,infoD);
        end;
        seek(m,filepos(m)-1);
        write(m,infoM);
    end;
    close(m); 
    close(d);
end;

var
    maestro:archivoMaestro;
    detalle1,detalle2:archivoDetalle;
begin
    //randomize;
    assign(maestro,'ArchivoMaestroEjercicio11');
    assign(detalle1,'ArchivoDetalleEjercicio11Numero1');
    assign(detalle2,'ArchivoDetalleEjercicio11Numero2');
    //cargarArchivoMaestro(maestro);
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);
    {writeln('Cargando detalle 1: ');
    cargarArchivoDetalle(detalle1);
    writeln('Cargando detalle 2: ');
    cargarArchivoDetalle(detalle2);}
    writeln('Archivo detalle 1: ');
    imprimirArchivoDetalle(detalle1);
    writeln('Archivo detalle 2: ');
    imprimirArchivoDetalle(detalle2);
    actualizarMaestro(maestro,detalle1);
    actualizarMaestro(maestro,detalle2);
    writeln('Archivo maestro actualizado: ');
    imprimirArchivoMaestro(maestro);
end.