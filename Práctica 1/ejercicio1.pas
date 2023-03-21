program Ejercicio1Practica1;

var
	logico: file of integer;
	fisico:string;
	num:integer;

begin
	writeln('Ingrese nombre del archivo: ');
	readln(fisico);	
	assign(logico,fisico);
	rewrite(logico);
	writeln('Ingrese un numero: ');
	readln(num);
	while(num<>30000) do begin
		write(logico,num);
		writeln('Ingrese un numero: ');
		readln(num);
	end;
	close(logico);
end.