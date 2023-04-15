program Ejercicio10Practica2;
const
    valoralto=999;
type
    infoMaestro = record
        departamento: integer;
        division: integer;
        numero:integer;
        categoria:integer;
        horas:integer;
    end;

    archivoMaestro = file of infoMaestro;
    archivoCategorias = array[1..15] of real;

{
procedure leerInfoMaestro(var info:infoMaestro);
begin
    writeln('Ingrese el departamento: ');readln(info.departamento);
    if (info.departamento<>0) then begin
        writeln('Ingrese division: ');readln(info.division);
        writeln('Ingrese numero de empleado: ');readln(info.numero);
        info.categoria:=random(15)+1;
        info.horas:=random(10)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;

begin
    rewrite(m);
    leerInfoMaestro(info);
    while (info.departamento<>0) do begin
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
        writeln('Departamento: ',info.departamento,#13#10,
        'Division: ',info.division,#13#10,
        'Numero de empleado: ',info.numero,#13#10,
        'Categoria: ',info.categoria,#13#10,
        'Horas: ',info.horas,#13#10);
    end;
    close(m);
end;

procedure cargarVectorHoras(var vectorHoras:archivoCategorias);
var
    txt:text;
    categoria:integer;
    valorCategoria:real;

begin
    assign(txt,'categoriasValoresEjercicio10.txt');
    reset(txt);
    while (not eof(txt)) do begin
        read(txt,categoria,valorCategoria);
        vectorHoras[categoria]:=valorCategoria;
    end;
    close(txt);
end;

procedure leer(var m:archivoMaestro;var info:infoMaestro);
begin
    if (not eof(m)) then read(m,info)
    else info.departamento:=valoralto;
end;

procedure recorrerArchivo(var m:archivoMaestro;vectorHoras:archivoCategorias);
var
    info,actual:infoMaestro;
    montoTotalDepartamento,montoTotalDivision,montoTotalEmpleado:real;
    totalHorasDepartamento,totalHorasDivision,totalHorasEmpleado:integer;

begin
    reset(m);
    leer(m,info);   
    while (info.departamento<>valoralto) do begin
        actual:=info;
        totalHorasDepartamento:=0;
        montoTotalDepartamento:=0;
        writeln(#13#10,'Departamento ',actual.departamento);
        while (info.departamento=actual.departamento) do begin
            actual:=info;
            montoTotalDivision:=0;
            totalHorasDivision:=0;
            writeln(#13#10,'Division: ',actual.division);
            while (info.departamento=actual.departamento) and (info.division=actual.division) do begin
                actual:=info;
                montoTotalEmpleado:=0;
                totalHorasEmpleado:=0;
                while (info.departamento=actual.departamento) and (info.division=actual.division) and (info.numero=actual.numero) do begin
                    totalHorasEmpleado+=actual.horas;
                    totalHorasDepartamento+=actual.horas;
                    totalHorasDivision+=actual.horas;
                    leer(m,info);
                end;
                montoTotalEmpleado:=vectorHoras[actual.categoria] * totalHorasEmpleado;
                writeln('Numero de empleado      Total de hs.    Importe a cobrar');
                writeln(actual.numero,'                         ',totalHorasEmpleado,'                ',montoTotalEmpleado:0:2);
                montoTotalDivision+=montoTotalEmpleado;
            end;
            writeln('Total de horas por division: ',totalHorasDivision);
            writeln('Monto total por division: ',montoTotalDivision:0:2);
            montoTotalDepartamento+=montoTotalDivision;
        end;
        writeln('Total horas departamento: ',totalHorasDepartamento);
        writeln('Monto total departamento: ',montoTotalDepartamento:0:2);
    end;
    close(m);
end;

var
    maestro:archivoMaestro;
    vectorHoras: archivoCategorias;
    i:integer;

begin
    randomize;
    assign(maestro,'ArchivoMaestroEjercicio10');
    //cargarArchivoMaestro(maestro);
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);
    cargarVectorHoras(vectorHoras);
    recorrerArchivo(maestro,vectorHoras);
end.