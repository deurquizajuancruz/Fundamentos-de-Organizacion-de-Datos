program Ejercicio8Practica2;
const
    valoralto=999;
type
    cliente = record
        codigo:integer;
        nombre:string;
        apellido:string;
    end;

    infoMaestro = record
        cli:cliente;
        anio:integer;
        mes:integer;
        dia:integer;
        monto:real;
    end;

    archivoMaestro= file of infoMaestro;

{ 
ARCHIVO MAESTRO: SE DISPONE
function randomString():string;
var
    i:integer;

begin
    setLength(randomString,6);
    for i := 1 to 6 do randomString[i]:=chr(random(26)+97);
end;

procedure leerInfoMaestro(var info:infoMaestro);
begin
    writeln('Ingrese codigo de cliente: ');readln(info.cli.codigo);
    if (info.cli.codigo<>0) then begin
        writeln('Ingrese anio: ');readln(info.anio);
        writeln('Ingrese mes: ');readln(info.mes);
        info.cli.nombre:=randomString();
        info.cli.apellido:=randomString();
        info.dia:=random(31)+1;
        info.monto:=random()*100;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;

begin
    rewrite(m);
    leerInfoMaestro(info);
    while (info.cli.codigo<>0) do begin
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
        writeln('Codigo de cliente: ',info.cli.codigo,#13#10,
        'Anio: ',info.anio,#13#10,
        'Mes: ',info.mes,#13#10,
        'Nombre y apellido: ',info.cli.nombre, ' ',info.cli.apellido,#13#10,
        'Dia: ',info.dia,#13#10,
        'Monto: ',info.monto:0:2,#13#10);
    end;
    close(m);
end;

procedure leer(var m:archivoMaestro;var info:infoMaestro);
begin
    if (not eof(m)) then read(m,info)
    else info.cli.codigo:=valoralto;
end;

procedure recorrerArchivo(var m:archivoMaestro);
var
    info,actual:infoMaestro;
    totalEmpresa,totalAnio,totalMes:real;

begin
    reset(m);
    leer(m,info);
    totalEmpresa:=0;
    while (info.cli.codigo<>valoralto) do begin
        actual:=info;
        while (info.cli.codigo=actual.cli.codigo) do begin
            actual:=info;
            totalAnio:=0;
            while (info.cli.codigo=actual.cli.codigo) and (info.anio=actual.anio) do begin
                actual:=info;
                totalMes:=0;
                while (info.cli.codigo=actual.cli.codigo) and (info.anio=actual.anio) and (info.mes=actual.mes) do begin
                    totalMes+=info.monto;
                    totalAnio+=info.monto;
                    totalEmpresa+=info.monto;
                    leer(m,info);
                end;
                writeln('Recaudado en el mes ',actual.mes,' anio ',actual.anio,' por el cliente ',actual.cli.codigo,' llamado ',actual.cli.nombre,' ',actual.cli.apellido,' fue de: ',totalMes:0:2);
            end;
            writeln('Recaudado en el anio ',actual.anio,' por el cliente ',actual.cli.codigo,' llamado ',actual.cli.nombre,' ',actual.cli.apellido,' fue de: ',totalAnio:0:2);
        end;
    end;
    writeln('Recaudado total en la empresa: ',totalEmpresa:0:2);
    close(m);
end;

var
    maestro:archivoMaestro;

begin
    randomize;
    assign(maestro,'ArchivoMaestroEjercicio8');
    //cargarArchivoMaestro(maestro);
    imprimirArchivoMaestro(maestro);
    recorrerArchivo(maestro);
end.