program Ejercicio1Practica3;
type
    empleado = record
        num:integer;
        apellido:string;
        nombre:string;
        edad:integer;
        dni:string;
    end;
    archivo = file of empleado;

function randomString():string;
var
    i:integer;
begin
    setLength(randomString,3);
    for i := 1 to 3 do 
        randomString[i]:=chr(random(26)+97);        
end;

procedure leerEmpleado(var e: empleado);
begin
    writeln('Ingrese apellido del empleado:');readln(e.apellido);
    //e.apellido:=randomString();
    if (e.apellido<>'fin') then begin
        writeln('Ingrese numero de empleado:');readln(e.num);
        //e.num:=random(200)+1;
        writeln('Ingrese nombre del empleado:');readln(e.nombre);
        //e.nombre:=randomString();
        writeln('Ingrese edad del empleado:');readln(e.edad);
        //e.edad:=random(60)+20;
        writeln('Ingrese DNI del empleado:');readln(e.dni);
        //e.dni:=randomString();
    end;    
end;

procedure cargarEmpleados(var f: archivo);
var
    e:empleado;
begin
    assign(f,'ArchivoEjercicio1');
    rewrite(f);
    leerEmpleado(e);
    while (e.apellido<>'fin') do begin
        write(f,e);
        leerEmpleado(e);
    end;
    writeln('Archivo creado con exito.');
    close(f);
end;

//MENU DE OPCIONES
procedure opciones(var o:integer;creado:boolean);
begin
    if (creado) then begin
        writeln('Ingrese una opcion: ',#13#10, 
        'Opcion 1: Crear un archivo de registros no ordenados de empleados y completarlo con datos ingresados desde teclado.',#13#10,
        'Opcion 2: Abrir el archivo anteriormente generado y listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.',#13#10,
        'Opcion 3: Abrir el archivo anteriormente generado y listar en pantalla los empleados de a uno por linea.',#13#10,
        'Opcion 4: Abrir el archivo anteriormente generado y listar en pantalla empleados mayores de 70 anios, proximos a jubilarse.',#13#10,
        'Opcion 5: Agregar uno o mas empleados al final del archivo.',#13#10,
        'Opcion 6: Modificar edad a uno o mas empleados.',#13#10,
        'Opcion 7: Exportar el contenido del archivo a un archivo de texto llamado todos_empleados.txt.',#13#10,
        'Opcion 8: Exportar a un archivo de texto llamado: faltaDNIEmpleado.txt, los empleados que no tengan cargado el DNI.',#13#10,
        'Opcion 9: Realizar bajas de empleados.');
        readln(o);
    end
    else begin
        writeln('Ingrese una opcion: ',#13#10, 
        'Opcion 1: Crear un archivo de registros no ordenados de empleados y completarlo con datos ingresados desde teclado.');
        readln(o);
    end;
end;

procedure imprimirEmpleado(e:empleado);
begin
    writeln('Empleado numero ',e.num,' llamado ',e.nombre,' ',e.apellido, ' con ',e.edad,' anios y DNI ',e.dni);
end;

//BI: APELLIDO O NOMBRE DETERMINADO
procedure determined(var name:archivo);
var
    busqueda:string;
    e:empleado;
begin
    reset(name);
    writeln('Ingrese el nombre o apellido a buscar: ');readln(busqueda);
    while (not eof(name)) do begin
        read(name,e);
        if ((e.nombre=busqueda) or (e.apellido=busqueda)) then 
            imprimirEmpleado(e);
    end;
    close(name);
end;

//BII: TODOS LOS EMPLEADOS
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

//BIII: EMPLEADOS MAYORES A 70
procedure olderThanSeventy(var name:archivo);
var
    e:empleado;
begin
    reset(name);
    while (not eof(name)) do begin
        read(name,e);
        if (e.edad>70) then 
            imprimirEmpleado(e);
    end;
    close(name);
end;

//4A: AGREGAR EMPLEADOS QUE NO EXISTAN
function existeEmpleado(numero:integer; var name:archivo):boolean;
var
    e:empleado;
begin
    existeEmpleado:=false;
    while (not eof(name)) do begin
        read(name,e);
        if (e.num=numero) then 
            existeEmpleado:=true;
    end;
end;

procedure updateEmpleados(var name:archivo);
var
    e:empleado;
begin
    reset(name);
    leerEmpleado(e);
    while (e.apellido<>'fin') do begin
        if (not existeEmpleado(e.num,name)) then begin
            seek(name,filesize(name)); // ultima posicion del archivo
            write(name,e); //escribo el nuevo empleado a lo ultimo
        end;
        leerEmpleado(e);
    end;
    close(name);
end;

//4B: MODIFICAR EDAD A UNO O MAS EMPLEADOS
procedure modificarEdad(var name:archivo);
var
    e:empleado;
    modificado:boolean;
    nuevaedad,numeroBuscar:integer;
begin
    modificado:=false;
    reset(name);
    write('Ingrese el numero del empleado para modificarle su edad: ');
    readln(numeroBuscar);
    while (not eof(name) and (modificado=false)) do begin
        read(name,e);
        if (e.num=numeroBuscar) then begin
            writeln('Ingrese nueva edad para el empleado: ');
            readln(nuevaedad);
            e.edad:=nuevaedad;
            seek(name, filepos(name)-1);
            write(name,e);
            modificado:=true;
        end;
    end;
    if (not modificado) then writeln('No existe un empleado con ese numero.');
    close(name);
end;

//4C: EXPORTAR CONTENIDO A UN TXT
procedure exportTxt(var name:archivo);
var
    texto:Text;
    e: empleado;
begin
    assign(texto,'todos_empleados.txt');
    rewrite(texto);
    reset(name);
    while (not eof(name)) do begin
        read(name,e);
        write(texto,'Empleado número ',e.num,' llamado ',e.nombre,' ',e.apellido, ' con ',e.edad,' años y DNI ',e.dni,'.', #13#10);
    end;
    close(name);
    close(texto);
end;

//4D: EXPORTAR EMPLEADOS CON DNI 0 A TXT 
procedure missingDNI(var name:archivo);
var
    texto:text;
    e:empleado;
begin
    assign(texto,'faltaDNIEmpleado.txt');
    rewrite(texto);
    reset(name);
    while(not eof(name)) do begin
        read(name,e);
        if (e.dni='00') then 
            write(texto,'Al empleado número ',e.num,' llamado ',e.nombre,' ',e.apellido, ' con ',e.edad,' años le falta DNI.', #13#10);
    end;
    close(name);
    close(texto);
end;

//REALIZAR BAJAS
procedure bajaFisica(var name:archivo);
var
    e,aux:empleado;
    numeroEliminar:integer;
begin
    reset(name);
    write('Ingrese el numero del empleado que desea eliminar: ');
    readln(numeroEliminar);
    seek(name, fileSize(name)-1); // ultimo registro
	read(name, aux); // guardo el ultimo registro en aux
	seek(name, 0);	 //principio
	read(name, e);	 // busco al empleado
	while (not eof(name)) and (e.num <> numeroEliminar) do // avanzo en el archivo mientras no lo encuentro
		read(name, e);        
    if (e.num=numeroEliminar) then begin //si lo encontre:
        seek(name, filePos(name)-1);	// Me posiciono en la posicion del registro a borrar(una menos de la que estoy parado)
        write(name, aux); // en el registro a borrar, escribo el ultimo registro(aux)
        seek(name, fileSize(name)-1); // ultimo registro: tengo que borrarlo para que no quede repetido
        truncate(name); // borra todos los registros desde la posicion actual del puntero hasta el final del archivo (en este caso solo el ultimo, que ya fue escrito en la posicion del registro a borrar)
        writeln('Se realizo la baja correctamente.')
    end
	else begin
        writeln('No se encontro un empleado con ese numero.');
        close(name);
    end;
end;

var
    logico:archivo;
    opcion:integer;
begin
    randomize;
    opciones(opcion,false);
    while (opcion<10) do begin
        case opcion of
            1: cargarEmpleados(logico);
            2: determined(logico);
            3: allEmployees(logico);
            4: olderThanSeventy(logico);
            5: updateEmpleados(logico);
            6: modificarEdad(logico);
            7: exportTxt(logico);
            8: missingDNI(logico);
            9:bajaFisica(logico);
        end;
        opciones(opcion,true);
    end;
end.