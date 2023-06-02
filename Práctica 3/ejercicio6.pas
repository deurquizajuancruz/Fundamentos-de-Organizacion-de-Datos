program Ejercicio6Practica3;
type
    infoDetalle = record
        cod_prenda:integer;
    end;  
    infoMaestro = record
        prenda:infoDetalle;
        descripcion:string;
        colores:string;
        tipo_prenda:string;
        stock:integer;
        precio_unitario:real;
    end;
    archivoMaestro = file of infoMaestro;
    archivoDetalle = file of infoDetalle;

{ARCHIVO MAESTRO: SE DISPONE

function randomString():string;
var
    i:integer;
begin
    setLength(randomString,3);
    for i := 1 to 3 do randomString[i]:=chr(random(26)+97);        
end;

procedure leerPrenda(var info:infoMaestro);
begin
    writeln('Cod prenda: ');readln(info.prenda.cod_prenda);
    //info.prenda.cod_prenda:=random(6);
    if (info.prenda.cod_prenda<>0) then begin
        info.descripcion:=randomString();
        info.colores:=randomString();
        info.tipo_prenda:=randomString();
        info.stock:=random(500)+1;
        info.precio_unitario:=random()*100;
    end;
end;

procedure crearArchivoMaestro(var name:archivoMaestro);
var
    info:infoMaestro;
begin
    rewrite(name);
    leerPrenda(info);
    while (info.prenda.cod_prenda<>0) do begin
        write(name,info);
        leerPrenda(info);
    end;
    close(name);
end;

procedure cargarArchivoDetalle(var name:archivoDetalle);
var
    obsoleta:infoDetalle;
begin
    rewrite(name);
    writeln('Cod prenda obsoleta: ');
    readln(obsoleta.cod_prenda);
    while (obsoleta.cod_prenda<>0) do begin
        write(name,obsoleta);
        writeln('Cod prenda obsoleta: ');
        readln(obsoleta.cod_prenda);
    end;
    close(name);
end;}

procedure imprimirArchivoMaestro(var name:archivoMaestro);
var
    info:infoMaestro;
begin
    reset(name);
    while (not eof(name)) do begin
        read(name,info);
        writeln('Codigo de prenda: ',info.prenda.cod_prenda,'. Descripcion: ',info.descripcion,' Colores: ',info.colores,' Tipo de prenda: ',info.tipo_prenda,' Stock: ',info.stock,' Precio: ',info.precio_unitario:0:2);
    end;
    close(name);    
end;

procedure imprimirArchivoDetalle(var name:archivoDetalle);
var
    info:infoDetalle;
begin
    reset(name);
    while (not eof(name)) do begin
        read(name,info);
        writeln('Codigo de prenda obsoleta: ',info.cod_prenda);
    end;
    close(name);
end;

procedure bajaLogica(var maestro:archivoMaestro;var detalle:archivoDetalle);
var
    infoD:infoDetalle;
    infoM:infoMaestro;
begin
    reset(maestro); reset(detalle);
    while (not eof(detalle)) do begin
        read(detalle,infoD);
        seek(maestro,0);
        read(maestro,infoM);
        while (infoD.cod_prenda<>infoM.prenda.cod_prenda) do
            read(maestro,infoM);
        seek(maestro,filepos(maestro)-1);
        infoM.stock:=infoM.stock*-1;
        write(maestro,infoM);
    end;
    close(maestro); 
    close(detalle);
end;

procedure bajaFisica(var maestro,auxiliar:archivoMaestro);
var
    info:infoMaestro;
begin
    reset(maestro);
    assign(auxiliar,'ArchivoMaestroEjercicio6Compactado');
    rewrite(auxiliar);
    while (not eof(maestro)) do begin
        read(maestro,info);
        if (info.stock>0) then 
            write(auxiliar,info);
    end;
    close(auxiliar);    
    close(maestro);
    rename(maestro,'ArchivoMaestroEjercicio6SinCompactar');
end;

var
    maestro,auxiliar:archivoMaestro;
    detalle:archivoDetalle;
begin
    //randomize;
    assign(maestro,'ArchivoMaestroEjercicio6');
    assign(detalle,'ArchivoDetalleEjercicio6');
    {crearArchivoMaestro(maestro);
    cargarArchivoDetalle(detalle);}
    imprimirArchivoMaestro(maestro);
    imprimirArchivoDetalle(detalle);
    bajaLogica(maestro,detalle);
    writeln('Maestro con bajas: ');
    imprimirArchivoMaestro(maestro);
    bajaFisica(maestro,auxiliar);
    writeln('Nuevo archivo con bajas fisicas: ');
    imprimirArchivoMaestro(auxiliar);
end.