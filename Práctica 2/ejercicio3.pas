program Ejercicio3Practica2;
const 
    valoralto=999;
type
    producto = record
        codigo:integer;
        nombre:string;
        descripcion:string;
        stockDisponible:integer;
        stockMinimo:integer;
        precio:real;
    end;
    infoDetalle = record
        codigo:integer;
        cantidad:integer;
    end;
    archivoDetalle = file of infoDetalle;
    archivoMaestro = file of producto;
    arrayDetalles = array [1..30] of archivoDetalle;

{ARCHIVO MAESTRO CON LOS DATOS DE LOS PRODUCTOS: SE DISPONE

function randomString():string;
var
    i:integer;
begin
    setLength(randomString,3);
    for i := 1 to 3 do 
        randomString[i]:=chr(random(26)+97);        
end;

procedure cargarProducto(var p:producto);
begin
    writeln('Ingrese codigo de producto: ');readln(p.codigo);
    if (p.codigo<>0) then begin
        p.nombre:=randomString();
        p.descripcion:=randomString();
        p.stockDisponible:=random(400)+1;
        p.stockMinimo:=random(400)+1;
        p.precio:=random()*100;
    end;
end;

procedure cargarArchivoMaestro(var maestro:archivoMaestro);
var
    p:producto;
begin
    rewrite(maestro);
    cargarProducto(p);
    while (p.codigo<>0) do begin
        write(maestro,p);
        cargarProducto(p);
    end;
    close(maestro);
end;

ARCHIVOS DETALLES CON INFO DE LOS PRODUCTOS: SE DISPONE

procedure cargarProductoDetalle(var p:infoDetalle);
begin
    writeln('Ingrese codigo del producto: ');
        readln(p.codigo);
    if (p.codigo<>0) then 
        p.cantidad:=random(50)+1;
end;

procedure cargarArchivoDetalle(var name:archivoDetalle);
var
    i:infoDetalle;
    nombre,numString:string;
begin
    rewrite(name);
    cargarProductoDetalle(i);
    while(i.codigo<>0) do begin
        write(name,i);
        cargarProductoDetalle(i);
    end;
    close(name);
end;}

procedure imprimirArchivo(var name:archivoMaestro);
var
    p:producto;

begin
    reset(name);
    while (not eof(name)) do begin
        read(name,p);
        writeln('Codigo de producto: ',p.codigo,'. Nombre: ',p.nombre,'. Descripcion: ',p.descripcion,'. Stock disponible: ',p.stockDisponible,'. Stock minimo: ',p.stockMinimo,'. Precio: ',p.precio:0:2);
    end;
    close(name);
end;

procedure imprimirDetalle(var name:archivoDetalle);
var
    i:infoDetalle;
begin
    reset(name);
    while (not eof(name)) do begin
        read(name,i);
        writeln('Codigo de producto: ',i.codigo,'. Cantidad: ',i.cantidad);
    end;
    close(name);
end;

procedure leer(var name:archivoDetalle;var i:infoDetalle);
begin
    if (not eof(name)) then 
        read(name,i)
    else 
        i.codigo:=valoralto;
end;

procedure actualizarMaestro(var m:archivoMaestro; var d:archivoDetalle);
var
    i:infoDetalle;
    p:producto;
begin
    reset(m);
    reset(d);
    leer(d,i);
    while (i.codigo<>valoralto) do begin // mientras no se termine el archivo detalle, leo en el maestro
        read(m,p);
        while(i.codigo<>p.codigo) do begin //mientras el codigo del detalle sea diferente al del maestro, leo en el maestro
            read(m,p);
        end;
        while (i.codigo=p.codigo) do begin // mientras los codigos sean iguales, actualizo en el registro a cargar en el maestro
            if (i.cantidad>p.stockDisponible) then
                p.stockDisponible:=0 // para que el stock no quede negativo
            else 
                p.stockDisponible-=i.cantidad;
            leer(d,i);
        end;
        seek(m,filepos(m)-1); //me posiciono en la posicion anterior a la que estoy parado del maestro para poder actualizar esa informacion
        write(m,p); //cargo el producto actualizado en el maestro
    end;
    close(m);
    close(d);
end;

procedure exportarTxt(var m:archivoMaestro);
var
    txt:text;
    p:producto;
begin
    reset(m);
    assign(txt,'stockDisponibleMenorEjercicio3.txt');
    rewrite(txt);
    write(txt,'Productos que tienen un stock disponible menor que el stock minimo: ',#13#10);
    while (not eof(m)) do begin
        read(m,p);
        if (p.stockDisponible<p.stockMinimo) then
            write(txt,'Nombre: ',p.nombre,'. Descripcion: ',p.descripcion,'. Stock disponible: ',p.stockDisponible,'. Precio: ',p.precio:0:2,#13#10);
    end;
    close(txt);
    close(m);
end;

var
    maestro:archivoMaestro;
    i:integer;
    vector:arrayDetalles;
    nombre,numString:string;
begin
    //randomize;
    assign(maestro, 'ArchivoMaestroEjercicio3');
    cargarArchivoMaestro(maestro);
    imprimirArchivo(maestro);
    for i := 1 to 30 do begin
        nombre:='ArchivoDetalleEjercicio2Numero';
        str(i,numString);
        nombre+=numString;
        assign(vector[i],nombre);
        {writeln('Cargar archivo detalle numero ',i);
        cargarArchivoDetalle(vector[i]);}
        writeln('Detalle numero: ',i);
        imprimirDetalle(vector[i]);
        actualizarMaestro(maestro,vector[i]);
    end;
    writeln('Archivo maestro, actualizado:');
    imprimirArchivo(maestro);
    exportarTxt(maestro);
end.