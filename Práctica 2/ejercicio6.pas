program Ejercicio6Practica2;
const
    valoralto=999;
type
    infoDetalle = record
        localidad:integer;
        cepa:integer;
        activos:integer;
        nuevos:integer;
        recuperados:integer;
        fallecidos:integer;
    end;
    infoMaestro = record
        localidad:integer;
        nombre:string;
        cepa:integer;
        nombreCepa:string;
        activos:integer;
        nuevos:integer;
        recuperados:integer;
        fallecidos:integer;
    end;
    archivoDetalle = file of infoDetalle;
    archivoMaestro = file of infoMaestro;
    arrayDetalles = array [1..10] of archivoDetalle;
    arrayRegistrosDetalles = array [1..10] of infoDetalle;

{
ARCHIVOS DETALLES DE MUNICIPIOS: SE DISPONEN

procedure cargarInfoDetalle(var info:infoDetalle);
begin
    writeln('Ingrese codigo de localidad: ');readln(info.localidad);
    if (info.localidad<>0) then begin
        writeln('Ingrese codigo de cepa: ');readln(info.cepa);
        info.activos:=random(100)+1;
        info.nuevos:=random(100)+1;
        info.recuperados:=random(100)+1;
        info.fallecidos:=random(100)+1;
    end;
end;

procedure cargarArchivoDetalle(var d:archivoDetalle;num:integer);
var
    numString,nombre:string;
    info:infoDetalle;

begin
    nombre:='ArchivoDetalleEjercicio6Numero';
    str(num,numString);
    nombre+=numString;
    assign(d,nombre);
    rewrite(d);
    cargarInfoDetalle(info);
    while (info.localidad<>0) do begin
        write(d,info);
        cargarInfoDetalle(info);
    end;
    close(d);
end;

ARCHIVO MAESTRO: SE DISPONE

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
    writeln('Ingrese codigo de localidad: ');
    readln(info.localidad);
    if (info.localidad<>0) then begin
        info.nombre:=randomString();
        writeln('Ingrese codigo de cepa: ');
        readln(info.cepa);
        info.nombreCepa:=randomString();
        info.activos:=random(100)+1;
        info.nuevos:=random(100)+1;
        info.recuperados:=random(100)+1;
        info.fallecidos:=random(100)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    rewrite(m);
    cargarInfoMaestro(info);
    while (info.localidad<>0) do begin
        write(m,info);
        cargarInfoMaestro(info);
    end;
    close(m);
end;
}

procedure imprimirArchivoDetalle(var d:archivoDetalle);
var
    info:infoDetalle;
begin
    reset(d);
    while(not eof(d)) do begin
        read(d,info);
        writeln(#13#10,'Localidad: ',info.localidad,#13#10,
        'Cepa: ',info.cepa,#13#10,
        'Casos activos: ',info.activos,#13#10,
        'Casos nuevos: ',info.nuevos,#13#10,
        'Recuperados: ',info.recuperados,#13#10,
        'Fallecidos: ',info.fallecidos);
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
        writeln(#13#10,'Localidad: ',info.nombre,' ',info.localidad,#13#10,
        'Cepa: ',info.nombreCepa,' ',info.cepa,#13#10,
        'Casos activos: ',info.activos,#13#10,
        'Casos nuevos: ',info.nuevos,#13#10,
        'Recuperados: ',info.recuperados,#13#10,
        'Fallecidos: ',info.fallecidos);
    end;
    close(m);
end;

procedure leer(var d:archivoDetalle;var info:infoDetalle);
begin
    if (not eof(d)) then 
        read(d,info)
    else 
        info.localidad:=valoralto;
end;

procedure inicializarArchivosDetalles(var vectorDetalles:arrayDetalles; var registroDetalles:arrayRegistrosDetalles);
var
    i:integer;
begin
    for i := 1 to 10 do begin
        reset(vectorDetalles[i]);
        leer(vectorDetalles[i],registroDetalles[i]);
    end;
end;

procedure cerrarArchivosDetalles(var vectorDetalles:arrayDetalles);
var
    i:integer;
begin
    for i := 1 to 10 do begin
        close(vectorDetalles[i]);
    end;
end;

procedure buscarMinimo(var vectorDetalles:arrayDetalles;var vectorRegistros:arrayRegistrosDetalles;var min:infoDetalle);
var
    i,minPos:integer;
begin
    min.localidad:=valoralto;
    min.cepa:=valoralto;
    for i := 1 to 10 do begin
        if (vectorRegistros[i].localidad<>valoralto) then begin
            if (vectorRegistros[i].localidad<min.localidad) or ((vectorRegistros[i].localidad=min.localidad) and (vectorRegistros[i].cepa<min.cepa)) then begin
                min:=vectorRegistros[i];
                minPos:=i;
            end;
        end;    
    end;
    if (min.localidad<>valoralto) then 
        leer(vectorDetalles[minPos],vectorRegistros[minPos]);
end;

procedure actualizarMaestro(var m:archivoMaestro;var vectorDetalles:arrayDetalles);
var
    min:infoDetalle;
    actual:infoMaestro;  
    vectorRegistros:arrayRegistrosDetalles;
begin
    reset(m);
    inicializarArchivosDetalles(vectorDetalles,vectorRegistros);
    buscarMinimo(vectorDetalles,vectorRegistros,min);
    read(m,actual);
    while (min.localidad<>valoralto) do begin
        while (actual.localidad<>min.localidad) do
            read(m,actual); // si sale de este loop es porque las localidades son iguales
        while (min.localidad<>valoralto) and (actual.localidad=min.localidad) do begin //mientras sea la misma localidad, busco la cepa
            while (actual.cepa<>min.cepa) do
                read(m,actual); //busco la cepa igual
            while (min.localidad<>valoralto) and (actual.localidad=min.localidad) and (actual.cepa=min.cepa) do begin //mientras sea la misma localidad y misma cepa, actualizo
                actual.fallecidos+=min.fallecidos;
                actual.recuperados+=min.recuperados;
                actual.activos:=min.activos;
                actual.nuevos:=min.nuevos;
                buscarMinimo(vectorDetalles,vectorRegistros,min);
            end;
            seek(m,filepos(m)-1);
            write(m,actual);
        end;
    end;
    cerrarArchivosDetalles(vectorDetalles);
    close(m);
end;

var
    i:integer;
    vectorDetalles:arrayDetalles;
    nombre,numString:string;
    maestro:archivoMaestro;
begin
    //randomize;
    for i := 1 to 10 do begin
        //cargarArchivoDetalle(vectorDetalles[i],i);
        nombre:='ArchivoDetalleEjercicio6Numero';
        str(i,numString);
        nombre+=numString;
        assign(vectorDetalles[i],nombre);
        writeln('Informacion archivo detalle numero: ',i);    
        imprimirArchivoDetalle(vectorDetalles[i]);
    end;
    assign(maestro,'ArchivoMaestroEjercicio6');
    //cargarArchivoMaestro(maestro);
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);
    writeln('Archivo maestro actualizado: ');
    actualizarMaestro(maestro,vectorDetalles);
    imprimirArchivoMaestro(maestro);
end.
