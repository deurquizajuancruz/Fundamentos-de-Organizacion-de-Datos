program Ejercicio2Practica3;
type
    infoArchivo = record
        numero:integer;
        apellido:string;
        nombre:string;
        email:string;
        telefono:string;
        dni:string;
    end;

    archivo = file of infoArchivo;

function randomString(len:integer):string;
var
    i:integer;
begin
    setLength(randomString,len);
    for i := 1 to len do randomString[i]:=chr(random(26)+97);
end;

procedure leerAsistente(var a:infoArchivo);
begin
    writeln('Ingrese numero de asistente: ');readln(a.numero);
    //a.numero:=random(10);
    if (a.numero<>0) then begin
        writeln('Ingrese apellido: ');readln(a.apellido);
        //a.apellido:=randomString(10);
        writeln('Ingrese nombre: ');readln(a.nombre);
        //a.nombre:=randomString(8);
        writeln('Ingrese email: ');readln(a.email);
        //a.email:=randomString(20);
        writeln('Ingrese telefono: ');readln(a.telefono);
        //a.telefono:=randomString(10);
        writeln('Ingrese DNI: ');readln(a.dni);
        //a.dni:=randomString(8);
    end;    
end;

procedure crearArchivo(var name:archivo);
var
    a:infoArchivo;
begin
    rewrite(name);
    leerAsistente(a);
    while (a.numero<>0) do begin
        write(name,a);
        leerAsistente(a);
    end;
    close(name);
end;

procedure imprimirArchivo(var name:archivo);
var
    a:infoArchivo;
begin
    reset(name);
    while (not eof(name)) do begin
        read(name,a
        if (a.nombr//e[1]<>'@') then 
            writeln('Asistente numero ',a.numero,' llamado ',a.nombre,',',a.apellido,'. Email: ',a.email,' Telefono: ',a.telefono,' DNI: ',a.dni);
    end;
    close(name);
end;

procedure bajaLogica(var name:archivo);
var
    asistente:infoArchivo;
begin
    reset(name);
    while (not eof(name)) do begin
        read(name,asistente);
        if (asistente.numero<1000) then begin
            asistente.nombre:='@' + asistente.nombre;
            seek(name,filepos(name)-1);
            write(name,asistente);
        end;
    end;
    close(name);
end;

var
    arch:archivo;
begin
    randomize;
    assign(arch,'ArchivoEjercicio2');
    //crearArchivo(arch);
    bajaLogica(arch);
    writeln('Archivo: ');
    imprimirArchivo(arch);
end.