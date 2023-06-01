program Ejercicio2Practica1;

type
    archivo = file of integer;

procedure recorrer(var name:archivo);
var
    menores,cantidad,suma,num: integer;
begin
    cantidad:=0; suma:=0; menores:=0;
    reset(name);
    while (not eof(name)) do begin
        read(name, num);
        writeln(num);
        if (num<1500) then menores+=1;
        suma+=num;
        cantidad+=1;
    end;
    writeln('La cantidad de numeros menores a 1500 es de: ',menores);
    writeln('El promedio de los numeros es: ', suma/cantidad:0:2);
    close(name);
end;

var
    logico:archivo;
    nombre:string;
begin
    writeln('Ingrese el nombre del archivo a procesar: ');
    readln(nombre);
    assign(logico,nombre);
    recorrer(logico);
end.