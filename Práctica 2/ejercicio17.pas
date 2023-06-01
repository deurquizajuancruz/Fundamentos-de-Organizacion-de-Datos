program Ejercicio17Practica2;
const
    valoralto=32760;
type
    infoMaestro = record
        codigo:integer;
        nombre:string;
        descripcion:string;
        modelo:string;
        marca:string;
        stockActual:integer;
    end;
    infoDetalle = record
        codigo:integer;
        precio:real;
        fecha:string;
    end;
    archivoMaestro = file of infoMaestro;
    archivoDetalle = file of infoDetalle;
    arrayDetalles = array[1..10] of archivoDetalle;
    arrayRegistrosDetalles = array[1..10] of infoDetalle;

{ARCHIVO MAESTRO: SE DISPONE

function randomString():string;
var
    i:integer;
begin
    setLength(randomString,5);
    for i := 1 to 5 do 
        randomString[i]:=chr(random(26)+97);
end;

procedure cargarInfoMaestro(var info:infoMaestro);
begin
    writeln('Ingrese codigo de la moto: ');readln(info.codigo);
    if (info.codigo<>valoralto) then begin
        info.nombre:=randomString();
        info.descripcion:=randomString();
        info.marca:=randomString();
        info.modelo:=randomString();
        info.stockActual:=random(1000)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    rewrite(m);
    cargarInfoMaestro(info);
    while (info.codigo<>valoralto) do begin
        write(m,info);
        cargarInfoMaestro(info);
    end;
    close(m);
end;

procedure cargarInfoDetalle(var info:infoDetalle);
begin
    writeln('Ingrese codigo de moto: ');readln(info.codigo);
    if (info.codigo<>valoralto) then begin
        info.precio:=random()*100;
        info.fecha:=randomString();
    end;
end;

procedure cargarArchivoDetalle(var name:archivoDetalle);
var
    info:infoDetalle;
begin
    rewrite(name);
    cargarInfoDetalle(info);
    while(info.codigo<>valoralto) do begin
        write(name,info);
        cargarInfoDetalle(info);
    end;
    close(name);
end;}

procedure imprimirArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    reset(m);
    while (not eof(m)) do begin
        read(m,info);
        writeln('Codigo de moto: ',info.codigo,' Stock actual: ',info.stockActual); // no imprimo el resto xq es irrelevante para lo que hay q hacer
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
        writeln('Codigo de moto: ',info.codigo, ' fecha: ',info.fecha); // no imprimo el resto xq es irrelevante para lo que hay q hacer
    end;
    close(d);
end;

procedure leer(var d:archivoDetalle;var info:infoDetalle);
begin
    if (not eof(d)) then 
        read(d,info)
    else 
        info.codigo:=valoralto;
end;

procedure inicializarArchivosDetalles(var vectorDetalles:arrayDetalles; var vectorRegistros:arrayRegistrosDetalles);
var
    i:integer;
begin
    for i := 1 to 10 do begin
        reset(vectorDetalles[i]);
        leer(vectorDetalles[i],vectorRegistros[i]);
    end;
end;

procedure cerrarArchivosDetalles(var vectorDetalles:arrayDetalles);
var
    i:integer;
begin
    for i := 1 to 5 do
        close(vectorDetalles[i]);
end;

procedure buscarMinimo(var min:infoDetalle; var vectorDetalles: arrayDetalles; var vectorRegistros: arrayRegistrosDetalles);
var
    minPos,i: integer;
begin
    min.codigo:=valoralto;
    for i := 1 to 10 do begin
        if (vectorRegistros[i].codigo<>valoralto) then begin
            if (vectorRegistros[i].codigo<min.codigo) then begin
                minPos:=i;
                min:=vectorRegistros[i];
            end;
        end;
    end;
    if (min.codigo<>valoralto) then 
        leer(vectorDetalles[minPos],vectorRegistros[minPos]);
end;

procedure actualizarMaestro(var m:archivoMaestro; var vectorDetalles:arrayDetalles);
var
    infoM,masVendida:infoMaestro;
    vectorRegistros:arrayRegistrosDetalles;
    ventas,maximo:integer;
    min:infoDetalle;
begin   
    reset(m);
    inicializarArchivosDetalles(vectorDetalles,vectorRegistros);
    buscarMinimo(min,vectorDetalles,vectorRegistros);
    read(m,infoM);
    maximo:=-1;
    while (min.codigo<>valoralto) do begin
        while (min.codigo>infoM.codigo) do
            read(m,infoM);
        ventas:=0;
        while (min.codigo=infoM.codigo) do begin
            ventas+=1;
            buscarMinimo(min,vectorDetalles,vectorRegistros);
        end;
        infoM.stockActual-=ventas;
        if (ventas>maximo) then begin
            masVendida:=infoM;
            maximo:=ventas;
        end;
        seek(m,filepos(m)-1);
        write(m,infoM);
    end;
    writeln('La moto mas vendida fue la moto con codigo ',masVendida.codigo,' Nombre: ',masVendida.nombre,' Descripcion: ',masVendida.descripcion,' Modelo: ',masVendida.modelo,' Marca: ',masVendida.marca,' con ',maximo,' ventas.');
    cerrarArchivosDetalles(vectorDetalles);
    close(m);
end;

var
    maestro:archivoMaestro;
    vectorDetalles:arrayDetalles;
    i:integer;
    nombre,numString:string;
begin
    //randomize;
    assign(maestro,'ArchivoMaestroEjercicio17');
    //cargarArchivoMaestro(maestro);
    imprimirArchivoMaestro(maestro);
    for i := 1 to 10 do begin
        nombre:='ArchivoDetalleEjercicio17Numero';
        str(i,numString);
        nombre+=numString;
        assign(vectorDetalles[i],nombre);
        {writeln('Cargando archivo detalle numero ',i);
        cargarArchivoDetalle(vectorDetalles[i]);}
        writeln('Archivo detalle numero ',i);
        imprimirArchivoDetalle(vectorDetalles[i]);
    end;
    actualizarMaestro(maestro,vectorDetalles);
    writeln('Archivo maestro actualizado: ');
    imprimirArchivoMaestro(maestro);
end.