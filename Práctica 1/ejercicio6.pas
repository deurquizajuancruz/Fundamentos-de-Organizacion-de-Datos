program Ejercicio5Practica1;
type
    celular = record
        codigo:integer;
        nombre:string;
        descripcion:string;
        marca:string;
        precio:real;
        stockMinimo:integer;
        stockDisponible:integer;
    end;
    archivo = file of celular;

procedure opciones(var opcion:integer;creado:boolean);
begin
    if (creado) then begin
        writeln('Ingrese una opcion:',#13#10,
        '1: Crear un archivo de registros no ordenados de celulares y cargarlo con datos ingresados desde un archivo de texto denominado celulares.txt',#13#10,
        '2: Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock minimo.',#13#10,
        '3: Listar en pantalla los celulares del archivo cuya descripcion contenga una cadena de caracteres proporcionada por el usuario.',#13#10,
        '4: Exportar el archivo a un archivo de texto denominado celulares.txt con todos los celulares del mismo.',#13#10,
        '5: Agregar uno o mas celulares al final del archivo con sus datos ingresados por teclado.',#13#10,
        '6: Modificar el stock de un celular dado.',#13#10,
        '7: Exportar el contenido del archivo binario a un archivo de texto denominado SinStock.txt, con aquellos celulares que tengan stock 0.');
        readln(opcion);
    end
    else begin
        writeln('Ingrese una opcion:',#13#10,
        '1:Crear un archivo de registros no ordenados de celulares y cargarlo con datos ingresados desde un archivo de texto denominado celulares.txt');
        readln(opcion);
    end;
end;

procedure createFile(var name:archivo);
var
    fisico:string;
    archivoTexto: text;
    c:celular;
begin
    writeln('Ingrese el nombre del archivo a crear: ');
    readln(fisico);
    assign(name,fisico);
    rewrite(name); // se crea el archivo binario
    assign(archivoTexto,'celulares.txt');
    reset(archivoTexto); // archivoTexto contiene los datos de celulares.txt
    while (not eof(archivoTexto)) do begin // recorremos archivoTexto y cargamos los datos en el archivo binario
        readln(archivoTexto,c.codigo,c.precio,c.marca);
        readln(archivoTexto,c.stockDisponible,c.stockMinimo,c.descripcion);
        readln(archivoTexto,c.nombre);
        write(name,c);
    end;
    writeln('Archivo creado con exito.');
    close(name);
    close(archivoTexto);
end;

procedure printCelular(c:celular);
begin
    writeln('Informacion del celular: Stock disponible: ',c.stockDisponible,'. Stock minimo: ',c.stockMinimo, '. Nombre: ',c.nombre,'. Codigo: ',c.codigo,'. Precio: ',c.precio:0:2,'. Marca: ',c.marca,'. Descripcion: ',c.descripcion);
end;

procedure lowStock(var name:archivo);
var
    c:celular;
begin
    reset(name);
    while(not eof(name)) do begin
        read(name,c);
        if (c.stockDisponible<c.stockMinimo) then 
            printCelular(c);
    end;
    close(name);
end;

procedure cadenaDescripcion(var name:archivo);
var
    cadena:string;
    posicion:integer;
    c:celular;
begin
    reset(name);
    writeln('Ingrese la cadena de caracteres a buscar en la descripcion: ');
    readln(cadena);
    while (not eof(name)) do begin
        read(name,c);
        posicion:=Pos(cadena,c.descripcion);
        if (posicion>0) then 
            printCelular(c);
    end;
    close(name);
end;

procedure exportTxt(var name:archivo);
var
    texto:text;
    c:celular;
begin
    assign(texto,'celulares.txt');
    rewrite(texto);
    reset(name);
    while (not eof(name)) do begin
        read(name,c);
        writeln(texto,c.codigo,' ',c.precio:0:2,c.marca);
        writeln(texto,c.stockDisponible,' ',c.stockMinimo,c.descripcion);
        writeln(texto,c.nombre);
    end;
    writeln('Archivo exportado.');
    close(name);
    close(texto);
end;

procedure leerCelular(var c:celular);
var
    marca,descripcion:string;
begin
    writeln('Ingrese codigo del celular: ');
    readln(c.codigo);
    writeln('Ingrese precio del celular: ');
    readln(c.precio);
    writeln('Ingrese marca del celular: ');
    readln(marca);
    c.marca:=' ' + marca;
    writeln('Ingrese stock disponible del celular: ');
    readln(c.stockDisponible);
    writeln('Ingrese stock minimo del celular: ');
    readln(c.stockMinimo);
    writeln('Ingrese descripcion del celular: ');
    readln(descripcion);
    c.descripcion:=' '+ descripcion;
    writeln('Ingrese nombre del celular: ');
    readln(c.nombre);
end;

procedure agregarCelular(var name:archivo);
var
    c:celular;
begin
    leerCelular(c);
    reset(name);
    seek(name,filesize(name));
    write(name,c);
    close(name);
end;

procedure modificarStock(var name:archivo);
var
    nombreModificar: string;
    nuevoStock:integer;
    modificado:boolean;
    c:celular;
begin
    reset(name);
    writeln('Ingrese el nombre del celular para modificar su stock disponible:');
    readln(nombreModificar);
    modificado:=false;
    while (not eof(name) and (not modificado)) do begin
        read(name,c);
        if (c.nombre=nombreModificar) then begin
            writeln('Ingrese el nuevo stock: ');
            readln(nuevoStock);
            c.stockDisponible:=nuevoStock;
            seek(name, filepos(name)-1);
            write(name,c);
            modificado:=true;
        end;
    end;
    if (not modificado) then 
        writeln('No se encontro un celular con ese nombre.');
    close(name);
end;

procedure exportSinStock(var name:archivo);
var
    texto:text;
    c:celular;
begin
    reset(name);
    assign(texto,'SinStock.txt');
    rewrite(texto);
    while (not eof(name)) do begin
        read(name,c);
        if (c.stockDisponible=0) then begin
            writeln(texto,c.codigo,' ',c.precio:0:2,c.marca);
            writeln(texto,c.stockDisponible,' ',c.stockMinimo,c.descripcion);
            writeln(texto,c.nombre);
        end;
    end;
    writeln('Archivo con celulares sin stock exportado.');
    close(name);
    close(texto);
end;

var
    opcion:integer;
    logico:archivo;
begin
    opciones(opcion,false);
    while (opcion<8) do begin
        case opcion of
            1: createFile(logico);
            2: lowStock(logico);
            3: cadenaDescripcion(logico);
            4: exportTxt(logico);
            5: agregarCelular(logico);
            6: modificarStock(logico);
            7: exportSinStock(logico);
        end;
        opciones(opcion,true);
    end;
end.