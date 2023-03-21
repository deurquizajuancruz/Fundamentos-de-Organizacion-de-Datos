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
        '4: Exportar el archivo a un archivo de texto denominado celulares.txt con todos los celulares del mismo.');
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
    writeln('Informacion del celular. Nombre: ',c.nombre,'. Codigo: ',c.codigo,'. Precio: ',c.precio:0:2,'. Marca: ',c.marca,'. Descripcion: ',c.descripcion,'. Stock disponible: ',c.stockDisponible,'. Stock minimo: ',c.stockMinimo,'.');
end;

procedure lowStock(var name:archivo);
var
    c:celular;

begin
    reset(name);
    while(not eof(name)) do begin
        read(name,c);
        if (c.stockDisponible<c.stockMinimo) then printCelular(c);
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
        posicion:=0;
        posicion:=Pos(cadena,c.descripcion);
        if (posicion>0) then printCelular(c);
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

var
    opcion:integer;
    logico:archivo;

begin
    opciones(opcion,false);
    while (opcion<5) do begin
        case opcion of
            1: createFile(logico);
            2: lowStock(logico);
            3: cadenaDescripcion(logico);
            4: exportTxt(logico);
        end;
        opciones(opcion,true);
    end;
end.