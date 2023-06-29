# Resumen Parcial Práctico

---

# Archivos

## Definición de archivos tipados

### Tipos de Archivos

- Registros de longitud fija: file of <tipoDato>
    
    Archivos binarios conformados por datos de cierto tipo.
    
- Texto: text
    
    Archivos de texto. Acceso secuencial. Útiles para importar y exportar datos.
    

```pascal
type
	archivo = file of tipoDato;
var
	archivoLogico: archivo;
```

Ejemplo:

```pascal
type
	persona = record
		dni:string;
		apellido:string;
		nombre:string;
		direccion:string;
		sexo:char;
	end;
	archivoEnteros = file of integer;
	archivoStrings = file of string;
	archivoPersonas = file of personas;
var
	enteros: archivoEnteros;
	strings: archivoStrings;
	personas: archivoPersonas;
```

## Operaciones

- assign (nombreLogico, nombreFisico);
    
    Realiza una correspondencia entre el archivo físico y el archivo lógico. Al archivo que se está trabajando en el programa se le asigna el directorio donde se va a almacenar en el sistema de archivos. Es de las primeras operaciones que deben realizarse para empezar a trabajar con archivos, no se puede acceder al archivo en la ejecución del programa si no se realizó esta operación.
    
    ```pascal
    assign(enteros, 'C:/Documentos/Cuentas/numerosEnteros.dat');
    assign(strings, 'C:/Documentos/Notas/apuntes.dat');
    assign(personas, 'C:/Documentos/Registros/ciudadanos.dat');
    ```
    
- rewrite(nombreLogico);
    
    Crea el archivo. Para poder ser ejecutado debe tener un archivo asignado en el sistema de archivos (operación assign). Una vez que el archivo tenga la correspondencia lógica y física y haya sido creado, se podrá acceder a éste.
    
    ```pascal
    rewrite(enteros);
    rewrite(personas);
    ```
    
- reset(nombreLogico);
    
    Abre un archivo existente. El archivo ya tiene que existir, por la operación rewrite o por el usuario.
    
    ```pascal
    reset(enteros); //se abre el archivo previamente creado con rewrite
    reset(strings); //se abre el archivo que ya existía en el sistema
    ```
    
- close(nombreLogico);
    
    Transfiere la información del buffer al disco: guarda todos los cambios que se produjeron en la ejecución del programa en la ubicación física del archivo. Si se quiere modificar un archivo previamente abierto y que se guarden los cambios dentro de éste, se debe realizar esta operación. 
    
    ```pascal
    close(strings);
    close(enteros);
    ```
    
- read(nombreLogico, varDato);
    
    Lee información del archivo y la almacena en varDato. La variable varDato debe ser del tipo de dato del archivo.
    
    ```pascal
    read(enteros, numero);
    read(personas, personaUno);
    ```
    
- write(nombreLogico, varDato);
    
    Escribe en el archivo la información almacenada en varDato. La variable varDato debe ser del tipo de dato del archivo.
    
    ```pascal
    write(strings,nota1);
    write(enteros,88);
    ```
    
- eof(nombreLogico);
    
    End of file. Función integrada de Pascal que devuelve un booleano: true si es el final del archivo, false en caso contrario. Utilizada para recorrer todo el archivo.
    
    ```pascal
    while (not(eof(enteros)) do begin // mientras NO sea el final del archivo enteros
    	//acciones a realizar
    end;
    ```
    
- filesize(nombreLogico);
    
    Función integrada de Pascal que devuelve el tamaño de un archivo.
    
    ```pascal
    writeln('El tamaño del archivo es de: ',filesize(personas));
    ```
    
- filepos(nombreLogico);
    
    Función integrada de Pascal que devuelve la posición actual del puntero en el archivo. Los registros que contiene el archivo se numeran de 0 a N-1.
    
    ```pascal
    writeln('Recorriendo el archivo. Posición actual: ',filepos(enteros));
    ```
    
- seek(nombreLogico, pos);
    
    Función integrada de Pascal que establece la posición del puntero en el archivo en la posición determinada por pos, que es de tipo entero.
    
    ```pascal
    seek(personas, medio);
    seek(strings, 4);
    ```
    

Ejemplo donde se crea y carga un archivo con información de personas, hasta leer una con DNI vacío:

```pascal
program ejemploArchivos;
type
	persona = record
		dni:string;
		nombreYApellido:string;
		direccion:string;
		sexo:char;
		salario:real;
	end;
	archivoPersonas = file of persona;
var
	personas: archivoPersonas;
	nombreFisico:string;
	p:persona;
begin
	writeln('Ingrese el nombre del archivo: ');
	readln(nombreFisico); // el usuario ingresa por teclado el nombre que tendrá el archivo
	assign(personas, nombreFisico); // se genera el enlace entre el nombre lógico y el nombre físico del archivo
	rewrite(personas); // se crea el archivo en el sistema y se abre para poder usarlo en el programa
	writeln('Ingrese DNI de la persona: ');
	readln(p.dni);
	while (p.dni<>'') do begin
		writeln('Ingrese nombre y apellido de la persona: ');
		readln(p.nombreYApellido);
		writeln('Ingrese direccion de la persona: ');
		readln(p.direccion);
		writeln('Ingrese sexo de la persona: ');
		readln(p.sexo);
		writeln('Ingrese salario de la persona: ');
		readln(p.salario);
		write(personas,p); // en el archivo personas se escribe p, que es la persona cuya informacion acabamos de leer
		writeln('Ingrese DNI de la persona: ');
		readln(p.dni);
	end;
	close(personas); // se cierra el archivo para que se guarden los cambios
end.
```

Ejercicio 1 de la Práctica 1: Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.

```pascal
program Ejercicio1Practica1;
type
	archivoNumeros = file of integer;
var
	nombreFisico:string;
	archivo:archivoNumeros;
	numero:integer;
begin
	writeln('Ingrese el nombre del archivo: ');
	readln(nombreFisico);
	assign(archivo,nombreFisico);
	writeln('Ingrese un numero: ');
	readln(numero);
	while (numero<>3000) do begin
		write(archivo,numero);
		writeln('Ingrese un numero: ');
		readln(numero);
	end;
	close(archivo);
end.
```

Ejercicio 2 de la Práctica 1: Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
promedio de los números ingresados. El nombre del archivo a procesar debe ser proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el contenido del archivo en pantalla.

```pascal
program Ejercicio2Practica1;
type
	archivo = file of integer;

procedure recorrer(var a:archivo);
var
	menores,cantidad,suma,num:integer;
begin
	cantidad:=0;
	suma:=0;
	menores:=0;
	reset(a);
	while (not eof(a)) do begin
		read(a,num);
		writeln(num);
		cantidad+=1;
		suma+=num;
		if (num<1500) then
			menores+=1;
	end;
	writeln('La cantidad de numeros menores a 1500 es de: ',menores);
	writeln('El promedio de los numeros del archivo es de: ',suma/cantidad:0:2);
	close(a);
end;

var
	nombre:string;
	a:archivo;
begin
	writeln('Ingrese el nombre del archivo a procesar: ');
	readln(nombre);
	assign(a,nombre);
	recorrer(a);
end.
```

Ejercicio 7 de la Práctica 1: Realizar un programa que permita crear un archivo binario a partir de la información almacenada en un archivo de texto, el nombre del archivo de texto es: “novelas.txt”,
y abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar una novela y modificar una existente. Las búsquedas se realizan por código de novela. La información en el archivo de texto consiste en: código de novela, nombre, género y precio. De cada novela se almacena la información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente información: código novela, precio, y género, y la segunda línea almacenará el nombre de la novela.

```pascal
program Ejercicio7Practica1;
type
	novela = record
		codigo:integer;
		nombre:string;
		genero:string;
		precio:real;
	end;
	archivo = file of novela;

procedure opciones(var opcion:integer; creado:boolean);
begin
	if (creado) then begin
		writeln('Ingrese una opcion: ',
    '1: Crear un archivo binario a partir de la informacion almacenada en un archivo de texto llamado novelas.txt',
    '2: Agregar una novela.',
    '3: Modificar una novela existente.');
    readln(opcion);
	end
	else begin
		writeln('Ingrese una opcion: ',
		'1: Crear un archivo binario a partir de la informacion almacenada en un archivo de texto llamado novelas.txt');
    readln(opcion);
	end;
end;

procedure crearArchivo(var a:archivo);
var
	archivoTexto:text;
	n:novela;
begin
	assign(a,'ArchivoEjercicio7');
	rewrite(a);
	assign(archivoTexto,'novelas.txt);
	reset(archivoTexto);
	while (not eof(archivoTexto)) do begin
		readln(archivoTexto,n.codigo,n.precio,n.genero);
		readln(archivoTexto,n.nombre);
		write(a,n);
	end;
	writeln('Archivo creado con exito');
	close(a);
	close(archivoTexto);
end;

procedure leerNovela(var n:novela);
begin
	writeln('Ingrese codigo de la novela: ');readln(n.codigo);
  writeln('Ingrese precio de la novela: ');readln(n.precio);
  writeln('Ingrese genero de la novela: ');readln(n.genero);
  writeln('Ingrese nombre de la novela: ');readln(n.nombre);
end;

procedure agregarNovela(var a:archivo);
var
	n:novela;
begin
	reset(a);
	leerNovela(n);
	seek(a,filesize(a)); // me posiciono al final del archivo
	write(a,n); // agrego la novela a lo último
	close(a);
end;

procedure modificarNovela(var a:archivo);
var
	modificado:boolean;
	n:novela;
	atributoModificar,codigoModificar:integer;
begin
	modificado:true;
	reset(a);
	writeln('Ingrese el codigo de la novela a modificar');
	readln(codigoModificar);
	while (not eof(a) and (not modificado)) do begin
		read(a,n);
		if (n.codigo=codigoModificar) then begin
			writeln('Selecciona el atributo a modificar: ',
      '1: Codigo',
      '2: Precio',
      '3: Genero',
      '4: Nombre');
			readln(atributoModificar);
			case atributoModificar of:
				1: begin
					writeln('Selecciona el nuevo codigo para la novela: ');
          readln(n.codigo);
				end;
				2: begin
					writeln('Selecciona el nuevo precio para la novela: ');
          readln(n.precio);
				end;
				3: begin
					writeln('Selecciona el nuevo genero para la novela: ');
          readln(n.genero);
				end;
				4: begin
					writeln('Selecciona el nuevo nombre para la novela: ');
          readln(n.nombre);
				end;
			seek(a,filepos(a)-1); // me posiciono en la posicion anterior, cuando lei la novela a modificar el puntero quedó apuntando a la siguiente
			write(a,n);
			modificado:=true;
		end;
	end;
	if (not modificado) then
		writeln('No se encontro una novela con ese codigo.');
	close(a);
end;

var
	opcion:integer;
	a:archivo;
begin
	opciones(opcion,false);
	while (opcion<4) do begin
		case opcion of:
			1: crearArchivo(a);
			2: agregarNovela(a);
			3: modificarNovela(a);
		end;
		opciones(opcion,true);
	end;
end.
```

## Algorítmica clásica sobre archivos

## Archivo Maestro

Resume información sobre el dominio de un problema en específico. Por ejemplo, el archivo de productos de una empresa.

## Archivo Detalle

Contiene movimientos realizados sobre la información almacenada en el maestro. Por ejemplo, un archivo conteniendo las ventas sobre esos productos.

Es importante analizar las precondiciones de cada caso particular. Los algoritmos a desarrollar deben tenerlas en cuenta o habrá fallas en su ejecución.

### Precondiciones:

- Existe un archivo maestro.
- Existe por lo menos un archivod etalle que modifica al maestro.
- Cada registro del detalle modifica a registros del maestro que existen.
- No todos los registros del maestro son necesariamente modificados.
- Cada elemento del maestro puede no ser modificado, o ser modificado por uno o más elementos del detalle.
- Ambos archivos están ordenados por el mismo criterio.

Para poder controlar el fin de datos de los archivos, se utiliza un procedimiento llamado leer, que en la última posición del archivo inserta un valor alto (que no estará presente en los otros registros) que una vez que se lee significa que se llegó al fin del archivo.

Actualización de un archivo maestro con un archivo detalle:

```pascal
program actualizandoArchivos;
const
	valorAlto = '9999';
type
	producto = record
		codigo:string;
		descripcion:string;
		precioUnitario:real;
		stock:integer;
	end;
	ventaProducto = record
		codigo:integer;
		cantidadVendida:integer;
	end;
	archivoDetalle = file of ventaProducto;
	archivoMaestro = file of producto;

procedure leer(var d:archivoDetalle;var dato:ventaProducto);
begin
	if (not eof(d)) then
		read(d,dato)
	else
		dato.codigo:=valoralto;
end;

var
	maestro:archivoMaestro;
	detalle:archivoDetalle;
	total:integer;
	registroMaestro:producto;
	registroDetalle:ventaProducto;
	aux:string;
begin
	assign(maestro,'ArchivoMaestro');
	assign(detalle,'ArchivoDetalle');
	reset(maestro);
	reset(detalle);
	read(maestro,registroMaestro);
	leer(detalle,registroDetalle);
	while (registroDetalle.codigo<>valoralto) do begin // mientras no se termine el archivo detalle
		aux:=registroDetalle.codigo;
		total:=0;
		while (aux=registroDetalle.codigo) do begin // se totaliza la cantidad vendida de productos iguales en el archivo detalle
			total+=registroDetalle.cantidadVendida;
			leer(detalle,registroDetalle);
		end;
		while (registroMaestro.codigo<>aux) do
			read(maestro,registroMaestro); // se busca el producto del detalle en el maestro
		registroMaestro.stock-=total; // se modifica el stock del producto que tiene el codigo del detalle, restándole la cantidad vendida de ese producto
		seek(maestro,filepos(maestro)-1); // se reubica el puntero en el maestro, porque al leer el puntero quedó apuntando al siguiente
		write(maestro,registroMaestro); // se actualiza el maestro
		if (not eof(maestro)) then
			read(maestro,registroMaestro);
	end;
	close(maestro);
	close(detalle);
end.
```

## Corte de Control

Proceso mediante el cual la información de un archivo es presentada en forma organizada de acuerdo a la estrucutra que posee el archivo. Por ejemplo, se almacena en un archivo la información de ventas de una cadena de electrodomésticos. Las ventas fueron hechas por vendedores en las sucursales de diferentes ciudades de cada provincia del país. Es necesario informar el total vendido en cada sucursal, en cada ciudad y en cada provincia, así como el total final.

El archivo se encuentra ordenado por provincia, ciudad y sucursal: primero se encuentra toda la información de todas las ventas en la primer sucursal de la primer ciudad de la primer provincia, luego toda la información de todas las ventas en la segunda sucursal de la primer ciudad de la primer provincia, y así sucesivamente.

Ejemplo:

```pascal
program corteDeControl;
const
	valorAlto = 'ZZZ';
type
	venta = record
		codigoVendedor: integer;
		monto:real;
		sucursal:string;
		ciudad:string;
		provincia:string;
	end;
	archivoVentas = file of venta;

procedure leer(var a:archivoVentas;var dato:venta);
begin
		if (not eof(a)) then
			read(a,dato)
		else
			dato.provincia:=valorAlto;
end;

var
	v:venta;
	a:archivoVentas;
	total,totalProvincia,totalCiudad,totalSucursal:integer;
	provincia,ciudad,sucursal:string;
begin
	assign(a,'ArchivoVentas');
	reset(a);
	leer(a,v);
	total:=0;
	while (v.provincia<>valorAlto) do begin //mientras no se termine el archivo
		writeln('Provincia: ',v.provincia);
		provincia:=v.provincia;
		totalProvincia:=0;
		while (v.provincia<>valorAlto) and (provincia=v.provincia) do begin // mientras sea la misma provincia
			writeln('Ciudad: ',v.ciudad);
			ciudad:=v.ciudad;
			totalCiudad:=0;
			while (v.provincia<>valorAlto) and (provincia=v.provincia) and (ciudad=v.ciudad) do begin // mientras sea la misma ciudad
				writeln('Sucursal: ',v.sucursal);
				sucursal:=v.sucursal;
				totalSucursal:=0;
				while (v.provincia<>valorAlto) and (provincia=v.provincia) and (ciudad=v.ciudad) and (sucursal=v.sucursal) do begin // mientras sea la misma sucursal
					writeln('El monto vendido por el vendedor ',v.codigoVendedor,' fue de: ', v.monto);
					totalSucursal+=v.monto;
					leer(a,v); // avanzo en el archivo
				end;
				writeln('El total vendido en la sucursal ', sucursal ,'fue de: ',totalSucursal); // termina la sucursal: informo el total
				totalCiudad+=totalSucursal; // sumo el total de esta sucursal al total de la ciudad
			end;
			writeln('El total vendido en la ciudad ',ciudad,' fue de: ',totalCiudad); // termina la ciudad: informo el total
			totalProvincia+=totalCiudad;// sumo el total de esta ciudad al total de la provincia
		end;
		writeln('El total vendido en la provincia ',provincia,' fue de: ',totalProvincia); // termina la provincia: informo el total
		total+=totalProvincia;// sumo el total de esta provincia al total
	end;
	writeln('El total vendido por la empresa fue: ',total); // termina el archivo de la empresa: informo el total
	close(a);
end.
```

## Merge

Proceso mediante el cual se genera un nuevo archivo a partir de otros archivos existentes.

Es utilizado cuando se tienen varios archivos detalles y un archivo maestro y éste debe ser actualizado con toda la información nueva de los detalles. Se debe seleccionar el registro de cualquier archivo detalle que cumpla con la condición de ‘menor’, es decir el que iría primero en el orden que tienen los archivos, actualizar el maestro, y repetir hasta que se agoten los registros de los detalles.

Ejercicio 1 de la Práctica 2:  Una empresa posee un archivo con información de los ingresos percibidos por diferentes empleados por comisión, de cada uno de ellos se conoce: código de empleado, nombre y monto de la comisión. La información del archivo se encuentra ordenada por código de empleado y cada empleado puede aparecer más de una vez en el archivo de comisiones. Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una única vez con el valor total de sus comisiones.

```pascal
program Ejercicio1Practica2;
const
	valoralto=9999;
type
	empleado = record
		codigo:integer;
		nombre:string;
		monto:real;
	end;
	archivo = file of empleado;

procedure leer(var viejo:archivo;var e:empleado);
begin
	if (not eof(viejo)) then
		read(viejo,e)
	else
		e.codigo:=valoralto;
end;

procedure recorrerArchivo(var viejo,nuevo: archivo);
var
	e,aux:empleado;
	
begin
	reset(viejo);
	leer(viejo,e);
	while (e.codigo<>valoralto) do begin
		aux:=e;
		aux.monto:=0;
		while (e.codigo<>valoralto) and (aux.codigo=e.codigo) do begin
			aux.monto+=e.monto;
			leer(viejo,e);
		end;
		write(nuevo,aux);
	end;
	close(nuevo);
	close(viejo);
end.

var
	archivoViejo,archivoNuevo:archivo;
begin
	assign(archivoViejo, 'ArchivoComisiones.dat');
	assign(archivoNuevo, 'NuevoArchivoComisiones.dat');
	rewrite(archivoNuevo);
	recorrerArchivo(archivoViejo, archivoNuevo);
end.
```

Ejercicio 4 de la Práctica 2: Suponga que trabaja en una oficina donde está montada una red local  que conecta 5 máquinas entre sí y todas las máquinas se conectan con un servidor central. Semanalmente cada máquina genera un archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos: cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas. Cada archivo detalle está ordenado por cod_usuario y fecha. Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes máquinas.

```pascal
program Ejercicio4Practica2;
const
	valorAlto = 999;
type
	info = record
		codigoUsuario:integer;
		fecha:string;
		tiempo:integer;
	end;
	archivo = file of info;
	arrayDetalles = array [1..5] of archivo;
	arrayRegistrosDetalles = array [1..5] of info;

procedure leer(var a:archivo; var d:info);
begin
	if (not eof(a)) then
		read(a,d)
	else
		d.codigoUsuario:=valorAlto;
end;

procedure inicializarArchivosDetalles(var vectorDetalles:arrayDetalles; var vectorRegistros: arrayRegistrosDetalles);
var
	i:integer;
begin
	for i:= 1 to 5 do begin
			reset(vectorDetalles[i]);
			leer(vectorDetalles[i],vectorRegistros[i]);
	end;
end;

procedure cerrarArchivosDetalles(var vectorDetalles:arrayDetalles);
var
	i:integer;
begin
	for i:=1 to 5 do 
		close(vectorDetalles[i]);
end;

procedure buscarMinimo(var vectorDetalles:arrayDetalles; var registroDetalles:arrayRegistroDetalles; var min:info);
var
	i,minPos:integer;
begin
	min.codigoUsuario:=valorAlto;
	min.fecha:='ZZZ';
	for i:= 1 to 5 do begin
		if (registrosDetalles[i]<>valorAlto) then begin
			if (registrosDetalles[i].codigoUsuario<min.codigoUsuario) and (registrosDetalles[i].fecha<min.fecha) then begin
				min:=registrosDetalles[i];
				minPos:=i;
			end;
		end;		
	end;
	if (min.codigoUsuario<>valorAlto) then
		leer(vectorDetalles[minPos],vectorRegistros[minPos]);
end;

procedure crearArchivoMaestro(var maestro:archivo;var vectorDetalles:arrayDetalles);
var
	min,actual:info;
	vectorRegistros:arrayRegistrosDetalles;
begin
	assign(maestro,'ArchivoMaestroEjercicio4');
	rewrite(maestro);
	inicializarArchivosDetalles(vectorDetalles,vectorRegistros);
	buscarMinimo(vectorDetalles,vectorRegistros,min);
	while (min.codigoUsuario<>valorAlto) do begin
		actual.codigoUsuario:=min.codigoUsuario;
		while (min.codigoUsuario<>valorAlto) and (actual.codigoUsuario=min.codigoUsuario) do begin
			actual.fecha:=min.fecha;
			actual.tiempo:=0;
			while (min.codigoUsuario<>valorAlto) and (actual.codigoUsuario=min.codigoUsuario) and (actual.fecha=min.fecha) do begin
				actual.tiempo+=min.tiempo;
				buscarMinimo(vectorDetalles,vectorRegistros,min);
			end;
			write(maestro,actual);
		end;
	end;
	close(maestro);
	cerrarArchivosDetalles(vectorDetalles);
end;

var
	i:integer;
	nombre,numString:string;
	vectorDetalles:arrayDetalles;
	maestro:archivo;
begin
	for i:= 1 to 5 do begin
		nombre:='ArchivoDetalleEjercicio4Numero';
		str(i,numString);
		nombre+=numString;
		assign(vectorDetalles[i],nombre);
	end;
	crearArchivoMaestro(maestro,vectorDetalles);
end.
```

Ejercicio 7 de la Práctica 2: El encargado de ventas de un negocio de productos de limpieza desea administrar el stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los productos que comercializa. De cada producto se maneja la siguiente información: código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
Diariamente se genera un archivo detalle donde se registran todas las ventas de productos
realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas.
Se pide realizar un programa con opciones para: Actualizar el archivo maestro con el archivo detalle, sabiendo que ambos archivos están ordenados por código de producto, cada registro del maestro puede ser actualizado por 0, 1 ó más registros del archivo detalle, el archivo detalle sólo contiene registros que están en el archivo maestro; listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo stock actual esté por debajo del stock mínimo permitido.

```pascal
program Ejercicio7Practica2;
const
	valorAlto = 999;
type
	infoMaestro = record
		codigo:integer;
		nombre:string;
		precio:real;
		stockActual:integer;
		stockMinimo:integer;
	end;
	infoDetalle = record
		codigo:integer;
		vendido:integer;
	end;
	archivoMaestro = file of infoMaestro;
	archivoDetalle = file of infoDetalle;

procedure leer(var detalle:archivoDetalle; var info:infoDetalle);
begin
	if (not eof(detalle)) then
		read(detalle,info)
	else
		info.codigo:=valorAlto;
end;

procedure actualizarMaestro(var maestro:archivoMaestro; var detalle:archivoDetalle);
var
	infoD:infoDetalle;
	infoM:infoMaestro;
begin
	reset(maestro);
	reset(detalle);
	leer(detalle,infoD);
	read(maestro,infoM);
	while (infoD.codigo<>valorAlto) do begin
		while (infoM.codigo<>infoD.codigo) do 
			read(maestro,infoM);
		while (infoM.codigo=infoD.codigo) do begin
			if (infoD.vendido>infoM.stockActual) then
					infoM.stockActual:=0
			else
					infoM.stockActual-=infoD.vendido;
			leer(detalle,infoD);
		end;
		seek(maestro,filepos(maestro)-1);
		write(maestro,infoM);
	end;
	close(maestro);
	close(detalle);
end;

procedure exportarTxt(var maestro:archivoMaestro);
var
	texto:text;
	info:infoMaestro;
begin
	assign(texto, 'stock_minimo.txt');
	rewrite(texto);
	reset(maestro);
	while (not eof(maestro)) do begin
		read(maestro,info);
		if (info.stockActual<info.stockMinimo) then
			write(txt,'Producto ',info.codigo,' con nombre ',info.nombre,' precio ',info.precio:0:2,' tiene un stock actual de ',info.stockActual,' menor a ',info.stockMinimo,', el stock minimo');
	end;
	write('Archivo exportado correctamente.');
	close(texto);
	close(maestro);
end;

var
	maestro:archivoMaestro;
	detalle:archivoDetalle;
	opcion:integer;
begin
	assign(maestro,'ArchivoMaestroEjercicio7');
	assign(detalle,'ArchivoDetalleEjercicio7');
	writeln('Seleccione una opcion: ',
  '1: Actualizar el archivo maestro con el archivo detalle.',
  '2: Listar en un archivo de texto llamado stock_minimo.txt aquellos productos cuyo stock actual este por debajo del stock minimo permitido.');
  readln(opcion);
	case opcion of: 
		1: actualizarMaestro(maestro,detalle);
		2: exportarTxt(maestro);
	end;
end.

```

## Bajas

Un proceso de baja es un proceso que permite quitar información de un archivo.

Se puede llevar a cabo de 2 modos diferentes:

- Baja Física.
- Baja Lógica.

### Baja Física

Consiste en borrar efectivamente la información del archivo, recuperando el espacio físico. El dato borrado deja de existir en el archivo. Se decrementa en uno la cantidad de elementos. 

**Ventaja:** En todo momento, se administra un archivo de datos que ocupa el lugar mínimo necesario.

**Desventaja:** Performance de los algoritmos que implementan esta solución.

Técnicas:

- Generar un nuevo archivo con los elementos válidos, sin copiar los que se desean eliminar.
- Utilizar el mismo archivo de datos, generando los reacomodamientos que sean necesarios. (Sólo para archivos ordenados).

Ejemplo:

```pascal
program bajaFisica;
const
	valorAlto='ZZZ';
type
	archivo = file of string;

procedure leer(var a:archivo; var nombre:string);
begin
	if (not eof(a)) then
		read(a,nombre)
	else
		nombre:=valorAlto;
end;

var
	viejo,nuevo:archivo;
	nombre:string;
begin // se sabe que existe Carlos García
	assign(viejo, 'archivoEmpleados.dat');
	assign(nuevo,'nuevoArchivoEmpleados.dat');
	reset(viejo);
	rewrite(nuevo);
	leer(viejo,nombre);
	while (nombre<>'Carlos Garcia') do begin
		write(nuevo,nombre); // se copian los registros previos a Carlos García
		leer(viejo,nombre);
	end;
	leer(viejo,nombre); // se llego a Carlos Garcia = con esta operacion se descarta, ya que se lee y el puntero queda en el nombre proximo a Carlos
	while (nombre<>valorAlto) do begin
		write(nuevo,nombre); // se copian los nombres restantes
		leer(viejo,nombre);
	end;
	close(nuevo);
	close(viejo);
end.
```

### Baja Lógica

Consiste en borrar la información del archivo, pero sin recuperar el espacio físico respectivo. Se deja una marca de borrado en el dato, la cual indica que ese dato no debe tenerse en cuenta, pero sigue ocupando espacio en el sistema.

Se debe trabajar con las posiciones del puntero al leer el archivo. Al leer un dato del archivo, el puntero siempre queda en la posición siguiente.

Técnicas:

- Recuperación de espacio: Se utiliza el proceso de baja física periódicamente para realizar un proceso de compactación del archivo: Quita los registros marcados como eliminados, utilizando cualquiera de los algoritmos vistos para baja física.
- Reasignación de espacio: Recupera el espacio utilizandos los lugares indicados como eliminados para el ingreso de nuevos elementos al archivo (altas). Se utiliza la técnica de Lista Invertida: en el primer registro del archivo se mantiene una referencia al último registro libre, que puede ser una referencia hacia otro registro libre.
    
    La lista Invertida, generalmente, tiene en la cabecera una posicion donde se puede agregar un nuevo registro (posicion libre). Si tiene 0, es porque no hay una posicion libre, entonces se debe agregar al final. Si no, tiene esa posición en negativo. Por ejemplo, si en la posición 5 hay una marca de borrado, la cabecera tendrá -5 y en la posición 5 estará el 0. 
    
    Si hay más de un espacio libre, por ejemplo primero se borra en la posición 5 y después en la 7, la cabecera tendrá -7, la posición 7 tendrá -5 y la posición 5 tendrá 0.
    
    Si se quiere dar de alta un dato, se tiene que leer la cabecera (-7), se posicionará en la posición 7, se copia lo que hay en ella (-5) y se escribe el nuevo dato allí, y en la cabecera se va a escribir lo que tenía antes la posición 7 (-5). Es decir, el último registro en ser eliminado será el primero en el que se agregará un nuevo dato.
    

Ejemplo Recuperación de Espacio:

```pascal
program bajLogica;
const
	valorAlto='ZZZ';
type
	archivo = file of string;

procedure leer(var a:archivo;var nombre:string);
begin
	if (not eof(a)) then
		read(a,nombre)
	else
		nombre:=valorAlto;
end;

var
	nombre:string;
	a:archivo;
begin // se sabe que existe Carlos García
	assign(a,'archivoEmpleados');
	reset(a);
	leer(a,nombre);
	while (nombre<>'Carlos Garcia') do // se avanza hasta Carlos García
		leer(a,nombre);
	nombre:='***'; // se encontro a Carlos García = se genera una marca de borrado
	seek(a,filepos(a)-1); // como se leyó, el puntero quedó en la posición siguiente a Carlos = se vuelve a la posición anterior y se escribe la marca
	write(a,nombre); // se borra lógicamente a Carlos
	close(a);
end.
```

Ejercicio 2 de la Práctica 3: Definir un programa que genere un archivo con registros de longitud fija conteniendo información de asistentes a un congreso a partir de la información obtenida por
teclado hasta que se lea un asistente con número 0, que no debe procesarse. Se deberá almacenar la siguiente información: nro de asistente, apellido y nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del archivo de datos generado, elimine de forma lógica todos los asistentes con nro de asistente inferior a 1000. Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo String a su elección. Ejemplo: ‘@Saldaño’.

```pascal
program Ejercicio2Practica3;
type
	asistente = record
		numero:integer;
		nombreYApellido:string;
		email:string;
		telefono:string;
		DNI:string;
	end;
	archivo = file of asistente;

procedure leerAsistente(var a:asistente);
begin
	writeln('Ingrese numero de asistente: ');
	readln(a.numero);
  if (a.numero<>0) then begin
      writeln('Ingrese apellido: ');
			readln(a.apellido);
      writeln('Ingrese nombre: ');
			readln(a.nombre);
      writeln('Ingrese email: ');
			readln(a.email);
      writeln('Ingrese telefono: ');
			readln(a.telefono);
      writeln('Ingrese DNI: ');
			readln(a.dni);
  end;
end;

procedure cargarArchivo(var a:archivo);
var
	dato:asistente;
begin
	rewrite(a);
	leerAsistente(dato);
	while (dato.numero<>0) do begin
		write(a,dato);
		leerAsistente(dato);
	end;
	close(a);
end;

procedure bajaLogica(var a:archivo);
var
	dato:asistente;
begin
	reset(a);
	while (not eof(a)) do begin
		read(a,dato);
		if (dato.numero<1000) then begin // si el numero del asistente es menor a 1000
			dato.nombreYApellido:= '@' + dato.nombreYApellido; // se agrega un @ adelante del nombre y apellido como marca de borrado
			seek(a,filepos(a)-1); // como leí, el puntero quedó en la posición siguiente. Me posiciono en el registro anterior (dato a borrar)
			write(a,dato); // escribo el nuevo dato con la marca de borrado
		end;
	end;
	close(a);
end;

var
	a:archivo;
begin
	assign(a,'ArchivoEjercicio2');
	cargarArchivo(a);
	bajaLogica(a);
end.
```

Ejercicio 7 de la Práctica 3: Se cuenta con un archivo que almacena información sobre especies de aves en vía de extinción, para ello se almacena: código, nombre de la especie, familia de ave,
descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice
un programa que elimine especies de aves, para ello se recibe por teclado las especies a
eliminar. Deberá realizar todas las declaraciones necesarias, implementar todos los
procedimientos que requiera y una alternativa para borrar los registros. Para ello deberá
implementar dos procedimientos, uno que marque los registros a borrar y posteriormente
otro procedimiento que compacte el archivo, quitando los registros marcados. Para
quitar los registros se deberá copiar el último registro del archivo en la posición del registro
a borrar y luego eliminar del archivo el último registro de forma tal de evitar registros
duplicados. Las bajas deben finalizar al recibir el código 5.000.

```pascal
program Ejercicio7Practica3;
const
	valorAlto=999;
type
	ave = record
		codigo:integer;		
		especie:string;
		familia:string;
		descripcion:string;
		zona:string;
	end;
	archivo = file of ave;

procedure bajaLogica(var a:archivo);
var
	especieBorrar:string;
	dato:ave;
	encontrado:boolean;
begin
	reset(a);
	encontrado:=false;
	writeln('Ingrese el nombre de la especie a borrar:');
	readln(especieBorrar);
	while (codigoBorrar<>5000) do begin
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

procedure leer(var a:archivo;var dato:ave);
begin
    if (not eof(a)) then 
        read(a,dato)
    else 
        dato.codigo:=valorAlto;
end;

procedure bajaFisica(var a:archivo);
var
	posicion:integer;
	dato:ave;
begin
	reset(a);
	leer(a,dato);
	while (a.codigo<>valorAlto) do begin
		if (dato.nombre[1]='@') then begin // si encuentro un dato con marca de borrado
				posicion:=seek(filepos(a)-1); // me guardo la posicion donde hay una marca de borrado(anterior a donde estoy)
				seek(name,filesize(a)-1); // me posiciono en el último registro del archivo
				read(a,dato); // leo el ultimo registro
				while (dato.nombre[1]='@') and ((filepos(name)-1)<>0) do begin // mientras haya marca y no sea el primer registro del archivo
					seek(a,filesize(a)-1); // me posiciono en el ultimo registro
					truncate(a); // borro desde el ultimo hasta el final (ultimo registro)
					seek(a,filesize(a)-1); // me posiciono en el ultimo registro
					read(a,dato); // leo para ver si tiene marca de borrado
				end;
				seek(a,posicion); // una vez q encontre la ultima posicion sin marca de borrado, me posiciono en la posicion que tenia marca
				write(a,dato); // escribo lo que tenia el ultimo registro en esa posicion 
				seek(a,filesize(a)-1); // me posiciono en el ultimo registro del archivo
				truncate(a); // elimino todo desde esa posicion hasta el final
				seek(a,posicion); // voy a la posicion donde encontre la primer marca y sigo recorriendo el archivo
		end;
		leer(a,dato);
	end;
	close(a);
end;

var
	a:archivo;
begin
	assign(a,'ArchivoEjercicio7');
	bajaLogica(a);
	bajaFisica(a);
end.
```

Ejercicio 8 de la Práctica 3: Se cuenta con un archivo con información de las diferentes distribuciones de Linux existentes. De cada distribución se conoce: nombre, año de lanzamiento, número de versión del kernel, cantidad de desarrolladores y descripción. El nombre de las distribuciones no puede repetirse. Este archivo debe ser mantenido realizando bajas lógicas y utilizando la técnica de reutilización de espacio libre llamada lista invertida. Escriba la definición de las estructuras de datos necesarias y los siguientes procedimientos:
ExisteDistribucion: módulo que recibe por parámetro un nombre y devuelve verdadero si
la distribución existe en el archivo o falso en caso contrario.
AltaDistribución: módulo que lee por teclado los datos de una nueva distribución y la
agrega al archivo reutilizando espacio disponible en caso de que exista. (El control de
unicidad lo debe realizar utilizando el módulo anterior). En caso de que la distribución que
se quiere agregar ya exista se debe informar “ya existe la distribución”.
BajaDistribución: módulo que da de baja lógicamente una distribución  cuyo nombre se
lee por teclado. Para marcar una distribución como borrada se debe utilizar el campo
cantidad de desarrolladores para mantener actualizada la lista invertida. Para verificar
que la distribución a borrar exista debe utilizar el módulo ExisteDistribucion. En caso de no
existir se debe informar “Distribución no existente”.

```pascal
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

function existeDistribucion(var a:archivo;nombre:string):boolean;
var
	dato:info;
begin
	reset(a);
	existeDistribucion:=false;
	while ((not eof(a)) and (not existeDistribucion)) do begin
		read(a,dato);
		if (dato.nombre=nombre) then
			existeDistribucion:=true;
	end;
	close(a);
end;

function leerInfo():info;
begin
	writeln('Ingrese nombre de la distribucion: ');
  readln(leerInfo.nombre);
  if (leerInfo.nombre<>'zzz') then begin
      writeln('Ingresa anio de lanzamiento: ');
      readln(leerInfo.anioLanzamiento);
      writeln('Ingresa version del kernel: ');
      readln(leerInfo.versionKernel);
      writeln('Ingresa cantidad de desarrolladores: ');
      readln(leerInfo.cantidadDesarrolladores);
      writeln('Ingresa descripcion: ');
      readln(leerInfo.descripcion);
  end;
end;

procedure altaDistribucion(var a:archivo);
var
	dato,nuevoDato:info;
begin
	nuevoDato:=leerInfo();
	if (not existeDistribucion(a,nuevoDato.nombre) then begin
		reset(a);
		read(a,dato);
		if (dato.cantidadDistribuidores=0) then begin // si la cabecera = 0 => no hay espacio disponible, asi que tengo que agregar a lo ultimo
			seek(a,filesize(a)); // 
			write(a,nuevoDato);
		end
		else begin // la cabecera tiene la posicion donde se puede agregar en negativo => por ejemplo -4
			seek(a,(dato.cantidadDesarrolladores * -1)); // me posiciono en la posicion valida donde se puede agregar(multiplico por -1)
			read(a,dato); // leo lo que hay en esa posicion donde se puede agregar
			seek(a,filepos(a)-1); // como leí, el puntero avanzó, asi que vuelvo a la posición anterior
			write(a,nuevoDato); // escribo el nuevo dato en esa posicion
			seek(a,0); // me posiciono en la cabecera
			write(a,dato); // escribo lo que habia en la posicion donde se pudo agregar
		end;
		writeln('Distribucion dada de alta.');
		close(a);
	end
	else
		writeln('Ya existe esa distribucion.');
end;

procedure bajaDistribucion(var a:archivo);
var
	dato,cabecera:info;
	nombreBaja:string;
begin
	writeln('Ingrese el nombre de la distribucion a dar de baja: ');
	readln(nombreBaja);
	if (existeDistribucion(a,nombreBaja) then begin // si existe la distribucion a eliminar
		reset(a);
		read(a,cabecera); // me guardo lo que hay en la cabecera
		read(a,dato);
		while (dato.nombre<>nombreBaja) do // avanzo en el archivo hasta encontrar la distribucion a eliminar
			read(a,dato);
		seek(a,filepos(a)-1); // cuando lo encontré, el puntero va a estar en el siguiente, me posiciono en la anterior
		write(a,cabecera); // escribo lo que había en la cabecera en la posición de la distribución a eliminar
		dato.cantidadDesarrolladores:= (filepos(name)-1)*-1; // me guardo la posición negativa en el dato que voy a escribir en la cabecera
		seek(a,0); // me posiciono en la cabecera
		write(a,dato); // escribo en la cabecera lo que habia en la posicion de la distribucion a eliminar (el dato tiene la posicion negativa)
		writeln('Se elimino la distribucion.');
		close(a);
	end
	else
		writeln('Distribucion no existente.');
end;

var
	a:archivo;
begin
	assign(a,'ArchivoEjercicio8');
	bajaDistribucion(a);
	altaDistribucion(a);
end.
```

---

# Árboles

## Árboles B

Los árboles B son árboles multicamino con una construcción especial de árboles que permite mantenerlos balanceados a bajo costo.

## Propiedades de orden M

- Cada nodo del árbol puede contener como máximo M descendientes directos (hijos) y M - 1 elementos.
- La raíz no posee descendientes directos o tiene al menos 2.
- Un nodo con X descendientes directos contiene X - 1 elementos.
- Todos los nodos salvo la raíz tienen como mínimo [ M / 2 ] - 1 elementos y como máximo M - 1 elementos.
- Todos los nodos terminales (hojas) se encuentran al mismo nivel.

## Altas

Cuando se agrega un elemento a un nodo, se debe agregar de forma ordenada, de menor a mayor. Es posible que se quiera agregar un elemento y el nodo esté lleno (tenga M) elementos, por lo que se produce overflow.

Ejemplo de árbol B, orden 4: 

![Screenshot 2023-06-04 131238.png](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Screenshot_2023-06-04_131238.png)

Nodo inicial del árbol vacío.

![Screenshot 2023-06-04 131257.png](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Screenshot_2023-06-04_131257.png)

Se agrega una clave: se lee el nodo raíz, y si se puede agregar, se genera una operación de escritura en ese nodo.

Operaciones: Lectura 0, Escritura 0.

![Screenshot 2023-06-04 131311.png](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Screenshot_2023-06-04_131311.png)

Se agrega una clave: se lee el nodo raíz, y si se puede agregar, se genera una operación de escritura en ese nodo.

Operaciones: Lectura 0, Escritura 0.

![Screenshot 2023-06-04 131338.png](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Screenshot_2023-06-04_131338.png)

Se agrega una clave: se lee el nodo raíz, y si se puede agregar, se genera una operación de escritura en ese nodo.

Operaciones: Lectura 0, Escritura 0.

Se quiere agregar el 67: hay overflow.

### Overflow

Se crea un nuevo nodo. La primera mitad de las claves se mantiene en el nodo con overflow. La segunda mitad de las claves se traslada a un nuevo nodo derecho, a excepción de la menor de las claves de esa segunda mitad, que se promociona al nodo padre.

25 40 67 96

Primera mitad: 25 y 40 se quedan en el Nodo 0.

Segunda mitad: 67 se promociona al nodo padre ya que es la clave menor (se crea un nuevo nodo raíz). 96 se traslada a un nuevo nodo derecho.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled.png)

Operaciones: Lectura del Nodo 0, Escritura del Nodo 0, Escritura del Nodo 1, Escritura del Nodo 2.

Se debe llevar un sólo algoritmo para escribir todas las operaciones de escritrura que se realizan: preorden, inorden o postorden. En este caso, es postorden: primero el hijo izquierdo (Nodo 0), luego el hijo derecho (Nodo 1) y por último la raíz (Nodo 2).

![Screenshot 2023-06-04 145723.png](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Screenshot_2023-06-04_145723.png)

Se agrega la clave 88. 

Operaciones: L2, L1, E1.

![Screenshot 2023-06-04 145733.png](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Screenshot_2023-06-04_145733.png)

Se agrega el 105.

Operaciones: L2, L1, E1.

![Screenshot 2023-06-04 145747.png](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Screenshot_2023-06-04_145747.png)

Se quiere agregar el 75: se produce overflow, 75 y 88 se quedan en el Nodo 1, 96 se promociona al nodo padre y 105 se traslada a un nuevo nodo.

![Screenshot 2023-06-04 145756.png](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Screenshot_2023-06-04_145756.png)

Operaciones: L2, L1, E1, E3, E2.

## Bajas

Se producen cuando se quiere eliminar una clave del árbol.

Si la clave a eliminar no está en una hoja, se debe reemplazar con la menor clave del subárbol derecho.

Si el nodo hoja contiene por lo menos el mínimo número de claves luego de la eliminación, no se requiere ninguna acción adicional. Si al eliminar una clave el nodo queda con menos del mínimo, se produce underflow.

### Underflow

Lo primero que se trata de hacer es redistribuir la carga de claves entre los nodos hojas. La redistirbución es un proceso mediante el cual se trata de dejar cada nodo lo más equitativamente cargado posible. Si la redistribución no es posible, entonces se debe fusionar con el hermano adyacente.

Hay distintas políticas para la resolución de underflow. Si el nodo es extremo (es decir, sólo tiene un hermano), se debe tratar de redistribuir con ese nodo y no se tiene en cuenta la política. Si no es posible, se fusiona con ese nodo. Si el nodo tiene más de un hermano, se sigue la política elegida, que puede ser alguna de las siguientes:

1. Política izquierda: se intenta redistribuir con el hermano adyacente izquierdo, si no es posible debido a que ya tiene la mínima cantidad, se fusiona con el hermano adyacente izquierdo.
2. Política derecha: se intenta redistribuir con el hermano adyacente derecho, si no es posible debido a que ya tiene la mínima cantidad, se fusiona con el hermano adyacente derecho.
3. Política izquierda o derecha: se intenta redistribuir con el hermano adyacente izquierdo, si no es posible debido a que ya tiene la mínima cantidad, se intenta con el hermano adyacente derecho, si tampoco es posible debido a que ya tiene la mínima cantidad, se fusiona con el hermano adyacente izquierdo.
4. Política derecha o izquierda: se intenta redistribuir con el hermano adyacente derecho, si no se puede debido a que ya tiene la mínima cantidad, se trata de redistribuir con el hermano adyacente izquierdo, si tampoco es posible debido a que ya tiene la mínima cantidad, se fusiona con el hermano adyacente derecho.

Supongamos este árbol:

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%201.png)

Se quiere eliminar el 75: se elimina sin problemas ya que al hacerlo, el Nodo 1 no se queda en underflow porque tiene la cantidad mínima de claves. Las operaciones fueron: L7, L2, L1, E1.

Se quiere eliminar el 88: como no está en un nodo hoja, se reemplaza por la clave menor del subárbol derecho, que en este caso es el 91.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%202.png)

Las operaciones fueron: L7, L6, L4, E4, E7.

Se quiere eliminar el 70: se producirá underflow porque el Nodo 1 quedaría con 0 claves ( el mínimo es [ 4 / 2 ] - 1 = 1. Se sigue una política de derecha o izquierda: no se puede redistribuir con el hermano derecho (Nodo 5) porque también tiene el mínimo de claves, por lo que se tiene que redistribuir con el hermano izquierdo. 

Se seleccionan todas las claves de los nodos que forman parte de la redistribución y la clave padre de éstos:

25 40 55 67 

Primera mitad: 25 y 40 se quedan en el Nodo 0.

Segunda mitad: 55 se promociona al nodo padre porque es la menor de las claves, 67 se traslada al nodo derecho.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%203.png)

Operaciones: L7, L2, L1, L0, E0, E1, E2.

Se elimina el 105. Operaciones: L7, L6, L3, E3.

Se elimina el 86: es un nodo extremo (sólo tiene un hermano, el Nodo 1), se trata de redistribuir pero no es posible porque tiene la mínima cantidad, por lo que se tienen que fusionar.

En la fusión de nodos, el nodo derecho queda liberado, y el nodo de la izquierda pasa a tener todas las claves. Una clave del nodo padre de los nodos fusionados debe “bajar”, para que se cumpla que si un nodo tiene X descendientes, debe tener X - 1 claves. La clave 80 baja al Nodo 1.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%204.png)

Operaciones: L7, L2, L5, L1, E1, E2.

Se elimina el 230: Operaciones: L7, L6, L3, E3.

Se elimina el 95: se trata de redistribuir con su único hermano, no es posible porque tiene la mínima cantidad, entonces se fusionan: El 96 baja al Nodo 4, y se libera el Nodo 3.

Ahora, el Nodo 6 queda en underflow: se trata de redistribuir con su hermano adyacente (Nodo 2), no es posible porque tiene la mínima cantidad de claves, por lo que se fusionan: El 91 baja al Nodo 2, y se libera el Nodo 6. Se decrementa la altura del árbol.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%205.png)

## Árboles B+

Constituyen una mejora sobre los árboles B, pues conservan la propiedad de acceso aleatorio rápido y permiten además un recorrido secuencial rápido.

Conjunto índice: proporciona acceso indizado a los registros. Todas las claves se encuentran en las hojas, duplicándose en la raíz y nodos interiores aquellas que resulten necesarias para definir los caminos de búsqueda.

Conjunto secuencia: Contiene todos los registros del archivo. Las hojas se vinculan para facilitar el recorrido secuencial rápido. Cuando se lee en orden lógico, lista todos los registros por el orden de la clave.

Para la búsqueda de una clave en un árbol B+, se deberá buscar en las hojas ya que allí se encuentran las claves hasta encontrar la clave deseada o se termine el árbol.

### Overflow

El nodo afectado se divide en 2. Una copia de la clave del medio o la menor de la segunda mitad se promociona al nodo padre. Se deberá creer un nodo derecho con las claves de la segunda mitad. La copia de la clave sólo se realiza cuando el overflow sucede en un nodo hoja, sino el tratamiento del overflow es igual al de árboles B.

### Bajas

Las claves a eliminar siempre se encuentran en las hojas. Si al eliminar una clave, la cantidad de claves que queda es mayor o igual que [ M / 2 ] - 1, la operación termina. Las claves de los nodos raíz o internos no se modifican, por más que haya copias de las claves eliminadas.

Si al eliminar una clave, la cantidad de claves es menor que [ M / 2 ] - 1, entonces se produce underflow: se debe tratar de redistribuir con las mismas políticas que los árboles B, y si no es posible, se deben fusionar los nodos.

Ejemplo de árbol B+, orden 4:

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%206.png)

Se agrega el 50 al Nodo 0. Operaciones: E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%207.png)

Se agrega el 75 al Nodo 0. Operaciones: L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%208.png)

Se agrega el 23 al Nodo 0. Operaciones: L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%209.png)

Se agrega el 8, hay overflow: la primera mitad (8,23), se quedan en el Nodo 0, la segunda mitad (50, 75) se traslada a un nuevo nodo derecho, y una copia del menor de esta segunda mitad se promociona al nodo padre. Se incrementa la altura del árbol. Operaciones: L0, E0, E1, E2.

Supongamos este árbol B+:

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2010.png)

Se quiere agregar la clave 100: se genera overflow en el Nodo 4. La primera mitad (88,90) se quedan en el Nodo 4, la segunda mitad (100,121) se trasladan a un nuevo nodo derecho, y una copia de la menor de la segunda mitad (100) se promociona al nodo padre.

Ahora, hay overflow en el Nodo 2. Como no es un nodo hoja, la primera mitad (15 y 50) se quedan en el Nodo 2, el menor de la segunda mitad (88) se promociona al nodo padre, y la segunda mitad (100) se traslada a un nuevo nodo derecho. Se incrementa la altura del árbol. Árbol resultante: 

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2011.png)

Operaciones: L2, L4, E4, E5, E2, E6, E7.

Se elimina el 8. Operaciones: L7, L2, L0, E0.

Se elimina el 100. Operaciones: L7, L6, L5, E5.

Se elimina el 121, hay underflow. Se trata de redistribuir con su hermano adyacente y es posible porque no tiene la cantidad mínima de claves. La primera mitad (88) se queda en el Nodo 4, la segunda mitad (90) se traslada al nodo derecho, y una copia de la menor de las claves se promociona al nodo padre. Árbol resultante:

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2012.png)

Operaciones: L7, L6, L5, L4, E4, E5, E6.

Se elimina el 88: se trata de redistirbuir con su hermano adyacente (Nodo 5), no se puede porque tiene la cantidad mínima de claves, por lo que se fusionan. Se libera el Nodo 5. El 90 del Nodo 6 “baja”, entonces el Nodo 4 queda con 90.

El Nodo 6 ahora se encuentra en underflow: se trata de redistribuir con su hermano adyacente (Nodo 2) y es posible. La primer mitad (15) queda en el Nodo 2, la segunda se traslada al nodo derecho (88), y la menor de la segunda mitad (50) se promociona al nodo padre. Como la clave del nodo raíz cambió, los subárboles también. Árbol resultante:

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2013.png)

Operaciones: L7, L6, L4, L5, E4, L2, E2, E6, E7.

Se elimina el 90: se redistribuye con el Nodo 1, la primer mitad (50) se queda en el Nodo 1, la segunda mitad (75) se traslada al nodo derecho y una copia se promociona al nodo padre. Operaciones: L7, L6, L4, L1, E1, E4, E6.

Se elimina el 50: se trata de redistribuir con el Nodo 4, no se posible porque solo tiene una clave, por lo que se fusionan. La clave del Nodo 6 “baja”.

El Nodo 6 queda en underflow. Se trata de redistribuir con su hermano adyacente (Nodo 2), pero no se puede porque sólo tiene una clave, por lo que se fusionan en el Nodo 2. Se libera el Nodo 6. La clave del Nodo 7 “baja”. Se libera el Nodo 7.  Se decrementa la altura del árbol. Árbol resultante:

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2014.png)

Operaciones: L7, L6, L1, L4, E1, L2, E2.

Ejercicio 10 de la Práctica 4: Dada las siguientes operaciones, mostrar la construcción paso a paso de un árbol B de orden 4: +50 , +70, +40, +15, +90, +120, +115, +45, +30, +100, +112, +77, -45, -40, -50, -90, -100. Política de resolución de underflows: izquierda o derecha.

Mínimo de claves por nodo: 4/2 - 1 = 1.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2015.png)

### +50:

Se agrega la clave 50 al Nodo 0.

Operaciones: E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2016.png)

### +70:

Se agrega la clave 70 al Nodo 0.

Operaciones: L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2017.png)

### +40:

Se agrega la clave 40 al Nodo 0.

Operaciones: L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2018.png)

### +15:

Se agrega la clave 15 al Nodo 0, hay overflow: 15 y 40 se quedan en el Nodo 0, se traslada el 70 a un nuevo Nodo, y el 50 se promociona a un nuevo nodo padre (raíz). Se incrementa la altura del árbol.

Operaciones: L0, E0, E1, E2.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2019.png)

### +90:

Se agrega la clave 90 al Nodo 1.

Operaciones: L2, L1, E1.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2020.png)

### +120:

Se agrega la clave 120 al Nodo 1.

Operaciones: L2, L1, E1.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2021.png)

### +115:

Se agrega la clave 115 al Nodo 1, hay overflow: 70 y 90 se quedan en el Nodo 1, 120 se traslada a un nuevo nodo y 115 se promociona al nodo padre.

Operaciones: L2, L1, E1, E3, E2.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2022.png)

### +45:

Se agrega la clave 45 al Nodo 0.

Operaciones: L2, L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2023.png)

### +30:

Se agrega la clave 30 al Nodo 0, hay overflow, el 15 y el 30 se quedan en el Nodo 0, el 45 se traslada a un nuevo nodo y el 40 se promociona al nodo padre (Nodo 2).

Operaciones: L2, L0, E0, E4, E2.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2024.png)

### +100:

Se agrega la clave 100 al Nodo 1.

Operaciones: L2, L1, E1.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2025.png)

Operaciones: L2, L1, E1, E5, E2, E6, E7.

### +112:

Se agrega la clave al Nodo 1, hay overflow, 70 y 90 se quedan en el Nodo 1, 100 se promociona al nodo padre y 112 se traslada a un nuevo nodo.

Se agrega el 100 al Nodo 2, hay overflow, 40 y 50 se quedan en el Nodo 2, 155 se traslada a un nuevo nodo y 100 se promociona a un nuevo nodo padre. Se aumenta la altura del árbol.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2026.png)

### +77:

Se agrega la clave al Nodo 1.

Operaciones: L7, L2, L1, E1.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2027.png)

Operaciones: L7, L2, L4, L0, E4, E0.

### -45:

Se elimina la clave del Nodo 4, hay underflow, se redistribuye con el hermano izquierdo y se balancea la carga.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2028.png)

Operaciones: L7, L2, L4, L0, L1, E4, E1, E2.

### -40:

Se elimina el 40 del Nodo 4, hay underflow, se trata de redistribuir con el hermano izquierdo, no se puede ya que tiene la cantidad mínima de nodos, se redistribuye con el hermano derecho.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2029.png)

### -50:

Se elimina el 50 del Nodo 4.

Operaciones: L7, L2, L4, E4.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2030.png)

Operaciones: L7, L2, L1, L4, E4, E2.

### -90:

Se elimina el 90 del Nodo 1, hay underflow, se trata de redistribuir con el hermano adyacente ya que es un nodo extremo, no se puede ya que tiene la cantidad mínima de nodos, así que se fusiona con éste. La clave padre baja. Se libera el Nodo 1.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2031.png)

Operaciones: L7, L6, L5, L3, E5, L2, E2.

### -100:

Se elimina el 100 del Nodo 7, se reemplaza por la clave de menor valor del subárbol derecho.

El Nodo 5 queda en underflow, no se puede redistribuir con el Nodo 3, se fusiona. La clave padre baja. Se libera el Nodo 3.

El Nodo 6 queda en underflow, no se puede redistribuir con el Nodo 2, se fusiona. La clave padre baja. Se libera el Nodo 6. Se decrementa la altura del árbol.

Ejercicio 17 de la Práctica 4: Dada las siguientes operaciones, mostrar la construcción paso a paso de un árbol B+ de orden 6: +52, +23, +10, +99, +63, +74, +19, +85, +14, +73, +5, +7, +41, +100, +130, +44, -63, -73, +15,+16, -74, -52. Política de resolución de underflows: izquierda.

Cantidad mínima de claves por nodo: 6 / 2 -1 = 2.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2032.png)

### +52:

Se agrega el 52 al Nodo 0.

Operaciones: E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2033.png)

### +23:

Se agrega el 23 al Nodo 0.

Operaciones: L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2034.png)

### +10:

Se agrega el 10 al Nodo 0.

Operaciones: L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2035.png)

### +99:

Se agrega el 99 al Nodo 0.

Operaciones: L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2036.png)

### +63:

Se agrega el 63 al Nodo 0.

Operaciones: L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2037.png)

Operaciones: L0, E0, E1, E2.

### +74:

Se agrega el 74 al Nodo 0, hay underflow: 10, 23 y 52 se quedan en el Nodo 0, una copia de 63 se promociona al nodo padre (nuevo nodo raíz) y 63, 74 y 99 se mueven al Nodo 1. Se incrementa la altura del árbol.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2038.png)

### +19:

Se agrega el 19 al Nodo 0.

Operaciones: L2, L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2039.png)

### +85:

Se agrega el 85 al Nodo 1.

Operaciones: L0, L1, E1.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2040.png)

### +14:

Se agrega el 14 al Nodo 0.

Operaciones: L2, L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2041.png)

### +73:

Se agrega el 73 al Nodo 1.

Operaciones: L2, L1, E1,

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2042.png)

Operaciones: L2, L0, E0, E3, E2.

### +5:

Se agrega el 5 al Nodo 0, hay overflow: 5, 10 y 14 se quedan en el Nodo 0, 19, 23 y 52 se trasladan a un nuevo nodo, y una copia de 19 se promociona al nodo padre.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2043.png)

### +7:

Se agrega el 7 al Nodo 0.

Operaciones: L2, L0, E0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2044.png)

### +41:

Se agrega el 41 al Nodo 3.

Operaciones: L2, L3, E3.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2045.png)

Operaciones: L2, L1, E1, E4, E2.

### +100:

Se agrega el 100 al Nodo 1, hay overflow: 63, 73 y 74 se quedan en el Nodo 1, 85, 99 y 100 se trasladan a un nuevo nodo, una copia de 85 se promociona al nodo padre.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2046.png)

### +130:

Se agrega el 130 al Nodo 4.

Operaciones: L2, L4, E4.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2047.png)

Operaciones: L2, L3. E3.

### +44:

Se agrega el 44 al Nodo 3.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2048.png)

### -63:

Se elimina el 63 del Nodo 1.

Operaciones: L2, L1, E1.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2049.png)

Operaciones: L2, L1, L3, E3, E1, E2.

### -73:

Se elimina el 73 del Nodo 1, hay underflow: se redistribuye con su hermano izquierdo. Se juntan las cargas del Nodo 3 y del Nodo 1, la primera mitad se queda en el Nodo 3, la segunda mitad en el Nodo 1, y una copia de la clave menor de la segunda mitad se promociona al nodo padre.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2050.png)

Operaciones: L2, L0, E0.

### +15:

Se agrega el 15 al Nodo 0.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2051.png)

Operaciones: L2, L0, E0, E5, E2.

### +16:

Se agrega el 16 al Nodo 0, hay overflow: 5, 7, y10 se quedan en el Nodo 0, 14, 15 y 16 se trasladan a un nuevo nodo, una copia de 14 se promociona al nodo padre.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2052.png)

Operaciones: L2, L1, E1.

### -74:

Se elimina el 74 del Nodo 1.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2053.png)

Operaciones: L2, L1, L3, E3, E1, E2.

### -52:

Se elimina el 52 del Nodo 1, hay underflow: se redistribuye con el hermano izquierdo. 19 y 23 se quedan en el nodo de la izquierda, 41 y 44 en el nodo de la derecha y una copia de 41 se promociona al nodo padre.

---

# Hashing

Técnica para generar una dirección base única para una clave dada. Convierte la clave en un número aleatorio, que luego sirve para determinar dónde se almacena la clave. Utiliza una función de dispersión para mapear cada clave con una dirección física de almacenamiento. Utilizada cuando se requiere acceso rápido por clave.

### Tipos de Dispersión

- Direccionamiento estático: El espacio disponible para dispersar los registros del archivo está fijado previamente.
- Direccionamiento dinámico: El espacio disponible para dispersar los registros del archivo aumenta o disminuye en función de las necesidades.

### Parámetros:

Parámetros que influyen sobre el desempeño del ambiente de dispersión:

- Capacidad de almacenamiento de cada dirección.
- Densidad de empaquetamiento.
    
    Relación entre el espacio disponible para el archivo de datos y la cantidad de registros que integran el mismo. DE = número de registros / espacio total.
    
- Función de hash.
    
    Caja negra que a partir de una clave genera la dirección física donde debe almacenarse el registro.
    
- Método de tratamiento de desbordes.

Colisión: Situación en la que un registro es asignado, por la función de hash, a una dirección que ya posee 1 o más registros.

Desborde / Overflow: Situación en la cual una clave carece de lugar en la dirección asignada por la función de hash.

Aunque la función de dispersión sea eficiente y la densidad de empaquetamiento sea baja, es probable que ocurran desbordes. Métodos aplicables para resolver colisiones con desborde en dispersión estática:

- Saturación progresiva.
- Saturación progresiva encadenada.
- Saturación progresiva con área de desborde por separado.
- Dispersión doble.

## Saturación progresiva

Si se produce overflow, esta técnica busca la siguiente dirección disponible linealmente hasta encontrarla y agrega la clave.

Ejemplo:

| Dirección | Registro | Registro |
| --- | --- | --- |
| 0 |  |  |
| 1 | 78 |  |
| 2 |  |  |
| 3 | 58 | 91 |
| 4 |  |  |
| 5 | 60 | 27 |
| 6 |  |  |
| 7 |  |  |
| 8 | 85 |  |
| 9 |  |  |
| 10 |  |  |

Se quieren agregar las claves:

- 25. f(25) = 3.
    
    Como la dirección 3 ya está llena, se produce una colisión con overflow, y el método de saturación progresiva agrega la clave en la próxima dirección libre.
    
- 38. f(38) = 5.
    
    Colisión con overflow. Se agrega en la siguiente dirección libre.
    
- 81. f(81) = 4. Colisión.
- 14. f(14) = 3. Colisión con overflow. Se agrega en la siguiente dirección libre.

Luego de agregar todas las claves, la tabla quedaría:

| Dirección | Registro | Registro |
| --- | --- | --- |
| 0 |  |  |
| 1 | 78 |  |
| 2 |  |  |
| 3 | 58 | 91 |
| 4 | 25 | 81 |
| 5 | 60 | 27 |
| 6 | 38 | 14 |
| 7 |  |  |
| 8 | 85 |  |
| 9 |  |  |
| 10 |  |  |

Se quieren eliminar las claves:

- 58. f(58) = 3.
- 81. f(81) = 4.
- 14. f(14) = 6.

Se usa una marca ### cuando se elimina una clave de una dirección llena y en la próxima dirección hay por lo menos una marca u otra clave.

Luego de eliminar esas claves, la tabla quedaría:

| Dirección | Registro | Registro |
| --- | --- | --- |
| 0 |  |  |
| 1 | 78 |  |
| 2 |  |  |
| 3 | ### | 91 |
| 4 | 25 | ### |
| 5 | 60 | 27 |
| 6 | 38 |  |
| 7 |  |  |
| 8 | 85 |  |
| 9 |  |  |
| 10 |  |  |

## Saturación progresiva encadenada

En la saturación progresiva encadenada, cada dirección posee un enlace a otra dirección donde se almacena una clave. Este enlace está activo si cuando se quiso agregar en la dirección se produjo colisión con overflow (no había más espacio), por lo que esta técnica busca la siguiente dirección libre, inserta allí la clave que causó overflow, y en la dirección original (resultado de la función hash) establece un enlace con esa dirección donde se agregó.

Ejemplo:

| Dirección | Enlace | Registro |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | -1 | 78 |
| 2 | -1 |  |
| 3 | -1 | 58 |
| 4 | -1 | 92 |
| 5 | -1 | 60 |
| 6 | -1 |  |
| 7 | -1 |  |
| 8 | -1 | 85 |
| 9 | -1 |  |
| 10 | -1 |  |

Se quieren agregar las claves:

- 56. f(56) = 1.
    
    Se genera colisión con overflow. 56 se inserta en la siguiente dirección libre (2) como clave intrusa, y el enlace de la dirección 1 pasa a ser la dirección donde se agregó, 2.
    
- 25. f(25)=3.
    
    Se genera colisión con overflow. 25 se inserta en la siguiente dirección libre (6) como clave intrusa, y el enlace de la dirección 3 pasa a ser la dirección donde se agregó, 6.
    
- 72. f(72) = 6. Se genera colisión con overflow. Como la clave que se encuentra es intrusa, se mueve a la siguiente dirección libre, y el 72 se agrega en la dirección 6. La dirección que tenía el enlace de esta clave es actualizado.
- 23. f(23) = 1. Se genera colisión con overflow. 23 se inserta en la siguiente dirección libre (9), y el enlace de la dirección 1 pasa a ser la dirección donde se agregó, 9. Como la dirección 1 ya tenía un enlace (dirección 2), este va a ser el nuevo enlace de la dirección 9.

Luego de agregar las claves, la tabla quedaría: 

| Dirección | Enlace | Registro |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | 9 | 78 |
| 2 | -1 | 56 |
| 3 | 7 | 58 |
| 4 | -1 | 92 |
| 5 | -1 | 60 |
| 6 | -1 | 72 |
| 7 | -1 | 25 |
| 8 | -1 | 85 |
| 9 | 2 | 23 |
| 10 | -1 |  |

Se quieren eliminar las claves:

- 23. f(23)= 1. No se encuentra el 23 en la dirección 1, por lo que se siguen los enlaces. Una vez que se encuentra en la dirección 9, se elimina, y el enlace que tenía pasa a la dirección 1.
- 78. f(78) = 1. Se elimina el 78 de la dirección 1, y como tenía un enlace, la clave que estaba en la dirección enlazada toma su lugar.

Luego de eliminar esas claves, la tabla quedaría:

| Dirección | Enlace | Registro |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | -1 | 56 |
| 2 | -1 |  |
| 3 | 7 | 58 |
| 4 | -1 | 92 |
| 5 | -1 | 60 |
| 6 | -1 | 72 |
| 7 | -1 | 25 |
| 8 | -1 | 85 |
| 9 | -1 |  |
| 10 | -1 |  |

## Saturación progresiva con área de desborde por separado

Se cuenta con un área de desborde por separado. Cuando se produce una colisión con overflow, la clave se inserta en esta área separada, y el enlace de la dirección referencia a esta área separada.

Ejemplo:

| Dirección | Enlace | Registro 1 | Registro 2 |
| --- | --- | --- | --- |
| 0 | -1 |  |  |
| 1 | -1 | 78 | 56 |
| 2 | -1 |  |  |
| 3 | -1 | 58 |  |
| 4 | -1 | 92 |  |
| 5 | -1 | 60 |  |
| 6 | -1 |  |  |
| 7 | -1 |  |  |
| 8 | -1 | 85 |  |
| 9 | -1 |  |  |
| 10 | -1 |  |  |

| Dirección | Enlace | Registro |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | -1 |  |
| 2 | -1 |  |

Se quieren agregar las claves:

- 12. f(12) = 1. Se genera colisión con overflow. Se inserta en el área separada y se actualiza el puntero en la tabla para hacer referencia para futúras búsquedas.
- 23. f(23) = 1. Se genera colisión con overflow. Se inserta en el área separada y se actualiza el puntero en la tabla para hacer referencia para futúras búsquedas. El enlace previo de la dirección 1 pasa a ser el enlace de la dirección donde se acaba de agregar.

Luego de agregar las claves, las tablas quedarían: 

| Dirección | Enlace | Registro 1 | Registro 2 |
| --- | --- | --- | --- |
| 0 | -1 |  |  |
| 1 | 1 | 78 | 56 |
| 2 | -1 |  |  |
| 3 | -1 | 58 |  |
| 4 | -1 | 92 |  |
| 5 | -1 | 60 |  |
| 6 | -1 |  |  |
| 7 | -1 |  |  |
| 8 | -1 | 85 |  |
| 9 | -1 |  |  |
| 10 | -1 |  |  |

| Dirección | Enlace | Registro |
| --- | --- | --- |
| 0 | -1 | 12 |
| 1 | 0 | 23 |
| 2 | -1 |  |

Se quieren eliminar las claves:

- 12. f(12) = 1. No se encuentra en la dirección 1, se siguen los enlaces hasta encontrarlo en la dirección 0 del área de desborde. Se elimina, y la dirección que tenía como enlace su dirección, se actualiza.
- 78. f(78) = 1. Se elimina la clave de la dirección 1.
- 56. f(56) = 1. Se elimina la clave de la dirección 1. Las claves de los enlaces de la dirección no toman su lugar, quedan en el área separada.

Luego de eliminar las claves, las tablas quedarían: 

| Dirección | Enlace | Registro 1 | Registro 2 |
| --- | --- | --- | --- |
| 0 | -1 |  |  |
| 1 | 1 |  |  |
| 2 | -1 |  |  |
| 3 | -1 | 58 |  |
| 4 | -1 | 92 |  |
| 5 | -1 | 60 |  |
| 6 | -1 |  |  |
| 7 | -1 |  |  |
| 8 | -1 | 85 |  |
| 9 | -1 |  |  |
| 10 | -1 |  |  |

| Dirección | Enlace | Registro |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | -1 | 23 |
| 2 | -1 |  |

## Dispersión doble

En este método, cuando se produce una colisión con overflow, se aplica una segunda función de hash, el cual el resultado de ésta se suma al resultado de la primera función de hash hasta encontrar una dirección libre.

Ejemplo:

| Dirección | Registro 1 | Registro 2 |
| --- | --- | --- |
| 0 |  |  |
| 1 | 34 | 78 |
| 2 |  |  |
| 3 | 91 | 14 |
| 4 | 15 |  |
| 5 | 60 | 27 |
| 6 |  |  |
| 7 |  |  |
| 8 | 85 |  |
| 9 |  |  |
| 10 |  |  |
- 36. f1(36) = 3. Colisión con overflow, se aplica la segunda función de hash. f2(36) = 2. 3 + 2 = 5. Colisión con overflow, se aplica la segunda función nuevamente. 5 + 2 = 7.

Se quieren agregar las claves:

- 12. f1(12) = 1. Se genera colisión con overflow, por lo que se aplica la segunda función de hash. f2(12) = 3.
    
    A la dirección base se le suma el resultado de la segunda función (desplazamiento). 1 + 3 = 4. 
    
- 38. f1(38) = 5. Se genera colisión con overflow, por lo que se aplica la segunda función de hash. f2(38) = 4.
    
    A la dirección base se le suma el resultado de la segunda función. 5 + 4 = 9.
    

Luego de agregar las claves, la tabla quedaría:

| Dirección | Registro 1 | Registro 2 |
| --- | --- | --- |
| 0 |  |  |
| 1 | 34 | 78 |
| 2 |  |  |
| 3 | 91 | 14 |
| 4 | 15 | 12 |
| 5 | 60 | 27 |
| 6 |  |  |
| 7 | 36 |  |
| 8 | 85 |  |
| 9 | 38 |  |
| 10 |  |  |

Se quieren eliminar las claves:

- 27. f1(27) = 5. Se elimina y se deja marca de borrado.
- 38. f(38) = 5. No se encuentra en la dirección 5, por lo que se suma el resultado de la segunda función de hash. f2(38) = 4.
    
    5 + 4 = 9. Se elimina y se deja marca de borrado.
    

Luego de eliminar las claves, la tabla quedaría:

| Dirección | Registro 1 | Registro 2 |
| --- | --- | --- |
| 0 |  |  |
| 1 | 34 | 78 |
| 2 |  |  |
| 3 | 91 | 14 |
| 4 | 15 | 12 |
| 5 | 60 | ### |
| 6 |  |  |
| 7 | 36 |  |
| 8 | 85 |  |
| 9 | ### |  |
| 10 |  |  |

## Dispersión dinámica

En la dispersión dinámica, las direcciones donde se van a ir guardando los registros de los archivos se deben ir creando a medida que se necesitan, y no hay una cantidad fija de antemano.

En el estado inicial del archivo, hay una tabla en memoria y direcciones en disco que son referenciadas por las entradas de la tabla de memoria. Tanto la tabla en memoria como las direcciones en disco tienen un valor asociado que indica la cantidad de bits necesarios para acceder a esa dirección.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2054.png)

Se van agregando claves a la dirección en disco. Cuando no se pueden agregar más claves, se produce overflow: se incrementa en uno el valor asociado a la dirección en overflow y se genera una nueva dirección con ese mismo valor. Como ahora hay 2 direcciones en disco y 1 dirección en la tabla en memoria, la tabla no dispone de entradas suficientes para direccionar a las nuevas direcciones y hace falta generar más direcciones. La cantidad de celdas de la tabla se duplica y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2055.png)

Las claves son secuencias de bits. Se deben tomar la cantidad de bits que indique el valor asociado a la tabla en memoria (en este caso 1) de derecha a izquierda de esas cadenas, y ver cuál entrada en la tabla de memoria apunta a ese bit.

Por ejemplo, se agarra el último bit de Beta y de Gamma (0), por lo que se redispersan en la dirección 0 en la tabla en memoria. El último bit de Alfa y Delta es 1, y por eso están en la dirección 1 en la tabla en memoria.

Se quiere agregar la clave Epsilon que su cadena es: 0…000. Debe ser agregado en la dirección 0, por lo que se genera overflow.

Se incrementa en uno el valor asociado a la dirección en overflow y se genera una nueva dirección con ese mismo valor. Ahora hay 3 direcciones. La tabla en memoria no tiene entradas suficientes para referenciar 3 direcciones, por lo que debe duplicar su tamaño. Se aumenta en uno el valor asociado a la tabla en memoria y se generan nuevas direcciones: a las direcciones que estaban antes se les agrega un 0 al final: 0 pasa a ser 00, 1 pasa a ser 10; las nuevas direcciones serán iguales a exepción del último bit que debe ser cambiado por un 1 ordenadamente: se crea la dirección 01 y 11 en la tabla en memoria.

Ahora, deben redispersarse solamente las claves de las direcciones involucradas: Beta, Gamma y Epsilon, agarrando la cantidad de bits que indique el valor asociado en la tabla en memoria de derecha a izquierda. Los últimos 2 bits de Beta son 00, los últimos 2 bits de Epsilon son 00, los últimos 2 bits de Gamma son 10.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2056.png)

La dirección 00 apunta a la dirección que contiene Beta y Epsilon debido a que ambas terminan en 00. La dirección 10 apunta a la dirección que contiene Gamma debido a que termina en 10. Las direcciones 01 y 11 apuntan a la dirección que contiene Alfa y Delta porque se agarra la cantidad de bits que indique el valor asociado a esa dirección (en este caso 1) de derecha a izquierda y ambas forman 1, que es como terminan Alfa y Delta.

Se inserta Rho, que su cadena es 00…1011. Debe insertarse en la dirección 11 pero está llena, por lo que se produce overflow. Se incrementa en uno el valor asociado a esa dirección y se genera una nueva con el mismo valor. Se redispersan las claves involucradas: Alfa termina en 01, Delta y Rho terminan en 11, por lo que la tabla ahora queda:

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2057.png)

No hizo falta duplicar la cantidad de entradas en tabla en memoria porque posee direcciones suficientes para referenciar a esta nueva dirección generada.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2058.png)

Se quiere insertar la clave PSI, la cual su clave es 00…0001. Debe agregarse en la dirección 01, la cual ya está llena, por lo que hay overflow. Se incrementa en uno el valor asociado a esa dirección, se genera una nueva dirección con ese mismo valor, y como la tabla no posee suficientes entradas en memoria se duplica la cantidad de entradas. Se redispersan las claves involucradas.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2059.png)

Las entradas 000 y 100 apuntan a la dirección que contiene Beta y Epsilon porque, tomando sus 2 últimos bits, se puede formar el patrón 00, que es el mismo patrón que tienen los 2 últimos bits de las claves de Beta y Epsilon.

Las entradas 010 y 110 apuntan a la dirección que contiene Gamma y Pi porque, tomando sus 2 últimos bits, se puede formar el patrón 10, que es el mismo patrón que tienen los 2 últimos bits de las claves de Gamma y Pi.

La entrada 001 apunta a la dirección que contiene Alfa y Psi porque, tomando sus 3 úlitmos bits, se puede formar el patrón 001, que es el mismo patrón que tienen los úlitmos 3 bits de las claves de Alfa y Psi.

La entrada 101 apunta a la dirección que contiene Tau porque, tomando sus últimos 3 bits, se puede formar el patrón 101, que es el mismo patrón que tienen los últimos 3 bits de la clave de Tau.

Las entradas 011 y 111 apuntan a la dirección que contiene Delta y Rho porque, tomando sus últimos 2 bits, se puede formar el patrón 11, que es el mismo patrón que tienen los últimos 2 bits de las claves Delta y Rho.

Al momento de duplicar la cantidad de entradas, a las entradas que estaban antes se les agregó un 0 al final: 00 pasó a ser 000, 10 pasó a ser 100, 01 pasó a ser 010 y 11 pasó a ser 110. Las nuevas entradas tienen estos mismos valores pero con el último bit es 1 en vez de 0, siguiendo el orden.

Ejercicio 6 de la Práctica 4: Dado el archivo dispersado a continuación, grafique los estados sucesivos, indique lecturas y escrituras y calcule la densidad de empaquetamiento para las siguientes operaciones: +31, +82, -15, -52. Técnica de resolución de colisiones: Saturación progresiva. f(x) = x MOD 10.

Archivo inicial: 

| Dirección | Clave | Clave |
| --- | --- | --- |
| 0 |  |  |
| 1 | 11 | 21 |
| 2 | 52 |  |
| 3 | 13 | 93 |
| 4 |  |  |
| 5 | 15 |  |
| 6 |  |  |
| 7 | 17 | 97 |
| 8 |  |  |
| 9 |  |  |

| Dirección | Clave | Clave |
| --- | --- | --- |
| 0 |  |  |
| 1 | 11 | 21 |
| 2 | 52 | 31 |
| 3 | 13 | 93 |
| 4 |  |  |
| 5 | 15 |  |
| 6 |  |  |
| 7 | 17 | 97 |
| 8 |  |  |
| 9 |  |  |

### +31:

31 mod 10 = 1.

Se trata de agregar la clave 31 a la dirección 1, no se puede porque ya hay 2 claves, hay overflow, se almacena en la siguiente dirección libre.

Operaciones: L1, L2, E2.

| Dirección | Clave | Clave |
| --- | --- | --- |
| 0 |  |  |
| 1 | 11 | 21 |
| 2 | 52 | 31 |
| 3 | 13 | 93 |
| 4 | 82 |  |
| 5 | 15 |  |
| 6 |  |  |
| 7 | 17 | 97 |
| 8 |  |  |
| 9 |  |  |

### +82:

82 mod 10 = 2.

Se trata de agregar la clave 82 a la dirección 2, no se puede porque ya hay 2 claves, hay overflow, se almacena en la siguiente dirección libre.

Operaciones: L2, L3, L4, E4.

| Dirección | Clave | Clave |
| --- | --- | --- |
| 0 |  |  |
| 1 | 11 | 21 |
| 2 | 52 | 31 |
| 3 | 13 | 93 |
| 4 | 82 |  |
| 5 |  |  |
| 6 |  |  |
| 7 | 17 | 97 |
| 8 |  |  |
| 9 |  |  |

### -15:

15 mod 10 = 5.

Se elimina la clave 15 de la dirección 5, no se deja una marca porque la dirección no está llena.

Operaciones: L5, E5.

| Dirección | Clave | Clave |
| --- | --- | --- |
| 0 |  |  |
| 1 | 11 | 21 |
| 2 | ### | 31 |
| 3 | 13 | 93 |
| 4 | 82 |  |
| 5 |  |  |
| 6 |  |  |
| 7 | 17 | 97 |
| 8 |  |  |
| 9 |  |  |

### -52:

52 mod 10 = 2.

Se elimina la clave 52 de la dirección 2, como la dirección está llena y en la siguiente dirección hay datos se deja una marca.

Operaciones: L2, E2.

Densidad de empaquetamiento: 8 / 10*2 = 8 / 20 = 0,4 = 40%.

Ejercicio 8 de la Práctica 4: Dado el archivo dispersado a continuación, grafique los estados sucesivos para las siguientes operaciones: +23, +56, +90, +61, -49, -67. Técnica de resolución de colisiones: Saturación progresiva encadenada. f(x) = x MOD 11 

Archivo inicial:

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | -1 | 67 |
| 2 | -1 |  |
| 3 | -1 | 80 |
| 4 | -1 |  |
| 5 | 8 | 71 |
| 6 | -1 | 60 |
| 7 | -1 | 18 |
| 8 | 6 | 49 |
| 9 | -1 | 20 |
| 10 | -1 |  |

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | 2 | 67 |
| 2 | -1 | 23 |
| 3 | -1 | 80 |
| 4 | -1 |  |
| 5 | 8 | 71 |
| 6 | -1 | 60 |
| 7 | -1 | 18 |
| 8 | 6 | 49 |
| 9 | -1 | 20 |
| 10 | -1 |  |

### +23:

23 mod 11 = 1.

Se trata de agregar la clave 23 a la dirección 1, no se puede porque está llena, se genera overflow, se agrega en la siguiente dirección libre como clave intrusa y se modifica el enlace de la dirección 1 para que esté enlazada con la dirección en la que se agrega.

Operaciones: L1, L2, E2, E1.

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | 4 | 67 |
| 2 | -1 | 23 |
| 3 | -1 | 80 |
| 4 | 2 | 56 |
| 5 | 8 | 71 |
| 6 | -1 | 60 |
| 7 | -1 | 18 |
| 8 | 6 | 49 |
| 9 | -1 | 20 |
| 10 | -1 |  |

### +56:

56 mod 11 = 1.

Se trata de agregar la clave 56 a la dirección 1, no se puede porque está llena, se genera overflow, se agrega en la siguiente dirección libre como clave intrusa y se modifica el enlace de la dirección 1 para que esté enlazada con la dirección en la que se agrega.

Operaciones: L1, L2, L3, L4, E4, E1.

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | 4 | 67 |
| 2 | -1 | 90 |
| 3 | -1 | 80 |
| 4 | 10 | 56 |
| 5 | 8 | 71 |
| 6 | -1 | 60 |
| 7 | -1 | 18 |
| 8 | 6 | 49 |
| 9 | -1 | 20 |
| 10 | -1 | 23 |

### +90:

90 mod 11 = 2.

Se agrega la clave 90 a la dirección 2, como estaba almacenando una clave intrusa ésta se mueve a la siguiente dirección libre, y se modifica el enlace de la dirección que estaba enlazada con la clave intrusa.

Operaciones: L2, L3, L4, L5, L6, L7, L8, L9, L10, E10, L1, E4, E2.

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 60 |
| 1 | 4 | 67 |
| 2 | -1 | 90 |
| 3 | -1 | 80 |
| 4 | 10 | 56 |
| 5 | 8 | 71 |
| 6 | -1 | 61 |
| 7 | -1 | 18 |
| 8 | 0 | 49 |
| 9 | -1 | 20 |
| 10 | -1 | 23 |

### +61:

61 mod 11 = 6.

Se agrega la clave 61 a la dirección 6, como estaba almacenando una clave intrusa ésta se mueve a la siguiente dirección libre, y se modifica el enlace de la dirección que estaba enlazada con la clave intrusa.

Operaciones: L6, L7, L8, L9, L10, L0, E0, E8, E6.

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 60 |
| 1 | 4 | 67 |
| 2 | -1 | 90 |
| 3 | -1 | 80 |
| 4 | 10 | 56 |
| 5 | 0 | 71 |
| 6 | -1 | 61 |
| 7 | -1 | 18 |
| 8 | -1 |  |
| 9 | -1 | 20 |
| 10 | -1 | 23 |

### -49:

49 mod 11 = 5.

Se trata de eliminar la clave 49 de la dirección 5, como no se encuentra en ésta se va a la dirección enlazada, y se elimina de allí. Se actualiza el enlace de la dirección 5.

Operaciones: L5, L8, E8, E5.

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 60 |
| 1 | 10 | 56 |
| 2 | -1 | 90 |
| 3 | -1 | 80 |
| 4 | -1 |  |
| 5 | 0 | 71 |
| 6 | -1 | 61 |
| 7 | -1 | 18 |
| 8 | -1 |  |
| 9 | -1 | 20 |
| 10 | -1 | 23 |

### -67:

67 mod 11 = 1.

Se elimina la clave 67 de la dirección 1, y se sustituye por la clave en la dirección que tenía enlazada (56 en la dirección 4). Se actualiza el enlace de la dirección 1 para que quede enlazada con la dirección que tenía la dirección 4.

Operaciones: L1, L4, E4, E1.

Densidad de empaquetamiento = 9 / 11 = 0.81 = 81%.

Ejercicio 12 de la Práctica 4: Dado el archivo dispersado a continuación, grafique los estados sucesivos para las siguientes operaciones: +45, +48, +23, +21, +59, -44, -45. Técnica de resolución de colisiones: Saturación progresiva encadenada con área de desborde por separado. f(x) = x MOD 11

Archivo inicial: 

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 44 |
| 1 | -1 | 56 |
| 2 | -1 |  |
| 3 | -1 |  |
| 4 | -1 | 37 |
| 5 | -1 |  |
| 6 | -1 |  |
| 7 | -1 | 29 |
| 8 | -1 |  |
| 9 | -1 | 31 |
| 10 | -1 |  |

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | -1 |  |
| 2 | -1 |  |
| 3 | -1 |  |

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 44 |
| 1 | 0 | 56 |
| 2 | -1 |  |
| 3 | -1 |  |
| 4 | -1 | 37 |
| 5 | -1 |  |
| 6 | -1 |  |
| 7 | -1 | 29 |
| 8 | -1 |  |
| 9 | -1 | 31 |
| 10 | -1 |  |

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 45 |
| 1 | -1 |  |
| 2 | -1 |  |
| 3 | -1 |  |

### +45:

45 mod 11 = 1.

Se trata de agregar la clave a la dirección 1, no se puede porque ya hay una clave, hay overflow, se agrega en la primer dirección libre del área de desborde. Se actualiza el enlace de la dirección 1 para que quede enlazada con la dirección donde se acaba de agregar el 45.

Operaciones: L1, L0[AD], E0[AD].

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 44 |
| 1 | 0 | 56 |
| 2 | -1 |  |
| 3 | -1 |  |
| 4 | 1 | 37 |
| 5 | -1 |  |
| 6 | -1 |  |
| 7 | -1 | 29 |
| 8 | -1 |  |
| 9 | -1 | 31 |
| 10 | -1 |  |

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 45 |
| 1 | -1 | 48 |
| 2 | -1 |  |
| 3 | -1 |  |

### +48:

48 mod 11 = 4.

Se trata de agregar la clave a la dirección 4, no se puede porque ya hay una clave, hay overflow, se agrega en la primer dirección libre del área de desborde. Se actualiza el enlace de la dirección 4 para que quede enlazada con la dirección donde se acaba de agregar el 48.

Operaciones: L4, L0[AD], L1[AD], E1[AD].

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 44 |
| 1 | 2 | 56 |
| 2 | -1 |  |
| 3 | -1 |  |
| 4 | 1 | 37 |
| 5 | -1 |  |
| 6 | -1 |  |
| 7 | -1 | 29 |
| 8 | -1 |  |
| 9 | -1 | 31 |
| 10 | -1 |  |

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 45 |
| 1 | -1 | 48 |
| 2 | 0 | 23 |
| 3 | -1 |  |

### +23:

23 mod 11 = 1.

Se trata de agregar el 23 a la dirección 1, no se puede porque ya hay una clave, se agrega en la siguiente dirección libre del área de desborde. Se actualiza el enlace de la dirección 1 para que quede enlazada con la dirección donde se acaba de agregar el 23, que a su vez tendrá el enlace previo que tenía la dirección 1.

Operaciones: L1, L0 [AD], L1 [AD], L2 [AD], E2 [AD], E1.

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 44 |
| 1 | 2 | 56 |
| 2 | -1 |  |
| 3 | -1 |  |
| 4 | 1 | 37 |
| 5 | -1 |  |
| 6 | -1 |  |
| 7 | -1 | 29 |
| 8 | -1 |  |
| 9 | -1 | 31 |
| 10 | -1 | 21 |

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 45 |
| 1 | -1 | 48 |
| 2 | 0 | 23 |
| 3 | -1 |  |

### +21:

21 mod 11 = 10.

Se agrega el 21 a la dirección 10.

Operaciones: L10, E10.

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 44 |
| 1 | 2 | 56 |
| 2 | -1 |  |
| 3 | -1 |  |
| 4 | 3 | 37 |
| 5 | -1 |  |
| 6 | -1 |  |
| 7 | -1 | 29 |
| 8 | -1 |  |
| 9 | -1 | 31 |
| 10 | -1 | 21 |

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 45 |
| 1 | -1 | 48 |
| 2 | 0 | 23 |
| 3 | 1 | 59 |

### +59:

59 mod 11 = 4.

Se trata de agregar el 59 a la dirección 4, no se puede porque ya hay una clave, hay overflow, se agrega en la siguiente dirección libre del área de desborde. El enlace de la dirección 4 pasa a ser la dirección donde se agregó el 59, y el enlace de la dirección donde se agregó el 59 es la clave anterior de la dirección 4.

Operaciones: L4, L0 [AD], L1 [AD], L2 [AD], L3 [AD], E3 [AD], E4.

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | 2 | 56 |
| 2 | -1 |  |
| 3 | -1 |  |
| 4 | 3 | 37 |
| 5 | -1 |  |
| 6 | -1 |  |
| 7 | -1 | 29 |
| 8 | -1 |  |
| 9 | -1 | 31 |
| 10 | -1 | 21 |

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 | 45 |
| 1 | -1 | 48 |
| 2 | 0 | 23 |
| 3 | 1 | 59 |

### -44:

44 mod 11 = 0.

Se elimina la clave 44 de la dirección 0.

Operaciones: L0, E0.

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | 2 | 56 |
| 2 | -1 |  |
| 3 | -1 |  |
| 4 | 3 | 37 |
| 5 | -1 |  |
| 6 | -1 |  |
| 7 | -1 | 29 |
| 8 | -1 |  |
| 9 | -1 | 31 |
| 10 | -1 | 21 |

| Dirección | Enlace | Clave |
| --- | --- | --- |
| 0 | -1 |  |
| 1 | -1 | 48 |
| 2 | -1 | 23 |
| 3 | 1 | 59 |

### -45:

45 mod 11 = 1.

Se trata de eliminar el 45 de la dirección 1, no se encuentra, se va a la dirección enlazada de ésta, no se encuentra, se va a la dirección enlazada de ésta, se encuentra y se elimina. El enlace de la dirección que tenía enlazada la dirección donde estaba el 45 se modifica.

Operaciones: L1, L2 [AD], L0 [AD], E0 [AD], E2 [AD].

Densidad de empaquetamiento = 8 / 15 = 0,53 = 53%.

Ejercicio 14 de la Práctica 4: Dado el archivo dispersado a continuación, grafique los estados sucesivos para las siguientes operaciones: +47, +26, +23, -34, -28. Técnica de resolución de colisiones: Dispersión Doble. f1(x) = x MOD 11; f2(x)= x MOD 5 + 1

Archivo inicial: 

| Dirección | Clave |
| --- | --- |
| 0 |  |
| 1 | 34 |
| 2 |  |
| 3 |  |
| 4 | 15 |
| 5 |  |
| 6 | 28 |
| 7 | 29 |
| 8 |  |
| 9 |  |
| 10 |  |

| Dirección | Clave |
| --- | --- |
| 0 |  |
| 1 | 34 |
| 2 |  |
| 3 | 47 |
| 4 | 15 |
| 5 |  |
| 6 | 28 |
| 7 | 29 |
| 8 |  |
| 9 |  |
| 10 |  |

### +47:

47 mod 11 = 3.

Se agrega la clave 47 a la dirección 3.

Operaciones: L3, E3.

| Dirección | Clave |
| --- | --- |
| 0 |  |
| 1 | 34 |
| 2 |  |
| 3 | 47 |
| 4 | 15 |
| 5 |  |
| 6 | 28 |
| 7 | 29 |
| 8 | 26 |
| 9 |  |
| 10 |  |

### +26:

26 mod 11 = 4.

Se trata de agregar el 26 a la dirección 4, no se puede porque ya hay una clave, hay overflow, se aplica la segunda función de hash.

26 mod 5 + 1 = 2.

Se suma a la dirección base el resultado de la segunda función de hash. 4 + 2 = 6.

Se trata de agregar el 26 a la dirección 4, no se puede porque ya hay una clave, hay overflow nuevamente, se aplica la segunda función de hash.

Se suma a la dirección base el resultado de la segunda función de hash. 6 + 2 = 8.

Se agrega el 26 a la dirección 8.

Operaciones: L4, L6, L8, E8.

| Dirección | Clave |
| --- | --- |
| 0 |  |
| 1 | 34 |
| 2 |  |
| 3 | 47 |
| 4 | 15 |
| 5 | 23 |
| 6 | 28 |
| 7 | 29 |
| 8 | 26 |
| 9 |  |
| 10 |  |

### +23:

23 mod 11 = 1.

Se trata de agregar el 23 a la dirección 1, no se puede porque ya hay una clave, hay overflow, se aplica la segunda función de hash.

23 mod 5 + 1 = 4.

Se suma a la dirección base el resultado de la segunda función de hash. 1 + 4 = 5.

Se agrega el 23 a la dirección 5.

Operaciones: L1, L5, E5.

| Dirección | Clave |
| --- | --- |
| 0 |  |
| 1 | ### |
| 2 |  |
| 3 | 47 |
| 4 | 15 |
| 5 | 23 |
| 6 | 28 |
| 7 | 29 |
| 8 | 26 |
| 9 |  |
| 10 |  |

### -34:

34 mod 11 = 1.

Se elimina el 34 de la dirección 1 y se deja una marca de borrado.

Operaciones: L1, E1.

| Dirección | Clave |
| --- | --- |
| 0 |  |
| 1 | ### |
| 2 |  |
| 3 | 47 |
| 4 | 15 |
| 5 | 23 |
| 6 | ### |
| 7 | 29 |
| 8 | 26 |
| 9 |  |
| 10 |  |

### -28:

28 mod 11 = 6.

Se elimina el 28 de la dirección 6 y se deja una marca de borrado.

Operaciones: L6, E6.

Densidad de empaquetamiento = 5 / 11 = 0,45 = 45%.

Ejercicio 16 de la Práctica 4: Para las siguientes claves, realice el proceso de dispersión mediante el método de hashing extensible, sabiendo que cada nodo tiene capacidad para dos registros. El número natural indica el orden de llegada de las claves.  Se debe mostrar el estado del archivo
para cada operación. Justifique brevemente ante colisión y desborde los pasos que realiza.

| 1 | Darín | 00111111 | 2 | Alterio | 11110100 |
| --- | --- | --- | --- | --- | --- |
| 3 | Sbaraglia | 10100101 | 4 | De la Serna | 01010111 |
| 5 | Altavista | 01101011 | 6 | Grandinetti | 10101010 |

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2060.png)

### Darín:

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2061.png)

### Alterio:

Hay colisión sin overflow. Se agrega a la dirección.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2062.png)

### Sbaraglia:

Hay colisión con overflow. Se incrementa en uno el valor asociado a la dirección saturada. Se genera una nueva dirección con el mismo valor asociado a la dirección saturada. 

La tabla no dispone de entradas suficientes para direccionar la nueva dirección. Se duplica la cantidad de celdas de la tabla y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2063.png)

### De la Serna:

Hay colisión con overflow. Se incrementa en uno el valor asociado a la dirección saturada. Se genera una nueva dirección con el mismo valor asociado a la dirección saturada.

La tabla no dispone de entradas suficientes para direccionar la nueva dirección. Se duplica la cantidad de celdas de la tabla y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2064.png)

### Altavista:

Hay colisión con overflow. Se incrementa en uno el valor asociado a la dirección saturada. Se genera una nueva dirección con el mismo valor asociado a la dirección saturada.

La tabla no dispone de entradas suficientes para direccionar la nueva dirección. Se duplica la cantidad de celdas de la tabla y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.

![Untitled](Resumen%20Parcial%20Pra%CC%81ctico%20d1e54f8a16f14f1eb31712a554101214/Untitled%2065.png)

### Grandinetti:

Hay colisión sin overflow. Se agrega a la dirección 010.