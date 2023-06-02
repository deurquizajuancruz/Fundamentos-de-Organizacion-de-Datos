program Ejercicio8Practica3;
type
    info = record
        nombre:string;
        anioLanzamiento:integer;
        versionKernel:real;
        cantidadDesarrolladores:integer;
        descripcion:string;
    end;
    archivo = file of info;

{ARCHIVO: SE DISPONE
procedure crearArchivo(var name:archivo);
var
    distro:info;
begin
    rewrite(name);
    distro.nombre:='';
    write(name,distro);
    distro:=leerInfo();
    while (distro.nombre<>'zzz') do begin
        write(name,distro);
        distro:=leerInfo();
    end;
    close(name);
end;

function randomString():string;
var
    i:integer;
begin
    setLength(randomString,3);
    for i := 1 to 3 do 
        randomString[i]:=chr(random(26)+97);        
end;}

function leerInfo():info;
begin
    writeln('Ingrese nombre de la distribucion: ');
    readln(leerInfo.nombre);
    if (leerInfo.nombre<>'zzz') then begin
        writeln('Ingresa anio de lanzamiento: ');
        readln(leerInfo.anioLanzamiento);
        //leerInfo.anioLanzamiento:=random(53)+1970;
        writeln('Ingresa version del kernel: ');
        readln(leerInfo.versionKernel);
        //leerInfo.versionKernel:=random()*15;
        writeln('Ingresa cantidad de desarrolladores: ');
        readln(leerInfo.cantidadDesarrolladores);
        //leerInfo.cantidadDesarrolladores:=random(500)+1;
        writeln('Ingresa descripcion: ');
        readln(leerInfo.descripcion);
        //leerInfo.descripcion:=randomString();
    end;
end;

procedure imprimirArchivo(var name:archivo);
var
    distro:info;
begin
    reset(name);
    read(name,distro);
    while(not eof(name)) do begin
        read(name,distro);
        if (distro.cantidadDesarrolladores>0) then 
            writeln('Nombre de la distribucion: ',distro.nombre,'. Anio de lanzamiento: ',distro.anioLanzamiento,'. Version de kernel: ',distro.versionKernel:0:2,'. Cantidad de desarrolladores: ',distro.cantidadDesarrolladores,'. Descripcion: ',distro.descripcion);
    end;
    close(name);
end;

function existeDistribucion(var name:archivo;nombre:string):boolean;
var
    distro:info;
begin
    reset(name);
    existeDistribucion:=false;
    while ((not eof(name)) and (not existeDistribucion)) do begin
        read(name,distro);
        if (distro.nombre=nombre) then 
            existeDistribucion:=true;
    end;
    close(name);
end;

procedure altaDistribucion(var name:archivo);
var
    cabecera,nuevaDistribucion:info;
begin
    writeln('Ingrese los datos de la nueva distribucion.');
    nuevaDistribucion:=leerInfo();
    if (not existeDistribucion(name,nuevaDistribucion.nombre)) then begin
        reset(name);
        read(name,cabecera);
        if (cabecera.cantidadDesarrolladores=0) then begin
            seek(name,filesize(name));
            write(name,nuevaDistribucion);
        end
        else begin
            seek(name,cabecera.cantidadDesarrolladores*-1);
            read(name,cabecera);
            seek(name,filepos(name)-1);
            write(name,nuevaDistribucion);
            seek(name,0);
            write(name,cabecera);
        end;
        close(name);
        writeln('Distribucion dada de alta.');
    end
    else
        writeln('Ya existe la distribucion.');
end;

procedure bajaDistribucion(var name:archivo);
var
    nombreBaja:string;
    distro,cabecera:info;
begin
    writeln('Ingrese el nombre de la distribucion a dar de baja: ');
    readln(nombreBaja);
    if (existeDistribucion(name,nombreBaja)) then begin
        reset(name);
        read(name,cabecera);
        read(name,distro);
        while (distro.nombre<>nombreBaja) do 
            read(name,distro);
        seek(name,filepos(name)-1);
        write(name,cabecera);
        distro.cantidadDesarrolladores:=(filepos(name)-1)*-1;
        seek(name,0);
        write(name,distro);
        close(name);
        writeln('Se elimino la distribucion.');
    end
    else 
        writeln('Distribucion no existente.');
end;

var
    name:archivo;
    nombreExiste:string;
begin
    //randomize;
    assign(name,'ArchivoEjercicio8');
    //crearArchivo(name);
    writeln('Archivo original: ');
    imprimirArchivo(name);
    writeln('Ingrese el nombre de alguna distribucion para verificar si existe');
    readln(nombreExiste);
    if (existeDistribucion(name,nombreExiste)) then 
        writeln('La distribucion con nombre ',nombreExiste,' existe en el archivo.')
    else 
        writeln('La distribucion con nombre ',nombreExiste,' no existe en el archivo.');
    bajaDistribucion(name);
    writeln('Archivo luego de la baja: ');
    imprimirArchivo(name);
    altaDistribucion(name);
    writeln('Archivo con la nueva distribucion: ');
    imprimirArchivo(name);
end.