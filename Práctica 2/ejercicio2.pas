program Ejercicio2Practica2;
const 
    valoralto=999;
type
    alumno = record
        codigo:integer;
        apellido:string;
        nombre:string;
        sinFinal:integer;
        conFinal:integer;
    end;
    infoDetalle = record
        codigo:integer;
        nota:integer;
    end;
    detalle = file of infoDetalle;
    maestro = file of alumno;

//ARCHIVO MAESTRO CON LOS DATOS DE LOS ALUMNOS: SE DISPONE

{procedure randomString(var s: string);
var 
    i:integer;
begin
    setLength(s,3);
    for i:=1 to 3 do begin
        s[i]:=chr(random(26)+97);
    end;
end;

procedure cargarAlumno(var a:alumno);
begin
    writeln('Ingrese el codigo del alumno: ');readln(a.codigo);
    if (a.codigo<>0) then begin
        randomString(a.nombre);
        randomString(a.apellido);
        a.sinFinal:=Random(10)+1;
        a.conFinal:=Random(10)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:maestro);
var
    a:alumno;

begin
    rewrite(m);
    cargarAlumno(a);
    while (a.codigo<>0) do begin
        write(m,a);
        cargarAlumno(a);
    end;
    close(m);
end;

procedure imprimirArchivo(var name:maestro);
var
    a:alumno;

begin
    reset(name);
    while (not eof(name)) do begin
        read(name,a);
        writeln('Codigo de alumno: ',a.codigo,'. Nombre: ',a.nombre,'. Apellido: ',a.apellido,'. Materias aprobadas con final: ',a.conFinal,'. Materias aprobadas sin final: ',a.sinFinal);
    end;
    close(name);
end;

//ARCHIVO DETALLE CON CODIGO DE ALUMNO E INFO DE UNA MATERIA: SE DISPONE

procedure cargarAlumnoDetalle(var i:infoDetalle);
begin
    writeln('Ingrese codigo del alumno: ');readln(i.codigo);
    if (i.codigo<>0) then i.nota:=random(10)+1;
end;

procedure cargarArchivoDetalle(var name:detalle);
var
    i:infoDetalle;
begin
    assign(name,'ArchivoDetalleEjercicio2');
    rewrite(name);
    cargarAlumnoDetalle(i);
    while(i.codigo<>0) do begin
        write(name,i);
        cargarAlumnoDetalle(i);
    end;
    close(name);
end;

procedure imprimirDetalle(var name:detalle);
var
    i:infoDetalle;

begin
    reset(name);
    while (not eof(name)) do begin
        read(name,i);
        writeln('Codigo de alumno: ',i.codigo,'. Nota de la materia: ',i.nota);
    end;
    close(name);
end;}

//ACTUALIZACION DE ARCHIVO MAESTRO CON ARCHIVO DETALLE: OPCION 1

procedure leer(var name:detalle;var i:infoDetalle);
begin
    if (not eof(name)) then 
        read(name,i)
    else 
        i.codigo:=valoralto;
end;

procedure actualizarMaestro(var m:maestro; var d:detalle);
var
    i:infoDetalle;
    a:alumno;
begin
    reset(m);
    reset(d);
    leer(d,i);
    while (i.codigo<>valoralto) do begin
        read(m,a);
        while(i.codigo<>a.codigo) do
            read(m,a);
        while (i.codigo=a.codigo) do begin
            if (i.nota>=6) then 
                a.conFinal+=1
            else if (i.nota>=4) then 
                a.sinFinal+=1;
            leer(d,i);
        end;
        seek(m,filepos(m)-1);
        write(m,a);
    end;
    close(m);reset(d);
end;

//LISTAR EN UN TXT ALUMNOS CON MAS DE 4 MATERIAS SIN FINAL: OPCION 2

procedure listarTxt(var name:maestro);
var
    txt:text;
    nombre:string;
    a:alumno;
begin
    reset(name);
    writeln('Ingresa el nombre del archivo .txt: ');
    readln(nombre);
    nombre+='.txt';
    assign(txt,nombre);
    rewrite(txt);
    while (not eof(name)) do begin
        read(name,a);
        if (a.sinFinal>4) then 
            write(txt,'Alumno con código: ',a.codigo,', nombre ',a.nombre,', apellido ',a.apellido,' aprobó ',a.sinFinal,' materias sin tener el final aprobado y ',a.conFinal,' materias con el final aprobado.',#13#10);
    end;
    writeln('Archivo exportado a ',nombre);
    close(name);
    close(txt);
end;

procedure opciones(var opcion:integer);
begin
    writeln('Ingrese una opcion: ', #13#10 ,
    'Opcion 1: Actualizar el archivo maestro con el archivo detalle',#13#10,
    'Opcion 2: Listar en un archivo de texto los alumnos que tengan mas de cuatro materias con cursada aprobada pero no aprobaron el final.');
    readln(opcion);
end;

var
    master:maestro;
    det:detalle;
    opcion:integer;
begin
    {Randomize;
    assign(master,'ArchivoMaestroEjercicio2');
    cargarArchivoMaestro(master);
    writeln('Archivo maestro: ');
    imprimirArchivo(master);
    cargarArchivoDetalle(det);
    writeln('Archivo detalle: ');
    imprimirDetalle(det);}
    assign(det,'ArchivoDetalleEjercicio2');
    opciones(opcion);
    while (opcion<3) do begin
        case opcion of
            1: actualizarMaestro(master,det);
            2: listarTxt(master);
        end;
        //imprimirArchivo(master);
        opciones(opcion);
    end;
end.