program Ejercicio15Practica2;
const
    valoralto=999;
type
    infoMaestro = record
        provincia:integer;
        nombreProvincia:string;
        localidad:integer;
        nombreLocalidad:string;
        sinLuz:integer;
        sinGas:integer;
        chapa:integer;
        sinAgua:integer;
        sinSanitarios:integer;
    end;
    infoDetalle = record
        provincia:integer;
        localidad:integer;
        conLuz:integer;
        construidas:integer;
        conAgua:integer;
        conGas:integer;
        sanitarios:integer;
    end;
    archivoMaestro = file of infoMaestro;
    archivoDetalle = file of infoDetalle;
    arrayDetalles = array [1..10] of archivoDetalle;
    arrayRegistrosDetalles = array[1..10] of infoDetalle;

{ARCHIVO MAESTRO: SE DISPONE

function randomString():string;
var
    i:integer;

begin
    setLength(randomString,6);
    for i := 1 to 5 do 
        randomString[i]:=chr(random(26)+97);
end;

procedure cargarInfoMaestro(var info:infoMaestro;anterior:integer);
begin
    writeln('Ingrese codigo de provincia: ');readln(info.provincia);
    if (info.provincia<>valoralto) then begin
        if (info.provincia<>anterior) then begin
            writeln('Ingrese nombre de la provincia: ');
            readln(info.nombreProvincia); //si el codigo de la provincia es el mismo que el anterior, no pedir 2 veces el nombre de la prov
        end;
        writeln('Ingrese codigo de localidad: ');readln(info.localidad);
        info.nombreLocalidad:=randomString();
        info.sinLuz:=random(2000)+1;
        info.sinGas:=random(2000)+1;
        info.chapa:=random(2000)+1;
        info.sinAgua:=random(2000)+1;
        info.sinSanitarios:=random(2000)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    rewrite(m);
    cargarInfoMaestro(info,0);
    while (info.provincia<>valoralto) do begin
        write(m,info);
        cargarInfoMaestro(info,info.provincia);
    end;
    close(m);
end;

procedure cargarInfoDetalle(var info:infoDetalle);
begin
    writeln('Ingrese codigo de provincia: ');readln(info.provincia);
    if (info.provincia<>valoralto) then begin
        writeln('Ingrese codigo de localidad: ');readln(info.localidad);
        info.conLuz:=random(100)+1;
        info.construidas:=random(100)+1;
        info.conAgua:=random(100)+1;
        info.conGas:=random(100)+1;
        info.sanitarios:=random(100)+1;
    end;
end;

procedure cargarArchivoDetalle(var name:archivoDetalle);
var
    info:infoDetalle;
begin
    rewrite(name);
    cargarInfoDetalle(info);
    while(info.provincia<>valoralto) do begin
        write(name,info);
        cargarInfoDetalle(info);
    end;
    close(name);
end;}

procedure leer(var d:archivoDetalle; var infoD:infoDetalle);
begin
    if (not eof(d)) then 
        read(d,infoD)
    else 
        infoD.provincia:=valoralto;
end;

procedure buscarMinimo(var min:infoDetalle; var vectorRegistros:arrayRegistrosDetalles; var vectorDetalles:arrayDetalles);
var
    i,minPos:integer;
begin
    min.provincia:=valoralto;
    min.localidad:=valoralto;
    for i := 1 to 10 do begin
        if (vectorRegistros[i].provincia<>valoralto) then begin
            if (vectorRegistros[i].provincia<=min.provincia) and (vectorRegistros[i].localidad<=min.localidad) then begin
                minPos:=i;
                min:=vectorRegistros[i];
            end;            
        end;
    end;
    if (min.provincia<>valoralto) then 
        leer(vectorDetalles[minPos],vectorRegistros[minPos]);
end;

procedure inicializarArchivosDetalles(var vectorDetalles:arrayDetalles;var vectorRegistros:arrayRegistrosDetalles);
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
    for i := 1 to 10 do
        close(vectorDetalles[i]);
end;

procedure actualizarMaestro(var m:archivoMaestro; var vector:arrayDetalles);
var
    vectorRegistros:arrayRegistrosDetalles;
    min:infoDetalle;
    infoM:infoMaestro;
begin
    reset(m);
    inicializarArchivosDetalles(vector,vectorRegistros);
    buscarMinimo(min,vectorRegistros,vector);
    read(m,infoM);
    while (min.provincia<>valoralto) do begin
        while (min.provincia>infoM.provincia) do
            read(m,infoM);
        while (min.provincia=infoM.provincia) do begin
            while (min.localidad>infoM.localidad) do
                read(m,infoM);
            while (min.provincia=infoM.provincia) and (min.localidad=infoM.localidad) do begin
                // para q no queden numeros negativos
                if (min.conLuz>infoM.sinLuz) then 
                    infoM.sinLuz:=0
                else 
                    infoM.sinLuz-=min.conLuz;
                if (min.conGas>infoM.sinGas) then 
                    infoM.sinGas:=0
                else 
                    infoM.sinGas-=min.conGas;
                if (min.construidas>infoM.chapa) then 
                    infoM.chapa:=0
                else 
                    infoM.chapa-=min.construidas;
                if (min.conAgua>infoM.sinAgua) then 
                    infoM.sinAgua:=0
                else 
                    infoM.sinAgua-=min.conAgua;
                if (min.sanitarios>infoM.sinSanitarios) then 
                    infoM.sinSanitarios:=0
                else 
                    infoM.sinSanitarios-=min.sanitarios;
                buscarMinimo(min,vectorRegistros,vector);                
            end;
            seek(m,filepos(m)-1);
            write(m,infoM);
        end;
    end;
    close(m);
    cerrarArchivosDetalles(vector);
end;

procedure imprimirArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    reset(m);
    while (not eof(m)) do begin
        read(m,info);
        writeln('Codigo provincia: ',info.provincia,#13#10,
        'Codigo localidad: ',info.localidad,#13#10,
        'Ubicacion: ',info.nombreLocalidad,',',info.nombreProvincia,#13#10,
        'Viviendas sin luz: ',info.sinLuz,#13#10,
        'Viviendas sin gas: ',info.sinGas,#13#10,
        'Viviendas de chapa: ',info.chapa,#13#10,
        'Viviendas sin agua: ',info.sinAgua,#13#10,
        'Viviendas sin sanitarios: ',info.sinSanitarios,#13#10);
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
        writeln('Codigo de provincia: ',info.provincia,#13#10,
        'Codigo de localidad: ',info.localidad,#13#10,
        'Viviendas con luz: ',info.conLuz,#13#10,
        'Viviendas construidas: ',info.construidas,#13#10,
        'Viviendas con agua: ',info.conAgua,#13#10,
        'Viviendas con gas: ',info.conGas,#13#10,
        'Viviendas con sanitarios: ',info.sanitarios,#13#10);
    end;
    close(d);
end;

var
    maestro:archivoMaestro;
    vectorDetalles:arrayDetalles;
    i:integer;
    nombre,numString:string;
begin
    randomize;
    assign(maestro,'ArchivoMaestroEjercicio15');
    cargarArchivoMaestro(maestro);
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);
    for i := 1 to 10 do begin
        nombre:='ArchivoDetalleEjercicio15Numero';
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