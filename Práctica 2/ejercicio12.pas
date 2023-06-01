program Ejercicio12Practica2;
const
    valoralto=9999;
type
    meses = 1..12;
    dias = 1..31;
    infoMaestro = record
        anio:integer;
        mes:meses;
        dia:dias;
        id:integer;
        tiempoAcceso:real;
    end;
    archivoMaestro = file of infoMaestro;

{ARCHIVO MAESTRO: SE DISPONE

procedure cargarInfoMaestro(var info:infoMaestro);
begin
    writeln('Ingrese anio: ');readln(info.anio);
    if (info.anio<>0) then begin
        writeln('Ingrese mes: ');readln(info.mes);
        writeln('Ingrese dia: ');readln(info.dia);
        writeln('Ingrese id de usuario: ');readln(info.id);
        info.tiempoAcceso:=random()*100;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;
begin
    rewrite(m);
    cargarInfoMaestro(info);
    while (info.anio<>0) do begin
        write(m,info);
        cargarInfoMaestro(info);
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
        writeln('Anio: ',info.anio,#13#10,
        'Mes: ',info.mes,#13#10,
        'Dia: ',info.dia,#13#10,
        'ID: ',info.id,#13#10,
        'Tiempo de acceso: ',info.tiempoAcceso:0:2,#13#10);
    end;
    close(m);
end;

procedure leer(var m:archivoMaestro;var info:infoMaestro);
begin
    if (not eof(m)) then 
        read(m,info)
    else 
        info.anio:=valoralto;
end;

procedure recorrerArchivo(var m:archivoMaestro);
var
    anioBuscado:integer;
    info,actual:infoMaestro;
    totalAccesoAnio,totalAccesoMes,totalAccesoDia,totalAccesoUsuario:real;
begin
    writeln('Ingrese el anio a buscar: ');readln(anioBuscado);
    reset(m);
    leer(m,info);
    if (info.anio<>valoralto) then begin
        while (info.anio<>valoralto) and (info.anio<anioBuscado) do begin
            leer(m,info);
        end;
        if (info.anio=anioBuscado) then begin
            totalAccesoAnio:=0;
            writeln(#13#10,'Anio: ',anioBuscado);
            while (info.anio=anioBuscado) do begin
                actual:=info;
                totalAccesoMes:=0;
                writeln('Mes: ',actual.mes);
                while (actual.anio=anioBuscado) and (actual.mes=info.mes) do begin
                    actual:=info;
                    totalAccesoDia:=0;
                    writeln('Dia: ',actual.dia);
                    while (actual.anio=anioBuscado) and (actual.mes=info.mes) and (actual.dia=info.dia) do begin
                        actual:=info;
                        totalAccesoUsuario:=0;
                        while (actual.anio=anioBuscado) and (actual.mes=info.mes) and (actual.dia=info.dia) and (actual.id=info.id) do begin
                            actual:=info;
                            totalAccesoUsuario+=actual.tiempoAcceso;
                            leer(m,info);
                        end;                   
                        writeln('ID Usuario: ',actual.id,'. Tiempo total de acceso en el dia ',actual.dia,' mes ',actual.mes, ' es de: ',totalAccesoUsuario:0:2);
                        totalAccesoDia+=actual.tiempoAcceso;
                    end;
                    writeln('Tiempo total dia ',actual.dia,' mes ',actual.mes,': ',totalAccesoDia:0:2);
                    totalAccesoMes+=totalAccesoDia;
                end;
                writeln('Tiempo total mes ',actual.mes,': ',totalAccesoMes:0:2);
                totalAccesoAnio+=totalAccesoMes;
            end;
            writeln('Tiempo total anio: ',totalAccesoAnio:0:2);
        end
        else 
            writeln('Anio no encontrado');
    end;
    close(m);
end;

var
    maestro:archivoMaestro;
begin
    randomize;
    assign(maestro,'ArchivoMaestroEjercicio12');
    cargarArchivoMaestro(maestro);
    imprimirArchivoMaestro(maestro);
    recorrerArchivo(maestro);
end.