program Ejercicio13Practica2;
const
    valoralto=999;
type
    infoMaestro = record
        numero:integer;
        nombreUsuario:string;
        nombre:string;
        apellido:string;
        mailsEnviados:integer;
    end;

    infoDetalle = record
        numero:integer;
        cuentaDestino:string;
        cuerpoMensaje:string;
    end;
    
    archivoMaestro = file of infoMaestro;
    archivoDetalle = file of infoDetalle;
{
//ARCHIVO MAESTRO: SE DISPONE

function randomString():string;
var
    i:integer;

begin
    setLength(randomString,6);
    for i := 1 to 4 do randomString[i]:=chr(random(26)+97);
end;


procedure cargarInfoMaestro(var info:infoMaestro);
begin
    writeln('Ingrese numero de usuario: ');readln(info.numero);
    if (info.numero<>0) then begin
        info.nombreUsuario:=randomString();
        info.nombre:=randomString();
        info.apellido:=randomString();
        info.mailsEnviados:=random(20)+1;
    end;
end;

procedure cargarArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;

begin
    rewrite(m);
    cargarInfoMaestro(info);
    while (info.numero<>0) do begin
        write(m,info);
        cargarInfoMaestro(info);
    end;
    close(m);
end;

//ARCHIVO DETALLE: SE DISPONE

procedure cargarInfoDetalle(var info:infoDetalle);
begin
    writeln('Ingrese numero de usuario: ');readln(info.numero);
    if (info.numero<>0) then begin
        info.cuentaDestino:=randomString();
        info.cuerpoMensaje:=randomString();
    end;
end;

procedure cargarArchivoDetalle(var d:archivoDetalle);
var
    info:infoDetalle;

begin
    rewrite(d);
    cargarInfoDetalle(info);
    while (info.numero<>0) do begin
        write(d,info);
        cargarInfoDetalle(info);
    end;
    close(d);
end;
}

procedure imprimirArchivoMaestro(var m:archivoMaestro);
var
    info:infoMaestro;

begin
    reset(m);
    while (not eof(m)) do begin
        read(m,info);
        writeln('Numero de usuario: ',info.numero,#13#10,
        'Nombre de usuario: ',info.nombreUsuario,#13#10,
        'Nombre y apellido: ',info.nombre,' ',info.apellido,#13#10,
        'Mails enviados: ',info.mailsEnviados,#13#10);
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
        writeln('El usuario: ',info.numero,' envio un mail a ',info.cuentaDestino,' con el cuerpo: ',info.cuerpoMensaje);
    end;
    close(d);
end;

procedure leer(var d:archivoDetalle;var info:infoDetalle);
begin
    if (not eof(d)) then read(d,info)
    else info.numero:=valoralto;
end;

procedure actualizarMaestro(var m:archivoMaestro;var d:archivoDetalle);
var
    infoD:infoDetalle;
    infoM:infoMaestro;
    cantidad:integer;
    encontrado:boolean;

begin
    reset(m);reset(d);
    leer(d,infoD); 
    read(m,infoM); 
    while (infoD.numero<>valoralto) do begin
        while (infoD.numero>infoM.numero) do begin
            read(m,infoM);
        end;
        cantidad:=0;
        encontrado:=false;
        while (infoD.numero=infoM.numero) do begin
            cantidad+=1;
            encontrado:=true;
            leer(d,infoD); 
        end;
        if (encontrado) then begin
            seek(m,filepos(m)-1);
            infoM.mailsEnviados+=cantidad;
            write(m,infoM);
        end;
    end;
    close(m);close(d);    
end;

procedure exportarTxt(var m:archivoMaestro);
var
    info:infoMaestro;
    txt:text;

begin
    reset(m);
    assign(txt,'ArchivoMaestroEjercicio13.txt');
    rewrite(txt);
    while (not eof(m)) do begin
        read(m,info);
        write(txt,'Numero de usuario: ',info.numero, ' Mails enviados: ',info.mailsEnviados,#13#10);
    end;
    writeln('Archivo exportado a txt');
    close(m); close(txt);
end;

var
    maestro:archivoMaestro;
    detalle:archivoDetalle;

begin
    randomize;
    assign(maestro,'ArchivoMaestroEjercicio13');
    //cargarArchivoMaestro(maestro);
    writeln('Archivo maestro: ');
    imprimirArchivoMaestro(maestro);
    assign(detalle,'ArchivoDetalleEjercicio13');
    //cargarArchivoDetalle(detalle);
    writeln('Archivo detalle: ');
    imprimirArchivoDetalle(detalle);
    //actualizarMaestro(maestro,detalle);
    writeln('Archivo maestro actualizado: ');
    imprimirArchivoMaestro(maestro);
    exportarTxt(maestro);
end.