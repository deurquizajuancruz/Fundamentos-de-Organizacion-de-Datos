program Ejercicio3Practica3;
const
    valoralto=32760;
type
    infoArchivo = record
        codigo:integer;
        genero:string;
        nombre:string;
        duracion:integer;
        director:string;
        precio:real;
    end;

    archivo = file of infoArchivo;

procedure opciones(var opcion:integer;creado:boolean);
begin
    if (creado) then begin
        writeln('Elegi una opcion: ',#13#10,
        '1: Crear un archivo de novelas y cargarlo a partir de datos ingresados por teclado.',#13#10,
        '2: Abrir el archivo y dar de alta una novela leyendo la informacion desde teclado.',#13#10,
        '3: Modificar los datos de una novela leyendo la informacion desde teclado.',#13#10,
        '4: Eliminar una novela cuyo codigo es ingresado por teclado.',#13#10,
        '5: Listar en un archivo de texto todas las novelas, incluyendo las borradas, que representan la lista de espacio libre.');
        readln(opcion);
    end
    else begin
        writeln('Elegi una opcion: ',#13#10,
        '1: Crear un archivo de novelas y cargarlo a partir de datos ingresados por teclado.');
        readln(opcion);
    end;
end;

//1: CREAR ARCHIVO
function randomString():string;
var
    i:integer;
begin
    setLength(randomString,4);
    for i := 1 to 4 do randomString[i]:=chr(random(26)+97);
end;

procedure leerNovela(var novela:infoArchivo);
begin
    writeln('Ingrese codigo de novela: ');readln(novela.codigo);
    //novela.codigo:=random(100)+1;
    if (novela.codigo<>valoralto) then begin
        //writeln('Ingrese genero: ');readln(novela.genero);
        novela.genero:=randomString();
        //writeln('Ingrese nombre: ');readln(novela.nombre);
        novela.nombre:=randomString();
        //writeln('Ingrese duracion: ');readln(novela.duracion);
        novela.duracion:=random(120)+1;
        //writeln('Ingrese director: ');readln(novela.director);
        novela.director:=randomString();
        //writeln('Ingrese precio: ');readln(novela.precio);
        novela.precio:=random()*100;
    end;
end;

procedure crearArchivo(var name:archivo);
var
    nombre:string;
    novela:infoArchivo;
begin
    writeln('Ingrese el nombre del archivo a crear: ');
    readln(nombre);
    assign(name,nombre);
    rewrite(name);
    novela.codigo:=0; novela.genero:='';novela.nombre:='';novela.duracion:=0;novela.director:='';novela.precio:=0;
    write(name,novela);
    leerNovela(novela);
    while (novela.codigo<>valoralto) do begin
        write(name,novela);
        leerNovela(novela);
    end;
    writeln('Archivo con novelas creado.');
    close(name);
end;

//2: DAR DE ALTA 

function existeNovela(var name:archivo;codigoNovela:integer):boolean;
var
    novela:infoArchivo;
begin
    reset(name);
    existeNovela:=false;
    while (not eof(name)) do begin
        read(name,novela);
        if (novela.codigo=codigoNovela) then existeNovela:=true;
    end;
    close(name);
end;

procedure alta(var name:archivo);
var
    cabeceraLista,novela:infoArchivo;
begin
    leerNovela(novela);
    if (not existeNovela(name,novela.codigo)) then begin
        reset(name);
        read(name,cabeceraLista);
        if (cabeceraLista.codigo=0) then begin // si el primer registro es 0, es porque no hay espacio libre y agrego al final
            seek(name,filesize(name));
            write(name,novela);        
        end
        else begin
            seek(name,(cabeceraLista.codigo*-1)); // me posiciono en el espacio libre de la lista. Por ejemplo, si el codigo de la cabecera es -4: -4*-1:4 -> me posiciono en el 4
            read(name,cabeceraLista); //leo lo que habia en el espacio libre: indice hacia la siguiente posicion libre
            seek(name,filepos(name)-1); //vuelvo al espacio libre
            write(name,novela); // escribo en el espacio libre la novela
            seek(name,0); //voy al principio
            write(name,cabeceraLista);//guardo el indice a la siguiente posicion libre en la cabecera de la lista
        end;
        writeln('Novela dada de alta.');
        close(name);
    end
    else begin
        writeln('Ya existe una novela con ese codigo.');
    end;
end;

//3: MODIFICAR NOVELA
procedure modificarNovela(var name:archivo);
var
    codigoNovela,datoModificar:integer;
    encontrado:boolean;
    novela:infoArchivo;
    nuevoString:string;
    nuevoPrecio:real;
begin
    reset(name);
    writeln('Ingrese el codigo de novela para modificar: ');
    readln(codigoNovela);
    encontrado:=false;
    while (not eof(name)) and (not encontrado) do begin
        read(name,novela);
        if (novela.codigo=codigoNovela) then encontrado:=true;
    end;
    if (encontrado) then begin
        writeln('Que desea modificar de la novela?El codigo no puede ser modificado.',#13#10,
        '1: Genero.',#13#10,
        '2: Nombre.',#13#10,
        '3: Duracion.',#13#10,
        '4: Director.',#13#10,
        '5: Precio.');
        readln(datoModificar);
        case datoModificar of
            1: begin
                writeln('Ingrese el nuevo genero de la novela: ');
                readln(nuevoString);
                novela.genero:=nuevoString;
            end;
            2: begin
                writeln('Ingrese el nuevo nombre de la novela: ');
                readln(nuevoString);
                novela.nombre:=nuevoString;
            end;
            3: begin
                writeln('Ingrese la nueva duracion de la novela: ');
                readln(datoModificar);
                novela.duracion:=datoModificar;
            end;
            4: begin
                writeln('Ingrese el nuevo director de la novela: ');
                readln(nuevoString);
                novela.director:=nuevoString;
            end;
            5: begin
                writeln('Ingrese el nuevo precio de la novela: ');
                readln(nuevoPrecio);
                novela.precio:=nuevoPrecio;
            end;
        end;
        seek(name,filepos(name)-1);
        write(name,novela);
        writeln('La novela con codigo ',codigoNovela,' fue modificada exitosamente.');
    end
    else begin
        writeln('No se encontro una novela con ese codigo.');
    end;
    close(name);
end;

//4: ELIMINAR NOVELA
procedure eliminarNovela(var name:archivo);
var
    codigoEliminar:integer;
    encontrado:boolean;
    novela,cabeceraLista:infoArchivo;
begin
    reset(name);
    writeln('Ingrese el codigo de la novela a eliminar: ');
    readln(codigoEliminar);
    encontrado:=false;
    read(name,cabeceraLista); //me guardo la cabecera de la lista
    while (not eof(name)) and (not encontrado) do begin
        read(name,novela);
        if (novela.codigo=codigoEliminar) then encontrado:=true;
    end;
    if (encontrado) then begin
        seek (name,filepos(name)-1); //me posiciono en la posicion a borrar
        write(name,cabeceraLista); //guardo en la posicion a borrar la info de la cabecera
        cabeceraLista.codigo:= (filepos(name)-1) * -1; //paso el indice de la posicion a negativo
        seek(name,0); //me posiciono en la cabecera
        write(name,cabeceraLista); //el registro cabecera lo reemplazo con el del registro que acabo de eliminar
        writeln('Se elimino la novela correctamente.');
    end
    else begin
        writeln('No se encontro una novela con ese codigo.');
    end;
    close(name);
end;

//5: LISTAR EN TXT
procedure exportarTxt(var name:archivo);
var
    txt:text;
    novela:infoArchivo;
begin
    assign(txt,'novelasEjercicio3.txt');
    rewrite(txt);
    reset(name);
    //read(name,novela);
    while (not eof(name)) do begin
        read(name,novela);
        if (novela.codigo<1) then write(txt,'Novela eliminada: ',#13#10);
        write(txt,'Info de novela. Codigo: ',novela.codigo,'. Genero: ',novela.genero,'. Nombre: ',novela.nombre,'. Duracion: ',novela.duracion,'. Director: ',novela.director,'. Precio: ',novela.precio:0:2,#13#10);
    end;
    writeln('Archivo exportado exitosamente.');
    close(name);
    close(txt);
end;

var
    arch:archivo;    
    opcion:integer;
begin
    randomize;
    opciones(opcion,false);
    while (opcion<6) do begin
        case opcion of
            1: crearArchivo(arch);
            2: alta(arch);
            3: modificarNovela(arch);
            4: eliminarNovela(arch);
            5: exportarTxt(arch);
        end;
        opciones(opcion,true);
    end;
end.