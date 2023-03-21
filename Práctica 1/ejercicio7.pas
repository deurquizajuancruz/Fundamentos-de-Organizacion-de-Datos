program Ejercicio7Practica1;
type
    novela = record
        codigo:integer;
        nombre:string;
        genero:string;
        precio:real;
    end;

    archivo = file of novela;

procedure opciones(var opcion:integer;creado:boolean);
begin
    if (creado) then begin
        writeln('Ingrese una opcion: ',#13#10,
        '1: Crear un archivo binario a partir de la informacion almacenada en un archivo de texto llamado novelas.txt',#13#10,
        '2: Agregar una novela.',#13#10,
        '3: Modificar una novela existente.');
        readln(opcion);
    end
    else begin
        writeln('Ingrese una opcion: ',#13#10,
        '1: Crear un archivo binario a partir de la informacion almacenada en un archivo de texto llamado novelas.txt');
        readln(opcion);
    end;
end;

procedure crearArchivo(var name:archivo);
var
    nombre:string;
    archivoTexto:text;
    n:novela;

begin
    writeln('Ingrese el nombre del archivo a crear: ');
    readln(nombre);
    assign(name,nombre);
    rewrite(name);
    assign(archivoTexto,'novelas.txt');
    reset(archivoTexto);
    while (not eof(archivoTexto)) do begin
        readln(archivoTexto,n.codigo,n.precio,n.genero);
        readln(archivoTexto,n.nombre);
        write(name,n);
    end;
    writeln('Archivo creado con exito.');
    close(name);
    close(archivoTexto);
end;

procedure leerNovela(var n:novela);
begin
    writeln('Ingrese codigo de la novela: ');readln(n.codigo);
    writeln('Ingrese precio de la novela: ');readln(n.precio);
    writeln('Ingrese genero de la novela: ');readln(n.genero);
    writeln('Ingrese nombre de la novela: ');readln(n.nombre);
end;

procedure agregarNovela(var name:archivo);
var
    n:novela;
begin
    reset(name);
    leerNovela(n);
    seek(name,filesize(name));
    write(name,n);
    close(name);
end;

procedure modificarNovela(var name:archivo);
var
    modificado:boolean;
    n:novela;
    atributoModificar,codigo:integer;
    nuevoAtributoString: string;
    nuevoPrecio: real;
begin
    reset(name);
    modificado:=false;
    writeln('Ingrese el codigo de la novela a modificar: ');
    readln(codigo);
    while(not eof(name) and (not modificado)) do begin
        read(name,n);
        if (n.codigo=codigo) then begin
            writeln('Selecciona el atributo a modificar: ',#13#10,
            '1: Codigo',#13#10,
            '2: Nombre',#13#10,
            '3: Genero',#13#10,
            '4: Precio');
            readln(atributoModificar);
            case atributoModificar of
                1: begin
                    writeln('Selecciona el nuevo codigo para la novela: ');
                    readln(atributoModificar);
                    n.codigo:=atributoModificar;
                end;
                2: begin
                    writeln('Selecciona el nuevo nombre para la novela: ');
                    readln(nuevoAtributoString);
                    n.nombre:=nuevoAtributoString;
                end;
                3: begin
                    writeln('Selecciona el nuevo genero para la novela: ');
                    readln(nuevoAtributoString);
                    n.genero:=nuevoAtributoString;
                end;
                4: begin
                    writeln('Selecciona el nuevo precio para la novela: ');
                    readln(nuevoPrecio);
                    n.precio:=nuevoPrecio;
                end;
            end;
            seek(name, filepos(name)-1);
            write(name,n);
            modificado:=true;
        end;
    end;
    if (not modificado) then writeln('No se encontro una novela con ese codigo.');
    close(name);
end;

var
    opcion:integer;
    logico:archivo;

begin
    opciones(opcion,false);
    while (opcion<4) do begin
        case opcion of
            1: crearArchivo(logico);
            2: agregarNovela(logico);
            3: modificarNovela(logico);
        end;
        opciones(opcion,true)
    end;
end.