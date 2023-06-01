program Ejercicio7Practica2;
const
    valoralto=999;
type
    infoMaestro = record
        codigo:integer;
        nombre:string;
        precio:real;
        stockActual:integer;
        stockMinimo:integer;
    end;
    infoDetalle = record
        codigo:integer;
        vendidas:integer;
    end;
    archivoMaestro = file of infoMaestro;
    archivoDetalle = file of infoDetalle;

{ARCHIVO MAESTRO: SE DISPONE

function randomString():string;
var
    i:integer;
begin
    setLength(randomString,3);
    for i := 1 to 3 do 
        randomString[i]:=chr(random(26)+97);        
end;

procedure cargarInfoMaestro(var info:infoMaestro);
begin
    writeln('Ingrese codigo de producto: ');readln(info.codigo);
    if (info.codigo<>0) then begin
        info.nombre:=randomString();
        info.precio:=random()*100;
        info.stockActual:=random(100)+1;
        info.stockMinimo:=random(120)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    rewrite(m);
    cargarInfoMaestro(info);
    while (info.codigo<>0) do begin
        write(m,info);
        cargarInfoMaestro(info);
    end;
    close(m);
end;


procedure cargarInfoDetalle(var info:infoDetalle);
begin
    writeln('Ingrese codigo de producto: ');
    readln(info.codigo);
    if (info.codigo<>0) then 
        info.vendidas:=random(50)+1;
end;

procedure cargarArchivoDetalle(var d:archivoDetalle);
var
    info:infoDetalle;
begin
    rewrite(d);
    cargarInfoDetalle(info);
    while (info.codigo<>0) do begin
        write(d,info);
        cargarInfoDetalle(info);
    end;
    close(d);
end;
}

procedure imprimirArchivoDetalle(var d:archivoDetalle);
var
    info:infoDetalle;
begin
    reset(d);
    while (not eof(d)) do begin
        read(d,info);
        writeln('El producto ',info.codigo,' tuvo ',info.vendidas,' unidades vendidas.');
    end;
    close(d);
end;

procedure imprimirArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    reset(m);
    while (not eof(m)) do begin
        read(m,info);
        writeln('Codigo de producto: ',info.codigo,#13#10,
        'Nombre: ',info.nombre,#13#10,
        'Precio: ',info.precio:0:2,#13#10,
        'Stock actual: ',info.stockActual,#13#10,
        'Stock minimo: ',info.stockMinimo,#13#10);
    end;
    close(m);
end;

procedure leer(var d:archivoDetalle;var info:infoDetalle);
begin
    if (not eof(d)) then 
        read(d,info)
    else 
        info.codigo:=valoralto;
end;

procedure actualizarMaestro(var m:archivoMaestro;var d:archivoDetalle);
var
    infoD:infoDetalle;
    actual:infoMaestro;
begin
    reset(m); 
    reset(d);
    leer(d,infoD);
    read(m,actual);
    while (infoD.codigo<>valoralto) do begin
        while (infoD.codigo<>actual.codigo) do
            read(m,actual);
        while (infoD.codigo=actual.codigo) do begin
            if (infoD.vendidas>=actual.stockActual) then 
                actual.stockActual:=0
            else
                actual.stockActual-=infoD.vendidas;
            leer(d,infoD);
        end;
        seek(m,filepos(m)-1);
        write(m,actual);
    end;
    close(m);
    close(d);
end;

procedure exportarTxt(var m:archivoMaestro);
var
    info:infoMaestro;
    txt:text;
begin
    assign(txt,'stock_minimoEjercicio7.txt');
    rewrite(txt);
    reset(m);
    while(not eof(m)) do begin
        read(m,info);
        if (info.stockActual<info.stockMinimo) then
            write(txt,'Producto ',info.codigo,' con nombre ',info.nombre,' precio ',info.precio:0:2,' tiene un stock actual de ',info.stockActual,' menor a ',info.stockMinimo,', el stock minimo',#13#10);
    end;
    writeln('Archivo maestro exportado a txt');
    close(m);
    close(txt);
end;

var
    maestro:archivoMaestro;
    detalle:archivoDetalle;
    opcion:integer;
begin
    //randomize;
    assign(maestro,'ArchivoMaestroEjercicio7');
    assign(detalle,'ArchivoDetalleEjercicio7');
    {cargarArchivoMaestro(maestro);
    cargarArchivoDetalle(detalle);
    writeln('Archivo detalle: ');
    imprimirArchivoDetalle(detalle);
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);}
    writeln('Seleccione una opcion: ',#13#10,
    '1: Actualizar el archivo maestro con el archivo detalle.',#13#10,
    '2: Listar en un archivo de texto llamado stock_minimo.txt aquellos productos cuyo stock actual este por debajo del stock minimo permitido.');
    readln(opcion);
    case opcion of
        1: begin
            actualizarMaestro(maestro,detalle);
            writeln('Archivo maestro actualizado: ');
            imprimirArchivoMaestro(maestro);    
        end;
        2: exportarTxt(maestro);
    end;
end.