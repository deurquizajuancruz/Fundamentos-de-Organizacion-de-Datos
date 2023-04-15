program Ejercicio16Practica2;
const
    valoralto='zzz';
type
    infoMaestro = record
        fecha:string;
        codigoSemanario:integer;
        nombreSemanario:string;
        descripcion:string;
        precio:real;
        totalEjemplares:integer;
        totalEjemplaresVendido:integer;
    end;

    infoDetalle = record
        fecha:string;
        codigoSemanario:integer;
        cantidadVendida:integer;
    end;

    archivoDetalle = file of infoDetalle;
    archivoMaestro = file of infoMaestro;
    arrayDetalles = array [1..100] of archivoDetalle;
    arrayRegistrosDetalles = array [1..100] of infoDetalle;


//ARCHIVO MAESTRO: SE DISPONE
{
function randomString():string;
var
    i:integer;

begin
    setLength(randomString,5);
    for i := 1 to 5 do randomString[i]:=chr(random(26)+97);
end;

procedure cargarInfoMaestro(var info:infoMaestro);
begin
    writeln('Ingrese fecha de emision: ');readln(info.fecha);
    if (info.fecha<>valoralto) then begin
        writeln('Ingrese codigo de semanario: ');readln(info.codigoSemanario);
        info.nombreSemanario:=randomString();
        info.descripcion:=randomString();
        info.precio:=random()*100;
        info.totalEjemplares:=random(3000)+1;
        info.totalEjemplaresVendido:=random(300)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;

begin
    rewrite(m);
    cargarInfoMaestro(info);
    while (info.fecha<>valoralto) do begin
        write(m,info);
        cargarInfoMaestro(info);
    end;
    close(m);
end;

//ARCHIVOS DETALLE: SE DISPONEN

procedure cargarInfoDetalle(var info:infoDetalle);
begin
    writeln('Ingrese fecha de emision: ');readln(info.fecha);
    if (info.fecha<>valoralto) then begin
        writeln('Ingrese codigo de semanario: ');readln(info.codigoSemanario);
        info.cantidadVendida:=random(80)+1;
    end;
end;

procedure cargarArchivoDetalle(var name:archivoDetalle);
var
    info:infoDetalle;

begin
    rewrite(name);
    cargarInfoDetalle(info);
    while(info.fecha<>valoralto) do begin
        write(name,info);
        cargarInfoDetalle(info);
    end;
    close(name);
end;
}

procedure imprimirArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;

begin
    reset(m);
    while (not eof(m)) do begin
        read(m,info);
        writeln('Fecha: ',info.fecha,#13#10,
        'Codigo semanario: ',info.codigoSemanario,#13#10,
        'Nombre semanario: ',info.nombreSemanario,#13#10,
        'Descripcion: ',info.descripcion,#13#10,
        'Precio: ',info.precio:0:2,#13#10,
        'Total ejemplares: ',info.totalEjemplares,#13#10,
        'Total de ejemplares vendidos: ',info.totalEjemplaresVendido,#13#10);
    end;
    close(m);
end;

procedure imprimirArchivoDetalle(var d:archivoDetalle);
var
    info:infoDetalle;

begin
    reset(d);
    while (not eof(d)) do begin
        read(d,info);
        writeln('Fecha: ',info.fecha,#13#10,
        'Codigo semanario: ',info.codigoSemanario,#13#10,
        'Cantidad vendida: ',info.cantidadVendida,#13#10);
    end;
    close(d);
end;

procedure leer(var d:archivoDetalle; var info:infoDetalle);
begin
    if (not eof(d)) then read(d,info)
    else info.fecha:=valoralto;
end;

procedure buscarMinimo(var vectorDetalles:arrayDetalles; var min:infoDetalle; var vectorRegistros:arrayRegistrosDetalles);
var
    i,minPos:integer;
begin
    min.fecha:=valoralto;
    min.codigoSemanario:=32760;
    for i := 1 to 100 do begin
        if (vectorRegistros[i].fecha<>valoralto) then begin
           if (vectorRegistros[i].fecha<=min.fecha) and (vectorRegistros[i].codigoSemanario<=min.codigoSemanario) then begin
                minPos:=i;
                min:=vectorRegistros[i];
            end; 
        end;
    end;
    if (min.fecha<>valoralto) then leer(vectorDetalles[minPos],vectorRegistros[minPos]);
end;

procedure inicializarArchivosDetalles(var vectorDetalles:arrayDetalles; var vectorRegistros:arrayRegistrosDetalles);
var
    i:integer;
begin
    for i := 1 to 100 do begin
        reset(vectorDetalles[i]);
        leer(vectorDetalles[i],vectorRegistros[i]);    
    end;
end;

procedure cerrarArchivosDetalles(var vectorDetalles:arrayDetalles);
var
    i:integer;
begin
    for i := 1 to 100 do begin
        close(vectorDetalles[i]);
    end;
end;

procedure actualizarMaestro(var m:archivoMaestro; var vectorDetalles:arrayDetalles);
var
    min:infoDetalle;
    vectorRegistros:arrayRegistrosDetalles;
    infoM,mayor,menor:infoMaestro;
    totalVentas,maximo,minimo:integer;
begin
    reset(m);
    inicializarArchivosDetalles(vectorDetalles,vectorRegistros);
    buscarMinimo(vectorDetalles,min,vectorRegistros);
    read(m,infoM);
    maximo:=-1;
    minimo:=32760;
    while (min.fecha<>valoralto) do begin
        while (min.fecha>infoM.fecha) do begin
            read(m,infoM);
        end;
        while (min.fecha=infoM.fecha) do begin
            while (min.codigoSemanario>infoM.codigoSemanario) do begin
                read(m,infoM);
            end;
            totalVentas:=0;
            while (min.fecha=infoM.fecha) and (min.codigoSemanario=infoM.codigoSemanario) do begin
                if (min.cantidadVendida<=infoM.totalEjemplares) then begin // tiene que haber ejemplares disponibles para poder vender
                    infoM.totalEjemplaresVendido+=min.cantidadVendida;
                    infoM.totalEjemplares-=min.cantidadVendida;                    
                    totalVentas+=min.cantidadVendida;
                end;
                buscarMinimo(vectorDetalles,min,vectorRegistros);
            end;
            if (totalVentas>maximo) then begin
                maximo:=totalVentas;
                mayor:=infoM;
            end;
            if (totalVentas<minimo) then begin
                minimo:=totalVentas;
                menor:=infoM;
            end;
            seek(m,filepos(m)-1);
            write(m,infoM);
        end;
    end;
    writeln('Semanario con mas ventas: ',mayor.codigoSemanario,' en la fecha ',mayor.fecha);
    writeln('Semanario con menos ventas: ',menor.codigoSemanario,' en la fecha ',menor.fecha);
    close(m);
    cerrarArchivosDetalles(vectorDetalles);
end;

var
    maestro:archivoMaestro;
    vectorDetalles:arrayDetalles;
    i:integer;
    numString,nombre:string;
begin
    randomize;
    assign(maestro,'ArchivoMaestroEjercicio16');
    //cargarArchivoMaestro(maestro);
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);
    for i := 1 to 100 do begin
        nombre:='ArchivoDetalleEjercicio16Numero';
        str(i,numString);
        nombre+=numString;
        assign(vectorDetalles[i],nombre);
        {writeln('Cargar archivo detalle numero ',i);
        cargarArchivoDetalle(vectorDetalles[i]);}
        writeln('Archivo detalle numero ',i);
        imprimirArchivoDetalle(vectorDetalles[i]);
    end;
    writeln('Archivo maestro actualizado: ');
    actualizarMaestro(maestro,vectorDetalles);
    imprimirArchivoMaestro(maestro);
end.