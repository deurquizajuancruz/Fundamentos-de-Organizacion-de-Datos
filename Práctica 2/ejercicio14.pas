program Ejercicio14Practica2;
const
    valoralto='zzz';
type
    info = record
        destino:string;
        fecha:string;
        salida:string;
        cantidad:integer;
    end;
    archivos = file of info;

{ARCHIVO MAESTRO: SE DISPONE
procedure cargarInfoMaestro(var infoM:info);
begin
    writeln('Ingrese destino: ');readln(infoM.destino);
    if (infoM.destino<>valoralto) then begin
        writeln('Ingrese fecha: ');readln(infoM.fecha);
        writeln('Ingrese hora de salida: ');readln(infoM.salida);
        infoM.cantidad:=random(150)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:archivos);
var
    infoM:info;
begin
    rewrite(m);
    cargarInfoMaestro(infoM);
    while (infoM.destino<>valoralto) do begin
        write(m,infoM);
        cargarInfoMaestro(infoM);
    end;
    close(m);
end;

ARCHIVOS DETALLES: SE DISPONEN

procedure cargarInfoDetalle(var infoD:info);
begin
    writeln('Ingrese destino: ');readln(infoD.destino);
    if (infoD.destino<>valoralto) then begin
        writeln('Ingrese fecha: ');readln(infoD.fecha);
        writeln('Ingrese hora de salida: ');readln(infoD.salida);
        infoD.cantidad:=random(20)+1;
    end;
end;

procedure cargarArchivoDetalle(var d:archivos);
var
    infoD:info;
begin
    rewrite(d);
    cargarInfoDetalle(infoD);
    while (infoD.destino<>valoralto) do begin
        write(d,infoD);
        cargarInfoDetalle(infoD);
    end;
    close(d);
end;}

procedure imprimirArchivoDetalle(var d:archivos);
var
    infoD:info;
begin
    reset(d);
    while (not eof(d)) do begin
        read(d,infoD);
        writeln('Destino: ',infoD.destino,'. Fecha: ',infoD.fecha,'. Hora de salida: ',infoD.salida,'. Asientos comprados: ',infoD.cantidad);
    end;
    close(d);
end;

procedure imprimirArchivoMaestro(var m:archivos);
var
    infoM:info;
begin
    reset(m);
    while (not eof(m)) do begin
        read(m,infoM);
        writeln('Destino: ',infoM.destino,'. Fecha: ',infoM.fecha, '. Hora de salida: ',infoM.salida,'. Asientos disponibles: ',infoM.cantidad);
    end;
    close(m);
end;

procedure leer(var d:archivos; var infoD:info);
begin
    if (not eof(d)) then 
        read(d,infoD)
    else 
        infoD.destino:=valoralto;
end;

procedure buscarMinimo(var detalle1,detalle2:archivos;var info1,info2,min:info);
begin
    if (info1.destino<info2.destino) then begin
        min:=info1;
        leer(detalle1,info1);
    end 
    else begin
        min:=info2;
        leer(detalle2,info2);
    end;
end;

procedure actualizarMaestro(var m,det1,det2:archivos);
var
    min,info1,info2,infoM:info;
begin
    reset(m);
    reset(det1);
    reset(det2);
    leer(det1,info1);
    leer(det2,info2);
    buscarMinimo(det1,det2,info1,info2,min);
    while (min.destino<>valoralto) do begin
        read(m,infoM);
        while (min.destino>infoM.destino) do
            read(m,infoM);
        while (min.destino=infoM.destino) do begin
            while (min.fecha>infoM.fecha) do
                read(m,infoM);
            while (min.destino=infoM.destino) and (min.fecha=infoM.fecha) do begin
                while (min.salida>infoM.salida) do
                    read(m,infoM);
                while (min.destino=infoM.destino) and (min.fecha=infoM.fecha) and (min.salida=infoM.salida) do begin
                    infoM.cantidad-=min.cantidad;
                    buscarMinimo(det1,det2,info1,info2,min);
                end;
                seek(m,filepos(m)-1);
                write(m,infoM);
            end;
        end;
    end;
    close(m);
    close(det1);
    close(det2);
end;

var
    maestro,detalle1,detalle2:archivos;
begin
    randomize;
    assign(maestro,'ArchivoMaestroEjercicio14');
    cargarArchivoMaestro(maestro);
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);
    assign(detalle1,'ArchivoDetalleEjercicio14Numero1');
    assign(detalle2,'ArchivoDetalleEjercicio14Numero2');
    {writeln('Cargando detalle 1: ');cargarArchivoDetalle(detalle1);
    writeln('Cargando detalle 2: ');cargarArchivoDetalle(detalle2);}
    writeln('Archivo detalle 1: ');imprimirArchivoDetalle(detalle1);
    writeln('Archivo detalle 2: ');imprimirArchivoDetalle(detalle2);
    actualizarMaestro(maestro,detalle1,detalle2);
    writeln('Archivo maestro actualizado: ');
    imprimirArchivoMaestro(maestro);
end.