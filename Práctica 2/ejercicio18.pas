program Ejercicio18Practica2;
const
    valoralto=32760;
type
    infoMaestro = record
        codigoLocalidad:integer;
        nombreLocalidad:string;
        codigoMunicipio:integer;
        nombreMunicipio:string;
        codigoHospital:integer;
        nombreHospital:string;
        fecha:string;
        casosPositivos:integer;
    end;
    archivoMaestro = file of infoMaestro;

{ARCHIVO MAESTRO: SE DISPONE

function randomString():string;
var
    i:integer;
begin
    setLength(randomString,5);
    for i := 1 to 5 do 
        randomString[i]:=chr(random(26)+97);
end;

procedure cargarInfoMaestro(var info:infoMaestro; anteriorLocalidad,anteriorMunicipio,anteriorHospital:integer);
begin
    writeln('Ingrese codigo de localidad: ');readln(info.codigoLocalidad); //ordenados por codigos
    if (info.codigoLocalidad<>valoralto) then begin
        if (info.codigoLocalidad<>anteriorLocalidad) then 
            info.nombreLocalidad:=randomString(); //si es la misma localidad, no leo de nuevo el nombre
        writeln('Ingrese codigo de municipio: ');
        readln(info.codigoMunicipio);
        if (info.codigoMunicipio<>anteriorMunicipio) then 
            info.nombreMunicipio:=randomString(); //lo mismo con el nombre del municipio
        writeln('Ingrese codigo de hospital: ');
        readln(info.codigoHospital);
        if (info.codigoHospital<>anteriorHospital) then 
            info.nombreHospital:=randomString();
        info.fecha:=randomString();
        info.casosPositivos:=random(500)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    rewrite(m);
    cargarInfoMaestro(info,0,0,0);
    while (info.codigoLocalidad<>valoralto) do begin
        write(m,info);
        cargarInfoMaestro(info,info.codigoLocalidad,info.codigoMunicipio,info.codigoHospital);
    end;
    close(m);
end;}

procedure imprimirArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    reset(m);
    while (not eof(m)) do begin
        read(m,info);
        writeln('Codigo de localidad: ',info.codigoLocalidad,#13#10,
        'Codigo de municipio: ',info.codigoMunicipio,#13#10,
        'Codigo de hospital: ',info.codigoHospital,#13#10,
        'Ubicacion: ',info.nombreHospital,',',info.nombreMunicipio,',',info.nombreLocalidad,#13#10,
        'Casos positivos en la fecha ',info.fecha,': ',info.casosPositivos,#13#10);
    end;
    close(m);
end;

procedure leer(var m:archivoMaestro; var info:infoMaestro);
begin
    if (not eof(m)) then 
        read(m,info)
    else 
        info.codigoLocalidad:=valoralto;
end;

procedure recorrerArchivoMaestro(var m:archivoMaestro);
var
    totalHospital,totalMunicipio,totalLocalidad,total:integer;
    info,actual:infoMaestro;
    txt:text;
begin
    reset(m);
    assign(txt,'ArchivoMaestroEjercicio18.txt');
    rewrite(txt);
    leer(m,info);
    total:=0;
    while (info.codigoLocalidad<>valoralto) do begin
        actual:=info;
        writeln(#13#10,'Localidad: ',info.codigoLocalidad,' Nombre: ',info.nombreLocalidad);
        totalLocalidad:=0;
        while (actual.codigoLocalidad=info.codigoLocalidad) do begin
            actual:=info;
            totalMunicipio:=0;
            writeln('Municipio: ',info.codigoMunicipio,' Nombre: ',info.nombreMunicipio);
            while (actual.codigoLocalidad=info.codigoLocalidad) and (actual.codigoMunicipio=info.codigoMunicipio) do begin
                actual:=info;
                totalHospital:=0;
                while (actual.codigoLocalidad=info.codigoLocalidad) and (actual.codigoMunicipio=info.codigoMunicipio) and (actual.codigoHospital=info.codigoHospital) do begin
                    actual:=info;
                    totalHospital+=info.casosPositivos;
                    leer(m,info);
                end;
                writeln('Hospital: ',actual.codigoHospital,' Nombre: ',actual.nombreHospital,'-------- Cantidad de casos: ',totalHospital);
                totalMunicipio+=totalHospital;
            end;
            writeln('Cantidad de casos en el municipio ',actual.codigoMunicipio,': ',totalMunicipio);
            if (totalMunicipio>1500) then
                write(txt,'El municipio ',actual.nombreMunicipio,' de la localidad ',actual.nombreLocalidad,' tiene ',totalMunicipio,' casos.',#13#10);
            totalLocalidad+=totalMunicipio;
        end;
        writeln('Cantidad de casos en la localidad: ',actual.codigoLocalidad,': ',totalLocalidad);
        total+=totalLocalidad;
    end;
    writeln('Total de casos en la provincia: ',total);
    close(m);
    close(txt);
end;

var
    maestro:archivoMaestro;
begin
    //randomize;
    assign(maestro,'ArchivoMaestroEjercicio18');
    //cargarArchivoMaestro(maestro);
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);
    recorrerArchivoMaestro(maestro);
end.