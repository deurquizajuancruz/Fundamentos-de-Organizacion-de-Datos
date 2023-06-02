program Ejercicio7Practica3;
const
    valoralto=999;
type
    info = record
        codigo:integer;
        nombreEspecie:string;
        familiaAve:string;
        descripcion:string;
        zonaGeografica:string;
    end;
    archivo = file of info;

{ARCHIVO: SE DISPONE
function randomString():string;
var
    i:integer;
begin
    setLength(randomString,3);
    for i := 1 to 3 do randomString[i]:=chr(random(26)+97);        
end;

procedure leerInfo(var ave:info);
begin
    writeln('Ingresa codigo: ');readln(ave.codigo);
    if (ave.codigo<>0) then begin
        ave.nombreEspecie:=randomString();    
        ave.familiaAve:=randomString();    
        ave.descripcion:=randomString();    
        ave.zonaGeografica:=randomString();    
    end;    
end;

procedure cargarArchivo(var name:archivo);
var
    ave:info;
begin
    rewrite(name);
    leerInfo(ave);
    while (ave.codigo<>0) do begin
        write(name,ave);
        leerInfo(ave);    
    end;
    close(name);
end;}

procedure imprimirArchivo(var name:archivo);
var
    ave:info;
begin
    reset(name);
    while (not eof(name)) do begin
        read(name,ave);
        writeln('Info ave. Codigo: ',ave.codigo,' Nombre especie: ',ave.nombreEspecie,' Familia ave: ',ave.familiaAve,' Descripcion: ',ave.descripcion,' Zona geografica: ',ave.zonaGeografica);
    end;
    close(name);
end;

procedure bajaLogica(var name:archivo);
var
    ave:info;
    codigoBorrar:integer;
    encontrado:boolean;
begin
    writeln('Ingrese el codigo del ave a borrar: ');
    readln(codigoBorrar);
    while (codigoBorrar<>5000) do begin //tendria que ser 500.000 pero no esta en el rango de los integers y le puse 5000
        reset(name);
        encontrado:=false;
        while (not eof(name) and (not encontrado)) do begin
            read(name,ave);
            if (ave.codigo=codigoBorrar) then 
                encontrado:=true;
        end;
        if (encontrado) then begin
            ave.codigo:=-1;
            seek(name,filepos(name)-1);
            write(name,ave);
        end
        else 
            writeln('No se encontro un ave con ese codigo');
        writeln('Ingrese el codigo del ave a borrar: ');
        readln(codigoBorrar);
        close(name);
    end;    
end;

procedure leer(var name:archivo;var ave:info);
begin
    if (not eof(name)) then 
        read(name,ave)
    else 
        ave.codigo:=valoralto;
end;

procedure bajaFisica(var name:archivo);
var
    ave:info;
    posicion:integer;
begin
    reset(name);
    leer(name,ave);
    while (ave.codigo<>valoralto) do begin
        if (ave.codigo<0) then begin
            posicion:=filepos(name)-1;
            seek(name,filesize(name)-1);
            read(name,ave);
            while (ave.codigo<0) and ((filepos(name)-1)<>0)do begin
                seek(name,filesize(name)-1);
                truncate(name);
                seek(name,filesize(name)-1);
                read(name,ave);
            end;
            seek(name,posicion);
            write(name,ave);
            seek(name,filesize(name)-1);
            truncate(name);
            seek(name,posicion);
        end;
        leer(name,ave);
    end;
    close(name);
end;

var
    name:archivo;
begin
    randomize;
    assign(name,'ArchivoEjercicio7');
    {writeln('CARGANDO ARCHIVO: ');
    cargarArchivo(name);}
    writeln('ARCHIVO SIN BAJAS: ');
    imprimirArchivo(name);
    bajaLogica(name);
    writeln('ARCHIVO CON BAJAS LOGICAS: ');
    imprimirArchivo(name);
    bajaFisica(name);
    writeln('ARCHIVO CON BAJAS FISICAS: ');
    imprimirArchivo(name);
end.