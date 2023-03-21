program Ejercicio3Practica1;

{const
    len = 3;}

type
    empleado = record
        num:integer;
        apellido:string;
        nombre:string;
        edad:integer;
        dni:string;
    end;
    archivo = file of empleado;

{procedure randomString(var s: string);
var 
    i:integer;
begin
    setLength(s,len);
    for i:=1 to len do begin
        s[i]:=chr(random(26)+97);
    end;
end;}

procedure imprimirEmpleado(e:empleado);
begin
    writeln('Empleado numero ',e.num,' llamado ',e.nombre,' ',e.apellido, ' con ',e.edad,' anios y DNI ',e.dni);
end;

procedure cargarEmpleados(var f: archivo;var creado:boolean);
var
    e:empleado;
    fisico:string;
begin
    writeln('Ingrese el nombre del archivo: ');
    readln(fisico);
    assign(f,fisico);
    rewrite(f);
    creado:=true;
    writeln('Ingrese apellido del empleado:');readln(e.apellido);//randomString(e.apellido);
    while (e.apellido<>'fin') do begin
        writeln('Ingrese numero de empleado:');readln(e.num);//e.num:=random(50)+1;
        writeln('Ingrese nombre del empleado:');readln(e.nombre);//randomString(e.nombre);
        writeln('Ingrese edad del empleado:');readln(e.edad);//e.edad:=random(60)+20;
        writeln('Ingrese DNI del empleado:');readln(e.dni);//randomString(e.dni);
        write(f,e);
        writeln('Ingrese apellido del empleado:');readln(e.apellido);//randomString(e.apellido);
    end;
    close(f);
end;

procedure determined(var name:archivo);
var
    busqueda:string;
    e:empleado;
begin
    reset(name);
    writeln('Ingrese el nombre o apellido a buscar: ');readln(busqueda);
    while (not eof(name)) do begin
        read(name,e);
        if ((e.nombre=busqueda) or (e.apellido=busqueda)) then imprimirEmpleado(e);
    end;
    close(name);
end;

procedure allEmployees(var name:archivo);
var
    e:empleado;
begin
    reset(name);
    while (not eof(name)) do begin
        read(name,e);
        imprimirEmpleado(e);
    end;
    close(name);
end;

procedure opciones(var o:integer;creado:boolean);
begin
    if (creado) then begin
        writeln('Ingrese una opcion: ',#13#10, 
        'Opcion 1: Crear un archivo de registros no ordenados de empleados y completarlo con datos ingresados desde teclado.',#13#10,
        'Opcion 2: Abrir el archivo anteriormente generado y listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.',#13#10,
        'Opcion 3: Abrir el archivo anteriormente generado y listar en pantalla los empleados de a uno por linea.',#13#10,
        'Opcion 4: Abrir el archivo anteriormente generado y listar en pantalla empleados mayores de 70 anios, proximos a jubilarse.');
        readln(o);
    end
    else begin
        writeln('Ingrese una opcion: ',#13#10, 
        'Opcion 1: Crear un archivo de registros no ordenados de empleados y completarlo con datos ingresados desde teclado.');
        readln(o);
    end;
end;

procedure olderThanSeventy(var name:archivo);
var
    e:empleado;
begin
    reset(name);
    while (not eof(name)) do begin
        read(name,e);
        if (e.edad>70) then imprimirEmpleado(e);
    end;
    close(name);
end;

var
    opcion:integer;
    logico: archivo;
    creado:boolean;

begin
    //Randomize;
    creado:=false;
    opciones(opcion,creado);
    while (opcion<5) do begin
        case opcion of
            1: cargarEmpleados(logico,creado);
            2: determined(logico);
            3: allEmployees(logico);
            4: olderThanSeventy(logico);
        end;
        opciones(opcion,creado);
    end;
end.