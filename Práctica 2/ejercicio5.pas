program Ejercicio5Practica2;
const
    valoralto=999;
type
    direccion = record
        calle:string;
        numero:integer;
        piso:integer;
        depto:integer;
        ciudad:string;
    end;
    
    infoDetalleNacimiento = record
        numeroPartida:integer;
        nombre:string;
        apellido:string;
        direc:direccion;
        matriculaMedico:string;
        nombreApellidoMadre:string;
        dniMadre:integer;
        nombreApellidoPadre:string;
        dniPadre:integer;
    end;
    
    infoDetalleFallecimiento = record
        numeroPartida:integer;
        dni:integer;
        nombreApellido:string;
        matriculaMedico:string;
        fechaHora:string;
        lugar:string;
    end;

    infoMaestro = record
        numeroPartida:integer;
        nombre:string;
        apellido:string;
        direc:direccion;
        matriculaMedico:string;
        nombreApellidoMadre:string;
        dniMadre:integer;
        nombreApellidoPadre:string;
        dniPadre:integer;
        fallecido:boolean;
        matriculaMedicoFallecido:string;
        fechaHora:string;
        lugar:string;
    end;

    archivoDetalleNacimiento = file of infoDetalleNacimiento;
    archivoDetalleFallecimiento = file of infoDetalleFallecimiento;
    archivoMaestro = file of infoMaestro;
    arrayNacimientos = array [1..50] of archivoDetalleNacimiento;
    arrayFallecimientos = array [1..50] of archivoDetalleFallecimiento;
    arrayRegistrosNacimientos = array[1..50] of infoDetalleNacimiento;
    arrayRegistrosFallecimientos = array [1..50] of infoDetalleFallecimiento;

{
function randomString():string;
var
    i:integer;
    s:string;
begin
    setLength(s,3);
    for i := 1 to 3 do begin
        s[i]:=chr(random(26)+97);
    end;
    randomString:=s;
end;

//ARCHIVOS DETALLES CON INFORMACION DE NACIMIENTO: SE DISPONE

procedure cargarNacimiento(var nacimiento:infoDetalleNacimiento);
begin
    writeln('Ingrese numero de partida: ');readln(nacimiento.numeroPartida);
    if (nacimiento.numeroPartida<>0) then begin
        nacimiento.nombre:=randomString();
        nacimiento.apellido:=randomString();
        nacimiento.direc.numero:=random(100)+1;
        nacimiento.direc.calle:=randomString();
        nacimiento.direc.piso:=random(10)+1;
        nacimiento.direc.depto:=random(50)+1;
        nacimiento.direc.ciudad:=randomString();
        nacimiento.matriculaMedico:=randomString();
        nacimiento.nombreApellidoMadre:=randomString();
        nacimiento.dniMadre:=random(500)+1;
        nacimiento.nombreApellidoPadre:=randomString();
        nacimiento.dniPadre:=random(500)+1;
    end;
end;

procedure cargarArchivoNacimiento(var name:archivoDetalleNacimiento;num:integer);
var
    nombre,numString:string;
    d:infoDetalleNacimiento;
    
begin
    nombre:='ArchivoDetalleNacimientoEjercicio5Numero';
    str(num,numString);
    nombre+=numString;
    assign(name,nombre);
    rewrite(name);
    cargarNacimiento(d);
    while (d.numeroPartida<>0) do begin
        write(name,d);
        cargarNacimiento(d);
    end;
    close(name);
end;

//ARCHIVOS DETALLES CON INFORMACION DE FALLECIMIENTO: SE DISPONE

procedure cargarFallecimiento(var f:infoDetalleFallecimiento);
begin
    writeln('Ingrese numero de partida: ');readln(f.numeroPartida);
    if (f.numeroPartida<>0) then begin
        f.dni:=random(400)+1;
        f.nombreApellido:=randomString();
        f.matriculaMedico:=randomString();
        f.fechaHora:=randomString();
        f.lugar:=randomString();
    end;
end;

procedure cargarArchivoFallecimiento(var name:archivoDetalleFallecimiento;num:integer);
var
    nombre,numString:string;
    d:infoDetalleFallecimiento;

begin
    nombre:='ArchivoDetalleFallecimientoEjercicio5Numero';
    str(num,numString);
    nombre+=numString;
    assign(name,nombre);
    rewrite(name);
    cargarFallecimiento(d);
    while (d.numeroPartida<>0) do begin
        write(name,d);
        cargarFallecimiento(d);
    end;
    close(name);
end;
}

procedure imprimirArchivoNacimiento(var nacimiento:archivoDetalleNacimiento;num:integer);
var
    n:infoDetalleNacimiento;

begin
    reset(nacimiento);
    writeln('------------');
    writeln('Informacion del archivo detalle nacimiento numero ',num);
    while (not eof(nacimiento)) do begin
        read(nacimiento,n);
        writeln('Numero de partida: ',n.numeroPartida,#13#10,
        'Nombre y apellido: ',n.nombre,' ',n.apellido,#13#10,
        'Direccion: ',#13#10,
        'Calle ',n.direc.calle,' numero ',n.direc.numero,' piso ',n.direc.piso,' departamento ',n.direc.depto,' ciudad ',n.direc.ciudad,#13#10,
        'Matricula del medico: ',n.matriculaMedico,#13#10,
        'Madre: ',n.nombreApellidoMadre,' ',n.dniMadre,#13#10,
        'Padre: ',n.nombreApellidoPadre,' ',n.dniPadre);
        writeln('-----------------');
    end;
    close(nacimiento);    
end;

procedure imprimirArchivoFallecimiento(var f:archivoDetalleFallecimiento;num:integer);
var
    m:infoDetalleFallecimiento;

begin
    reset(f);
    writeln('------------');
    writeln('Informacion del archivo detalle fallecimiento numero ',num);
    while (not eof(f)) do begin
        read(f,m);
        writeln('Numero de partida: ',m.numeroPartida,#13#10,
        'DNI: ',m.dni,#13#10,
        'Nombre y apellido: ',m.nombreApellido,#13#10,
        'Matricula del medico que firmo el deceso: ',m.matriculaMedico,#13#10,
        'Fecha y hora de la muerte: ',m.fechaHora,#13#10,
        'Lugar de la muerte: ',m.lugar);
        writeln('------------');
    end;
    close(f);
end;

procedure asignacionArchivosDetalles(var nacido:archivoDetalleNacimiento;var fallecido:archivoDetalleFallecimiento;num:integer);
var
    nombre,numString:string;

begin
    nombre:='ArchivoDetalleNacimientoEjercicio5Numero';
    str(num,numString);
    nombre+=numString;
    assign(nacido,nombre);
    nombre:='ArchivoDetalleFallecimientoEjercicio5Numero';
    nombre+=numString;
    assign(fallecido,nombre);
end;

procedure leerNacimiento(var name:archivoDetalleNacimiento;var n:infoDetalleNacimiento);
begin
    if (not eof(name)) then read(name,n)
    else n.numeroPartida:=valoralto;
end;

procedure leerFallecimiento(var name:archivoDetalleFallecimiento; var f:infoDetalleFallecimiento);
begin
    if (not eof(name)) then read(name,f)
    else f.numeroPartida:=valoralto;
end;

procedure inicializarArchivosDetalles(var nacimientos:arrayNacimientos; var fallecimientos:arrayFallecimientos; var registrosN: arrayRegistrosNacimientos; var registrosF:arrayRegistrosFallecimientos);
var
    i:integer;

begin
    for i := 1 to 50 do begin
        reset(nacimientos[i]);
        reset(fallecimientos[i]);
        leerNacimiento(nacimientos[i],registrosN[i]);
        leerFallecimiento(fallecimientos[i],registrosF[i]);
    end;
end;

procedure cerrarArchivosDetalles(var n:arrayNacimientos;f:arrayFallecimientos);
var
    i:integer;

begin
    for i := 1 to 50 do begin
        close(n[i]);
        close(f[i]);
    end;
end;

procedure buscarMinimoN(var nacimientos:arrayNacimientos;var registrosN:arrayRegistrosNacimientos;var min:infoDetalleNacimiento);
var
    i,minPos:integer;
begin
    min.numeroPartida:=valoralto;
    for i:= 1 to 50 do begin
        if (registrosN[i].numeroPartida<>valoralto) then begin
            if (registrosN[i].numeroPartida<min.numeroPartida) then begin
                min:=registrosN[i];
                minPos:=i;
            end;
        end;
    end;
    if (min.numeroPartida<>valoralto) then leerNacimiento(nacimientos[minPos],registrosN[minPos]);
end;

procedure buscarMinimoF(var fallecimientos:arrayFallecimientos;var registrosF:arrayRegistrosFallecimientos;var min:infoDetalleFallecimiento);
var
    i,minPos:integer;

begin
    min.numeroPartida:=valoralto;
    for i := 1 to 50 do begin
        if (registrosF[i].numeroPartida<>valoralto) then begin
            if (registrosF[i].numeroPartida<min.numeroPartida) then begin
                min:=registrosF[i];
                minPos:=i;
            end;
        end;
    end;
    if (min.numeroPartida<>valoralto) then leerFallecimiento(fallecimientos[minPos],registrosF[minPos]);
end;

procedure crearArchivoMaestro(var maestro:archivoMaestro;var nacimientos:arrayNacimientos; var fallecimientos:arrayFallecimientos);
var
    registrosN:arrayRegistrosNacimientos;
    registrosF:arrayRegistrosFallecimientos;
    minN:infoDetalleNacimiento;
    minF:infoDetalleFallecimiento;
    actual:infoMaestro;

begin
    assign(maestro,'ArchivoMaestroEjercicio5');
    rewrite(maestro);
    inicializarArchivosDetalles(nacimientos,fallecimientos,registrosN,registrosF); //abro todos los archivos detalles de nacimiento y guardo en un vector de registros el primer dato de cada archivo
    buscarMinimoN(nacimientos,registrosN,minN); // buscar el nro de partida minimo en archivo detalle de nacimiento
    buscarMinimoF(fallecimientos,registrosF,minF);// buscar el nro de partida minimo en archivo detalle de fallecimiento
    while (minN.numeroPartida<>valoralto) do begin
        actual.numeroPartida:=minN.numeroPartida; actual.nombre:=minN.nombre; actual.apellido:=minN.apellido; actual.direc:=minN.direc; actual.matriculaMedico:=minN.matriculaMedico; actual.nombreApellidoMadre:=minN.nombreApellidoMadre; actual.dniMadre:=minN.dniMadre; actual.nombreApellidoPadre:=minN.nombreApellidoPadre; actual.dniPadre:=minN.dniPadre;
        if (minN.numeroPartida=minF.numeroPartida) then begin // si se encontro la persona fallecida
            actual.fallecido:=true; actual.matriculaMedicoFallecido:=minF.matriculaMedico; actual.fechaHora:=minF.fechaHora; actual.lugar:=minF.lugar;
        end
        else begin // si no se encontro, tengo q volver a la posicion siguiente en los registros de fallecimiento
            actual.fallecido:=false;
        end;
        write(maestro,actual); // agregar la info al archivo maestro
        buscarMinimoN(nacimientos,registrosN,minN);
        if (actual.fallecido) then buscarMinimoF(fallecimientos,registrosF,minF);
    end;
    cerrarArchivosDetalles(nacimientos,fallecimientos);
    close(maestro);
end;

procedure imprimirArchivoMaestro(var name:archivoMaestro);
var
    info:infoMaestro;
begin
    reset(name);
    while(not eof(name)) do begin
        read(name,info);
        writeln('-----------------');
        writeln('Numero de partida: ',info.numeroPartida,#13#10,
        'Nombre y apellido: ',info.nombre,' ',info.apellido,#13#10,
        'Direccion: ',#13#10,
        'Calle ',info.direc.calle,' numero ',info.direc.numero,' piso ',info.direc.piso,' departamento ',info.direc.depto,' ciudad ',info.direc.ciudad,#13#10,
        'Matricula del medico: ',info.matriculaMedico,#13#10,
        'Info madre: ',info.nombreApellidoMadre, ' DNI ',info.dniMadre,#13#10,
        'Info padre: ',info.nombreApellidoPadre, ' DNI ',info.dniPadre);
        if (info.fallecido) then begin
            writeln('Fallecido en ',info.lugar,' a las ',info.fechaHora,' deceso firmado por ',info.matriculaMedicoFallecido);
        end;
    end;
    close(name);
end;

procedure exportarArchivoMaestroTxt(var maestro:archivoMaestro);
var
    txt:text;
    info:infoMaestro;

begin
    reset(maestro);
    assign(txt,'ArchivoMaestroPersonasEjercicio5.txt');
    rewrite(txt);
    write(txt,'Informacion de personas: ',#13#10);
    while (not eof(maestro)) do begin
        read(maestro,info);
        write(txt,'Numero de partida: ',info.numeroPartida,#13#10,
        'Nombre y apellido: ',info.nombre,' ',info.apellido,#13#10,
        'Direccion: ',#13#10,
        'Calle ',info.direc.calle,' numero ',info.direc.numero,' piso ',info.direc.piso,' departamento ',info.direc.depto,' ciudad ',info.direc.ciudad,#13#10,
        'Matricula del medico: ',info.matriculaMedico,#13#10,
        'Info madre: ',info.nombreApellidoMadre, ' DNI ',info.dniMadre,#13#10,
        'Info padre: ',info.nombreApellidoPadre, ' DNI ',info.dniPadre,#13#10);
        if (info.fallecido) then begin
            write(txt,'Fallecido en ',info.lugar,' a las ',info.fechaHora,' deceso firmado por ',info.matriculaMedicoFallecido,#13#10);
        end;
        write(txt,'------------',#13#10);
    end;
    writeln('Archivo maestro exportado a txt');
    close(maestro);close(txt);
end;

var
    i:integer;
    vectorFallecidos:arrayFallecimientos;
    vectorNacidos:arrayNacimientos;
    maestro:archivoMaestro;

begin
    randomize;
    for i := 1 to 50 do begin
        {writeln('Cargando archivo detalle nacimiento numero ',i);
        cargarArchivoNacimiento(vectorNacidos[i],i);
        writeln('Cargando archivo detalle fallecimiento numero ',i);
        cargarArchivoFallecimiento(vectorFallecidos[i],i);}
        asignacionArchivosDetalles(vectorNacidos[i],vectorFallecidos[i],i);
        imprimirArchivoNacimiento(vectorNacidos[i],i);
        imprimirArchivoFallecimiento(vectorFallecidos[i],i);
    end;
    crearArchivoMaestro(maestro,vectorNacidos,vectorFallecidos);
    writeln('-----------------');
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);
    exportarArchivoMaestroTxt(maestro);
end.