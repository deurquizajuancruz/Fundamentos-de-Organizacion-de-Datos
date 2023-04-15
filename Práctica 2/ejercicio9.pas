program Ejercicio9Practica2;
const
    valoralto=999;
type
    infoMaestro = record
        provincia:integer;
        localidad:integer;
        mesa:integer;
        votos:integer;
    end;

    archivoMaestro = file of infoMaestro;

{
CREACION ARCHIVO MAESTRO: SE DISPONE
procedure leerInfoMaestro(var info:infoMaestro);
begin
    writeln('Ingrese codigo de provincia: ');readln(info.provincia);
    if (info.provincia<>0) then begin
        writeln('Ingrese codigo de localidad: ');readln(info.localidad);
        info.mesa:=random(50)+1;
        info.votos:=random(400)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;

begin
    rewrite(m);
    leerInfoMaestro(info);
    while (info.provincia<>0) do begin
        write(m,info);
        leerInfoMaestro(info);        
    end;
    close(m);
end;
}

procedure imprimirArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;

begin
    reset(m);
    while (not eof(m)) do begin
        read(m,info);
        writeln('Provincia: ',info.provincia,#13#10,
        'Localidad: ',info.localidad,#13#10,
        'Mesa: ',info.mesa,#13#10,
        'Votos: ',info.votos,#13#10);
    end;
    close(m);
end;

procedure leer(var m:archivoMaestro;var info:infoMaestro);
begin
    if (not eof(m)) then read(m,info)
    else info.provincia:=valoralto;
end;

procedure recorrerArchivo(var m:archivoMaestro);
var
    info,actual:infoMaestro;
    totalProvincia,totalLocalidad,total:integer;

begin
    reset(m);
    leer(m,info);
    total:=0;
    while (info.provincia<>valoralto) do begin
        actual:=info;
        totalProvincia:=0;
        writeln(#13#10,'Codigo de provincia: ',actual.provincia);
        while (info.provincia=actual.provincia) do begin // mientras sea la misma provincia
            actual:=info;
            totalLocalidad:=0;
            writeln('Codigo de localidad       Total de Votos');
            while (info.provincia=actual.provincia) and (info.localidad=actual.localidad) do begin // mientras sea la misma localidad de la provincia, proceso los datos
                totalLocalidad+=info.votos;
                totalProvincia+=info.votos;
                total+=info.votos;
                leer(m,info);
            end;
            writeln(actual.localidad,'                         ',totalLocalidad);
        end;
        writeln('Total de votos Provincia: ',totalProvincia);
    end;
    writeln('Total General de Votos:   ',total);
    close(m);
end;

var
    maestro:archivoMaestro;
begin
    randomize;
    assign(maestro,'ArchivoMaestroEjercicio9');
    //cargarArchivoMaestro(maestro);
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);
    recorrerArchivo(maestro);
end.