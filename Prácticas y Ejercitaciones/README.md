# FOD

# Ejercitaciones

Preguntas y respuestas que no son sólo códigos.

---

[Resumen Parcial Práctico](https://www.notion.so/Resumen-Parcial-Pr-ctico-d1e54f8a16f14f1eb31712a554101214?pvs=21)

## Práctica 4

- **1:** Definir la estructura de datos correspondiente a un árbol B de orden M, que
almacenará información correspondiente a alumnos de la facultad de informática de
la UNLP. De los mismos deberá guardarse nombre y apellido, DNI, legajo y año de
ingreso. ¿Cuál de estos datos debería seleccionarse como clave de identificación para
organizar los elementos en el árbol? ¿Hay más de una opción? Justifique su elección.
    
    ```pascal
    type
    	arbol = record
    		legajos: array [1..M] of string;
    		hijos: array [0..M] of integer;
    		cant: integer;
    	end;
    arbolB = file of arbol;
    ```
    
    Para organizar los elementos en el árbol, como clave de identificación se podrá elegir tanto el legajo como el DNI, ya que ambos son campos únicos de alumnos de la Facultad.
    
- **2:** Redefinir la estructura de datos del ejercicio anterior para un árbol B+ de orden M.
Responda detalladamente:
    
    ```pascal
    type
    	arbol = record
    		DNIS: array [1..M-1] of string;
    		hijos: array [1.. M] of integer;
    		sig: integer;
    		cant: integer;
    	end;
    arbolB+ = file of arbol;
    ```
    
    - **a.** ¿Cómo accede a la información para buscar al alumno con DNI 23.333.333?
        
        Para acceder a la información de un alumno con un DNI determinado, se debe llegar a una hoja, ya que ahí es donde los datos están almacenados en árboles B+.
        
    - **b.** ¿Cómo accede a la información para buscar al alumno José Perez?
        
        Para acceder a la información de un alumno en específico, hay que acceder al archivo de datos, ya que el árbol B+ sólo almacena índices. 
        
    - **c.** Indique cuáles son las ventajas que ofrece este tipo de árbol para el caso de la
    búsqueda planteada en el inciso b.
        
        Si se almacenan alumnos en vez de índices, la ventaja del árbol B+ es que se podría recorrer la estructura de forma secuencial, en vez de tener que ir por la raíz y nodos hijos como es en el caso de árboles B.
        
- **3:** Dado el siguiente algoritmo de búsqueda en un árbol B:
    
    ```pascal
    procedure buscar(NRR, clave, NRR_encontrado, pos_encontrada, resultado);
    var 
    	clave_encontrada: boolean;
    begin
    	if (nodo = null)
    		resultado := false; {clave no encontrada}
    	else
    		posicionarYLeerNodo(A, nodo, NRR);
    		claveEncontrada(A, nodo, clave, pos, clave_encontrada);
    		if (clave_encontrada) then begin
    			NRR_encontrado := NRR; { NRR actual }
    			pos_encontrada := pos; { posicion dentro del array }
    			resultado := true;
    		end
    	else
    		buscar(nodo.hijo[pos], clave, NRR_encontrado, pos_encontrada,resultado);
    end;
    ```
    
    Asuma que para la primera llamada, el parámetro NRR contiene la posición de la raíz
    del árbol. Responda detalladamente:
    
    - **a.** PosicionarYLeerNodo(): Indique qué hace y la forma en que deben ser enviados
    los parámetros (valor o referencia).
        
        PosicionarYLeerNodo() es un procedimiento que se posiciona en un nodo hijo de la raíz para poder seguir buscando la clave buscada. La variable nodo corresponde al array de claves correspondiente al nodo hijo, A es el árbol y NRR el índice. NRR debe ser pasado por valor, mientras que nodo y A por referencia.
        
    - **b.** claveEncontrada(): Indique qué hace y la forma en que deben ser enviados los
    parámetros (valor o referencia). ¿Cómo lo implementaría?
        
        El método claveEncontrada() es un procedimiento que almacena en la variable clave_encontrada true o false, dependiendo si la variable clave se encontró en el árbol, y si se encontró almacena la posición en la variable pos.
        
        La variable clave_encontrada debe ser pasada por referencia ya que se debe cambiar su valor, al igual que pos, clave por valor porque sólo se necesita su valor y no modificarlo, y nodo y A se deben pasar por referencia.
        
    - **c.** ¿Existe algún error en este código? En caso afirmativo, modifique lo que considere
    necesario.
        
        Sí, todo el código es altamente incorrecto.
        
        El código correcto sería: 
        
        ```pascal
        function buscar(NRR,clave:integer;var A:arbol;var pos_encontrada:integer; var NRR_encontrado:integer):boolean;
        var
        	nodo: array[1..M] of integer;
        	pos:integer;
        begin
        	if (nodo=nil) then buscar:=false;
        	else begin
        			posicionarYLeerNodo(NRR,A,nodo);
        			if (claveEncontrada(A,nodo,clave,pos)) then begin
        				pos_encontrada:=pos;
        				NRR_encontrado:=NRR
        			end
        			else buscar(nodo.hijo[pos],clave,A,pos_encontrada,NRR_encontrado);
        	end;
        end;
        ```
        
    
- **4:** Defina los siguientes conceptos. En los dos últimos casos, ¿cuándo se aplica cada uno?
    - Overflow: El overflow se produce cuando se quiere agregar una clave a un nodo el cual ya tiene la cantidad máxima de claves permitidas.
    - Underflow: El underflow se produce cuando se quiere eliminar una clave de un nodo el cual ya tiene la cantidad mínima de claves permitidas.
    - Redistribución: La redistribución sucede cuando un nodo tiene underflow, se puede trasladar una llave de un hermano adyacenente a este nodo, para que el underflow deje de ocurrir.
    - Fusión o concatenación: Si un nodo adyacente hermnao está al mínimo y no se puede redistribuir, se concatena con un nodo adyacente disminuyendo la cantidad de nodos, y en algunos casos la altura del árbol.
    
- **5:** Dado el siguiente árbol B de orden 5, mostrar como quedaría el mismo luego de
realizar las siguientes operaciones: +320, -390, -400, -533. Justificar detalladamente
cada operación indicando lecturas y escrituras en orden de ocurrencia. Para la
resolución de underflow debe utilizar política a izquierda. Graficar cada operación por
separado.
    
    ![Screenshot 2023-05-10 165839.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-10_165839.png)
    
    ### +320:
    
    Se agrega el 320 en Nodo 1, hay overflow: La primera mitad de las claves (225, 241) se quedan en el nodo con Overflow y se crea un nuevo nodo con la segunda mitad de las claves (320, 331, 360), la menor de éstas (320) se promocionan al nodo padre.
    
    Se agrega el 320 en Nodo 2 (raíz), hay overflow: La primera mitad de las claves (220, 320) se quedan en el nodo con Overflow y se crea un nuevo nodo con la segunda mitad de las claves (390, 455, 541), la menor de éstas (390) se promociona a un nuevo nodo padre que es la nueva raíz.
    
    Operaciones: Lectura en Nodo 1, Escritura en Nodo 1, Lectura en Nodo 2, Escritura en Nodo 2, Escritura en Nodo 6, Escritura en Nodo 7, Escritura en Nodo 8.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled.png)
    
    ### -390:
    
    Se elimina la clave 390: se reemplaza la clave por la menor clave del subárbol derecho (400).
    
    Operaciones: Lectura Nodo 8, Lectura Nodo 7, Lectura Nodo 4, Escritura Nodo 8, Escritura Nodo 4.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%201.png)
    
    ### -400:
    
    Se elimina la clave 400: se reemplaza la clave por la menor clave del subárbol derecho (407), hay underflow en el nodo 4: como es un nodo hoja en el extremo del árbol, se redistribuye con el nodo 5, y luego se ordenan las claves.
    
    Operaciones: L8, L7, L4, L5, E4, E5, E7, E8.
    
    ![Screenshot 2023-05-10 191602.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-10_191602.png)
    
    ### -533:
    
    Se elimina la clave 533: se produce underflow en Nodo 5 porque contiene la cantidad mínima de nodos posibles (1), hay que redistribuir siguiendo la política de izquierda. Se quiere redistribuir, pero el Nodo 4 ya contiene la cantidad mínima de claves, por lo que se tiene que fusionar, y el Nodo 5 se libera.
    
    Operaciones: L8, L7, L5, L4, E5, E4, E7
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%202.png)
    
- **6:** Dado el siguiente árbol B de orden 4, mostrar cómo quedaría el mismo luego de realizar
las siguientes operaciones: +5, +9, +80, +51, -50, -92. Política de resolución de underflows: derecha.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%203.png)
    
    ### +5:
    
    Se agrega el 5 en el Nodo 0: hay overflow. El 5 y el 22 se quedan en el Nodo 0, se crea un nuevo nodo con el 50, el 32 se promociona al nodo padre.
    
    Operaciones: L2,L0,E0,E3,E2
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%204.png)
    
    ### +9:
    
    Se agrega la clave 9 al Nodo 0.
    
    Operaciones: L2,L0,E0
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%205.png)
    
    ### +80:
    
    Se agrega el 80 al Nodo 1, hay overflow: 77 y 79 quedan en el Nodo 1, se agrega un nuevo nodo derecho con el 92, 80 es promocionado al nodo padre.
    
    Operaciones: L2, L1, E1,E4,E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%206.png)
    
    ### +51:
    
    Se agrega el 51 al Nodo 3.
    
    Operaciones: L2,L3,E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%207.png)
    
    ### -50:
    
    Se elimina el 50 del Nodo 3.
    
    Operaciones: L2,L3,E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%208.png)
    
    ### -92:
    
    Se elimina el 92: se genera underflow porque el Nodo 4 contiene la cantidad mínima de claves posible, se redistribuye utilizando la política de derecha, el 79 pasa al Nodo 4, y se balancea la carga.
    
    Operaciones: L2,L4,L1,E1,E4,E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%209.png)
    
- **7:** Dado el siguiente árbol B de orden 6, mostrar como quedaría el mismo luego de realizar
las siguientes operaciones: +15, +71, +3, +48, -56, -71. Política de resolución de underflows: derecha o izquierda.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2010.png)
    
    ### +15:
    
    Se agrega la clave 15 en el nodo 0, hay overflow: 15, 34 y 56 se quedan en el nodo 0, 78 se promociona al nodo padre (nueva raíz) y 100 y 176 se trasladan a un nuevo nodo.
    
    Operaciones: L0, E0, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2011.png)
    
    ### +71:
    
    Se agrega la clave 71 en el Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2012.png)
    
    ### +3:
    
    Se agrega la clave 3 en el Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2013.png)
    
    ### +48:
    
    Se agrega la clave 48 en el Nodo 0, se produce overflow: 3, 15 y 34 se quedan en el Nodo 0, 48 se promociona al nodo padre, 56 y 71 se trasladan a un nuevo nodo.
    
    Operaciones: L2, L0, E0, E3, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2014.png)
    
    ### -56:
    
    Se elimina la clave 56 del Nodo 3, se produce underflow porque la cantidad mínima de claves por nodo es de 6 (grado) /2 - 1 =2. Se trata de redistribuir con el hermano adyacente derecho, el Nodo 1, pero no se puede porque ese también tiene la cantidad mínima de claves, por lo que se trata de redistribuir con el nodo adyacente izquierdo, en el cual se puede, y el 34 se traslada el Nodo 3, y se balancea la carga.
    
    Operaciones: L2, L3, L1, L0, E0, E3, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2015.png)
    
    ### -71:
    
    Se elimina la clave 71 del Nodo 3, se produce underflow porque ya tiene la cantidad mínima de claves, se trata de redistruibuir con el hermano derecho, no se puede por la misma razón, se trata con el hermano izquierdo, tampoco se puede, por lo que se fusiona con el hermano derecho.
    
    Operaciones: L2, L3, L1, L0, E3, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2016.png)
    
- **8:** Dado el siguiente árbol B de orden 5, mostrar como quedaría el mismo luego de realizar
las siguientes operaciones: +450, -485, -511, -614. Política de resolución de underflows: derecha.
    
    Mínimo de claves por nodo: 5/2 - 1 = 1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2017.png)
    
    ### +450:
    
    Se agrega la clave 450 al nodo 1, hay overflow: 333 y 390 se quedan en el Nodo 1, 450 y 454 se trasladan a un nuevo nodo, 442 se promociona al nodo padre.
    
    Se agrega la clave 442 en el nodo 2, hay overflow: 315 y 442 se quedan en el Nodo 2, 547 y 639 se trasladan a un nuevo nodo, 485 se promociona a un nuevo nodo padre que será la nueva raíz. Se aumenta la altura del árbol.
    
    Operaciones: L2, L1, E1, E6, E2, E7, E8.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2018.png)
    
    ### -485:
    
    Se elimina la clave 485 del Nodo 8: se reemplaza por la clave menor del subárbol derecho.
    
    Operaciones: L8, L7, L4, E4, E8.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2019.png)
    
    ### -511:
    
    Se elimina la clave 511 del Nodo 4, hay underflow: como es un nodo hoja en un extremo, se redistribuye con su hermano adyacente, y luego se balancea la carga.
    
    Operaciones: L8, L7, L4, L5, E4, E5, E7.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2020.png)
    
    ### -614:
    
    Se elimina la clave 614 del Nodo 7, se reemplaza con el menor de las claves de su subárbol derecho que es el 633, y el Nodo 5 queda en underflow, por lo que se tiene que redistribuir con su hermano derecho, y luego se balancea la carga.
    
    Operaciones: L8, L7, L5, L3, E5, E3, E7.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2021.png)
    
- **9:** Dado un árbol B de orden 5  y con política izquierda, para cada operación dada dibuje el árbol resultante, explique las decisiones tomadas, escriba las lecturas y escrituras.
Operaciones: -76, -400, +900, +12.
    
    Mínimo de claves por nodo: 5 / 2 - 1 = 1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2022.png)
    
    ### -76:
    
    Se elimina la clave 76 del Nodo 2, se reemplaza por la clave menor del subárbol derecho.
    
    Operaciones: L2, L4, E4, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2023.png)
    
    ### -400:
    
    Se elimina la clave 400 del Nodo 1, se produce underflow: se trata de redistribuir con el hermano izquierdo, pero no se puede ya que este tambien tiene la cantidad mínima de nodos, por lo que se fusiona con este, y se balancea la carga.
    
    Operaciones: L2, L1, L4, E1, E4, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2024.png)
    
    ### +900:
    
    Se agrega la clave al Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2025.png)
    
    ### +12:
    
    Se agrega la clave 12 al Nodo 0, se produce overflow: 12 y 21 se quedan en el Nodo 0, 46 y 70 se trasladan a un nuevo nodo, 45 se promociona al nodo padre.
    
    Operaciones: L2, L0, E0, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2026.png)
    
- **10:** Dada las siguientes operaciones, mostrar la construcción paso a paso de un árbol B de
orden 4: +50 , +70, +40, +15, +90, +120, +115, +45, +30, +100, +112, +77, -45, -40, -50, -90, -100. Política de resolución de underflows: izquierda o derecha.
    
    Mínimo de claves por nodo: 4/2 - 1 = 1.
    
    ### +50:
    
    Se agrega la clave 50 al Nodo 0.
    
    Operaciones: E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2027.png)
    
    ### +70:
    
    Se agrega la clave 70 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2028.png)
    
    ### +40:
    
    Se agrega la clave 40 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2029.png)
    
    ### +15:
    
    Se agrega la clave 15 al Nodo 0, hay overflow: 15 y 40 se quedan en el Nodo 0, se traslada el 70 a un nuevo Nodo, y el 50 se promociona a un nuevo nodo padre (raíz). Se incrementa la altura del árbol.
    
    Operaciones: L0, E0, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2030.png)
    
    ### +90:
    
    Se agrega la clave 90 al Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2031.png)
    
    ### +120:
    
    Se agrega la clave 120 al Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2032.png)
    
    ### +115:
    
    Se agrega la clave 115 al Nodo 1, hay overflow: 70 y 90 se quedan en el Nodo 1, 120 se traslada a un nuevo nodo y 115 se promociona al nodo padre.
    
    Operaciones: L2, L1, E1, E3, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2033.png)
    
    ### +45:
    
    Se agrega la clave 45 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2034.png)
    
    ### +30:
    
    Se agrega la clave 30 al Nodo 0, hay overflow, el 15 y el 30 se quedan en el Nodo 0, el 45 se traslada a un nuevo nodo y el 40 se promociona al nodo padre (Nodo 2).
    
    Operaciones: L2, L0, E0, E4, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2035.png)
    
    ### +100:
    
    Se agrega la clave 100 al Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2036.png)
    
    ### +112:
    
    Se agrega la clave al Nodo 1, hay overflow, 70 y 90 se quedan en el Nodo 1, 100 se promociona al nodo padre y 112 se traslada a un nuevo nodo.
    
    Se agrega el 100 al Nodo 2, hay overflow, 40 y 50 se quedan en el Nodo 2, 155 se traslada a un nuevo nodo y 100 se promociona a un nuevo nodo padre. Se aumenta la altura del árbol.
    
    Operaciones: L2, L1, E1, E5, E2, E6, E7.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2037.png)
    
    ### +77:
    
    Se agrega la clave al Nodo 1.
    
    Operaciones: L7, L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2038.png)
    
    ### -45:
    
    Se elimina la clave del Nodo 4, hay underflow, se redistribuye con el hermano izquierdo y se balancea la carga.
    
    Operaciones: L7, L2, L4, L0, E4, E0.
    
    ![Screenshot 2023-05-11 224228.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-11_224228.png)
    
    ### -40:
    
    Se elimina el 40 del Nodo 4, hay underflow, se trata de redistribuir con el hermano izquierdo, no se puede ya que tiene la cantidad mínima de nodos, se redistribuye con el hermano derecho.
    
    Operaciones: L7, L2, L4, L0, L1, E4, E1, E2.
    
    ![Screenshot 2023-05-16 183936.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-16_183936.png)
    
    ### -50:
    
    Se elimina el 50 del Nodo 4.
    
    Operaciones: L7, L2, L4, E4.
    
    ![Screenshot 2023-05-16 184023.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-16_184023.png)
    
    ### -90:
    
    Se elimina el 90 del Nodo 1, hay underflow, se trata de redistribuir con el hermano adyacente ya que es un nodo extremo, no se puede ya que tiene la cantidad mínima de nodos, así que se fusiona con éste. La clave padre baja. Se libera el Nodo 1.
    
    Operaciones: L7, L2, L1, L4, E4, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2039.png)
    
    ### -100:
    
    Se elimina el 100 del Nodo 7, se reemplaza por la clave de menor valor del subárbol derecho.
    
    El Nodo 5 queda en underflow, no se puede redistribuir con el Nodo 3, se fusiona. La clave padre baja. Se libera el Nodo 3.
    
    El Nodo 6 queda en underflow, no se puede redistribuir con el Nodo 2, se fusiona. La clave padre baja. Se libera el Nodo 6. Se decrementa la altura del árbol.
    
    Operaciones: L7, L6, L5, L3, E5, L2, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2040.png)
    
- **11:** Dadas las siguientes operaciones, mostrar la construcción paso a paso de un árbol B de
orden 5. Política de resolución de underflows: izquierda. +80, +50, +70, +120, +23, +52, +59, +65, +30, +40, +45, +31, +34, +38, +60, +63, +64, -23, -30, -31, -40, -45, -38.
    
    Mínimo de claves por nodo: 5 / 2 - 1 = 1.
    
    ### +80:
    
    Se crea el Nodo 0 y se agrega la clave 80.
    
    Operaciones: E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2041.png)
    
    ### +50:
    
    Se agrega la clave 50 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2042.png)
    
    ### +70:
    
    Se agrega la clave 50 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2043.png)
    
    ### +120:
    
    Se agrega la clave 120 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2044.png)
    
    ### +23:
    
    Se agrega la clave 23 al Nodo 0, hay overflow: 23 y 50 se quedan en el Nodo 0, 80 y 120 se trasladan a un nuevo Nodo, 70 se promociona al nodo padre (nuevo nodo raíz).
    
    Operaciones: L0, E0, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2045.png)
    
    ### +52:
    
    Se agrega el 52 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2046.png)
    
    ### +59:
    
    Se agrega el 59 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2047.png)
    
    ### +65:
    
    Se agrega el 65 al Nodo 0, hay overflow: 23 y 50 se quedan en el Nodo 0, 59 y 65 se trasladan a un nuevo nodo, 52 se promociona al nodo padre.
    
    Operaciones: L2, L0, E0, E3, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2048.png)
    
    ### +30:
    
    Se agrega el 30 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2049.png)
    
    ### +40:
    
    Se agrega el 40 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2050.png)
    
    ### +45:
    
    Se agrega el 45 al Nodo 0, hay overflow: 23 y 30 se quedan en el Nodo 0, 45 y 50 se trasladan a un nuevo nodo, 40 se promociona al nodo padre.
    
    Operaciones: L2, L0, E0, E4, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2051.png)
    
    ### +31:
    
    Se agrega el 31 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2052.png)
    
    ### +34:
    
    Se agrega el 34 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2053.png)
    
    ### +38:
    
    Se agrega el 38 al Nodo 0, hay overflow: 23 y 30 se quedan en el Nodo 0, 34 y 38 se trasladan a un nuevo nodo, 31 se promociona al nodo padre.
    
    Operaciones: L2, L0, E0, E5, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2054.png)
    
    ### +60:
    
    Se agrega la clave 60 al Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2055.png)
    
    ### +63:
    
    Se agrega la clave 63 al Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2056.png)
    
    ### +64:
    
    Se agrega la clave 64 al Nodo 3, hay overflow: 59 y 60 se quedan en el Nodo 3, 64 y 65 se trasladan a un nuevo nodo, 63 se promociona al nodo padre.
    
    Se agrega la clave 63 al Nodo 2, hay overflow: 31 y 40 se quedan en el Nodo 2, 63 y 70 se trasladan a un nuevo nodo, 52 se promociona al nodo padre (nuevo nodo raíz). Se incrementa la altura del árbol.
    
    Operaciones: L2, L3, E3, E6, E2, E7, E8.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2057.png)
    
    ### -23:
    
    Se elimina el 23 del Nodo 0.
    
    Operaciones: L8, L2, L0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2058.png)
    
    ### -30:
    
    Se elimina el 30 del Nodo 0, hay underflow, se redistribuye con el hermano adyacente ya que el Nodo 0 está en un extremo, y se balancea la carga.
    
    Operaciones: L8, L2, L0, L5, E0, E5, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2059.png)
    
    ### -31:
    
    Se elimina el 31 del Nodo 0, hay underflow, se trata de redistribuir con su hermano adyacente pero no se puede ya que contiene la cantidad mínima de nodos, por lo que se fusiona con éste. Queda liberado el Nodo 5.
    
    Operaciones: L8, L2, L0, L5, E0, E2.
    
    ![Screenshot 2023-05-12 163736.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-12_163736.png)
    
    ### -40:
    
    Se elimina el 40 del Nodo 2 y se reemplaza por la menor clave de su subárbol derecho.
    
    Operaciones: L8, L2, L4, E4, E2.
    
    ![Screenshot 2023-05-12 163905.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-12_163905.png)
    
    ### -45:
    
    Se elimina el 45 del Nodo 2, se reemplaza por la menor clave de su subárbol derecho, se produce underflow en el Nodo 4, que se redistribuye con su hermano adyacente, y luego se tiene que rebalancear la carga.
    
    Operaciones: L8, L2, L4, L0, E0, E4, E2.
    
    ![Screenshot 2023-05-12 163941.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-12_163941.png)
    
    ### -38:
    
    Se elimina el 38 del Nodo 2, se trata de reemplazar por la menor clave de su subárbol derecho, se produce underflow en el Nodo 4, se trata de redistribuir con su hermano adyacente, no se puede porque contiene la cantidad mínima de claves, se fusionan.
    
    Se produce underflow en el Nodo 2, redistribuye con su hermano adyacente, y se balancea la carga. Se libera el Nodo 4.
    
    Operaciones: L8, L2, L4, L0, E0, L7, E2, E7, E8.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2060.png)
    
- **12:** Dado el siguiente árbol B de orden 6, mostrar como quedaría el mismo luego de realizar
las siguientes operaciones: +300, +577, -586, -570, -380, -460. Política de resolución de underflows: izquierda o derecha.
    
    Mínimo de claves por nodo: 6 / 2 - 1 = 2.
    
    ![Screenshot 2023-05-14 161200.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-14_161200.png)
    
    ### +300:
    
    Se agrega la clave 300 en el Nodo 1, hay overflow: 255, 256 y 300 se quedan en el Nodo 1, 380 y 423 se trasladan a un nuevo nodo, 358 es promocionado al nodo padre.
    
    Se agrega la clave 358 al Nodo 2, hay overflow: 216, 358 y 460 se quedan en el Nodo 2, 689 y 777 se trasladan a un nuevo nodo, 570 es promocionado al nodo padre (nuevo nodo raíz).
    
    Operaciones: L2, L1, E1, E7, E2, E8, E9.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2061.png)
    
    ### +577:
    
    Se agrega la clave 577 al Nodo 5, hay overflow: 577, 586 y 599 se quedan en el Nodo 5, 623 y 680 se trasladan a un nuevo nodo, 615 se promociona al nodo padre.
    
    Operaciones: L9, L8, L5, E5, E10, E8.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2062.png)
    
    ### -586:
    
    Se elimina 586 del Nodo 5.
    
    Operaciones: L9, L8, L5, E5.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2063.png)
    
    ### -570:
    
    Se elimina el 570 del Nodo 9, se reemplaza por la clave menor del subárbol derecho, el 577.
    
    Se produce underflow en el Nodo 5, se intenta redistribuir con el hermano adyacente (Nodo 10), pero no se puede ya que contiene la cantidad mínima de nodos, por lo que se fusionan. Se tiene que rebalancear la carga en el Nodo 8 con el Nodo 10. 
    
    Operaciones: L9, L8, L5, L10, E10, E8, E9.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2064.png)
    
    ### -380:
    
    Se elimina el 380 del Nodo 7, se produce underflow: se redistribuye con el hermano izquierdo, el Nodo 1, y se balancea la carga entre los Nodos 2 y 7.
    
    Operaciones: L9, L2, L7, L1, E7, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2065.png)
    
    ### -460:
    
    Se elimina el 460 del Nodo 2, se reemplaza por la clave menor del subárbol derecho, la clave 505 del Nodo 4.
    
    El Nodo 4 queda en underflow, se trata de redistribuir con el hermano adyacente, el Nodo 7, pero no se puede porque tiene la cantidad mínima de claves, entonces se fusionan, y se tiene que balancear la carga entre los Nodos 2 y 7.
    
    Operaciones: L9, L2, L4, L7, E7, E2.
    
    ![Screenshot 2023-05-17 124344.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-17_124344.png)
    
- **13:** Dada las siguientes operaciones, mostrar cómo se construye el árbol B de orden 4: +65,
+89, +23, +45, +20, +96, +10, +55, -23, +110, +50, -10, +25, -50, -45, +120, +130, +70, +75, +73, +100, -120, -110. Política de resolución de underflows: derecha.
    
    Mínimo de claves por nodo: 4 / 2 - 1 = 1.
    
    ### +65:
    
    Se agrega la clave 65 al Nodo 0.
    
    Operaciones: E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2066.png)
    
    ### +89:
    
    Se agrega la clave 89 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2067.png)
    
    ### +23:
    
    Se agrega la clave 23 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2068.png)
    
    ### +45:
    
    Se agrega la clave 45 al Nodo 0, hay overflow: 23 y 45 se quedan en el Nodo 0, 89 se traslada a un nuevo nodo y 65 se promociona al nodo padre (nuevo nodo raíz). Se incrementa la altura del árbol.
    
    Operaciones: L0, E0, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2069.png)
    
    ### +20:
    
    Se agrega la clave 20 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2070.png)
    
    ### +96:
    
    Se agrega la clave 96 al Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2071.png)
    
    ### +10:
    
    Se agrega el 10 al Nodo 0, hay overflow: 10 y 20 se quedan en el Nodo 0, 45 se traslada a un nuevo nodo y 23 se promociona al nodo padre.
    
    Operaciones: L2, L0, E0, E3, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2072.png)
    
    ### +55:
    
    Se agrega el 55 al Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2073.png)
    
    ### -23:
    
    Se elimina el 23 del Nodo 2 y se reemplaza por la clave menor del subárbol derecho.
    
    Operaciones: L2, L3, E3, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2074.png)
    
    ### +110:
    
    Se agrega el 110 al Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2075.png)
    
    ### +50:
    
    Se agrega el 50 al Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2076.png)
    
    ### -10:
    
    Se elimina el 10 del Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2077.png)
    
    ### +25:
    
    Se agrega el 25 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2078.png)
    
    ### -50:
    
    Se elimina el 50 del Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2079.png)
    
    ### -45:
    
    Se elimina el 45 del Nodo 2, se reemplaza por la clave menor del subárbol derecho.
    
    Se produce underflow en el Nodo 3, se redistribuye con el hermano derecho, el Nodo 1.
    
    Operaciones: L2, L3, L1, E3, E1, E2.
    
    ![Screenshot 2023-05-17 135721.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-17_135721.png)
    
    ### +120:
    
    Se agrega el 120 al Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Screenshot 2023-05-17 135804.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-17_135804.png)
    
    ### +130:
    
    Se agrega el 130 al Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2080.png)
    
    ### +70:
    
    Se agrega el 70 al Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2081.png)
    
    ### +75:
    
    Se agrega el 75 al Nodo 3, hay overflow: 65 y 70 se quedan en el Nodo 3, 89 se traslada a un nuevo nodo y 75 se promociona al nodo padre.
    
    Operaciones: L2, L3, E3, E4, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2082.png)
    
    ### +73:
    
    Se agrega el 73 al Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2083.png)
    
    ### +100:
    
    Se agrega el 100 al Nodo 1, hay overflow: 100 y 110 se quedan en el Nodo 1, 120 se promociona al nodo padre, 130 se traslada a un nuevo nodo.
    
    Se agrega el 120 al Nodo 2, hay overflow: 55 y 75 se quedan en el Nodo 2, 120 se traslada a un nuevo nodo, 96 se promociona al nodo padre (nuevo nodo raíz). Se incrementa la altura del árbol.
    
    Operaciones: L2, L1, E1, E5, E2, E6, E7.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2084.png)
    
    ### -120:
    
    Se elimina el 120 del Nodo 6, se reemplaza por la clave menor del subárbol derecho, el 130 del Nodo 5.
    
    Hay underflow en el Nodo 4, se redistribuye con el hermano adyacente. 100 se queda en el Nodo 1, 110 se promociona al nodo padre, 130 se queda en el nodo de la derecha.
    
    Operaciones: L7, L6, L5, L1, E1, E5, E6.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2085.png)
    
    ### -110:
    
    Se elimina el 110 del Nodo 6, se trata de reemplazar por la clave menor del subárbol derecho, el 130, pero al hacerlo el Nodo 5 queda en underflow. Se trata de redistribuir con el Nodo 1, no se puede porque contiene la cantidad mínima de claves, se fusionan. Se libera el Nodo 5.
    
    El Nodo 6 queda en underflow, se redistribuye con su hermano adyacente. 55 se queda en el nodo izquierdo, 75 se promociona al nodo padre y 96 se traslada al nodo derecho. El Nodo 4 cambia de padre.
    
    Operaciones: L7, L6, L5, L1, E1, L2, E2, E6, E7.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2086.png)
    
- **14:** Dado el siguiente árbol B + de orden 4 y con política de resolución de underflows a
derecha, realice las siguientes operaciones indicando lecturas y escrituras en el orden
de ocurrencia. Además, debe describir detalladamente lo que sucede en cada
operación. +80, -400.
    
    Mínimo de claves por nodo: 4 / 2  - 1= 1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2087.png)
    
    ### +80:
    
    Se agrega la clave 80 al Nodo 0, hay overflow: 11 y 50 se quedan en el Nodo 0, 77 se promociona al nodo padre y se traslada a un nuevo nodo junto con 80.
    
    Se agrega la clave 77 al Nodo 0, hay overflow: 77 y 340 se quedan en el Nodo 4, 400 se promociona al nodo padre (nuevo nodo raíz) y se traslada junto con 500 a traslada a un nuevo nodo.
    
    Operaciones: L4, L0, E0, E5, E4, E6, E7.
    
    ![Screenshot 2023-05-14 213039.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-14_213039.png)
    
    ### -400:
    
    La clave 400 no se encuentra en el árbol: no está en una de sus hojas.
    
- **15:** Dado el siguiente árbol B+ de orden 4, mostrar como quedaría el mismo luego de
realizar las siguientes operaciones: +120, +110, +52, +70, +15, -45, -52, +22, +19, -66, -22, -19, -23, -89. Política de resolución de underflows: derecha.
    
    Mínimo de claves por nodo: 4 / 2 - 1 = 1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2088.png)
    
    ### +120:
    
    Se agrega el 120 al Nodo 1, hay overflow: 66 y 67 se quedan en el Nodo 1, 89 se promociona al nodo padre, 120 se traslada a un nuevo nodo.
    
    Operaciones: L2, L1, E1, E3, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2089.png)
    
    ### +110:
    
    Se agrega el 110 al Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Screenshot 2023-05-14 223131.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-14_223131.png)
    
    ### +52:
    
    Se agrega el 52 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2090.png)
    
    ### +70:
    
    Se agrega el 70 al Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2091.png)
    
    ### +15:
    
    Se agrega el 15 al Nodo 0, hay overflow: 15 y 23 se quedan en el Nodo 0, se crea una copia del 45 que se promociona al nodo padre y el 45 se traslada al nuevo nodo junto con 52.
    
    Operaciones: L2, L0, E0, E4, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2092.png)
    
    ### -45:
    
    Se elimina 45 del Nodo 4.
    
    Operaciones: L2, L4, E4.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2093.png)
    
    ### -52:
    
    Se elimina el 52 del Nodo 4, hay underflow: se redistribuye con el hermano derecho, el Nodo 1, y se balancea la carga.
    
    Operaciones: L2, L4, L1, E4, E1.
    
    ![Screenshot 2023-05-14 230716.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-14_230716.png)
    
    ### +22:
    
    Se agrega el 22 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Screenshot 2023-05-14 230815.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-14_230815.png)
    
    ### +19:
    
    Se agrega el 19 al Nodo 0, hay overflow: 15 y 19 se quedan en el Nodo 0, 22 se promociona al nodo padre y se traslada al nuevo nodo junto con 23.
    
    Se agrega 22 al Nodo 2, hay overflow: 22 y 25 se quedan en el Nodo 2, 67 se promociona al nodo padre, el 89 se traslada al nuevo nodo.
    
    Operaciones: L2, L0, E0, E5, E2, E6, E7.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2094.png)
    
    ### -66:
    
    Se elimina 66 del Nodo 4, hay underflow: se redistribuye con su hermano adyacente y se balancea la carga.
    
    Operaciones: L7, L2, L4, L5, E4, E5, E2.
    
    ![Screenshot 2023-05-14 231421.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-14_231421.png)
    
    ### -22:
    
    Se elimina el 22 del Nodo 5, se trata de redistribuir con su hermano derecho pero no se puede porque tiene la cantidad mínima de claves por lo que se fusionan. Queda liberado el Nodo 4.
    
    Operaciones: L7, L2, L4, L5, E5, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2095.png)
    
    ### -19:
    
    Se elimina el 19 del Nodo 0.
    
    Operaciones: L7, L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2096.png)
    
    ### -23:
    
    Se elimina el 23 del Nodo 3 (y del Nodo 2), se trata de redistribuir con su hermano adyacente, no se puede porque tiene la cantidad mínima de claves, se fusionan los Nodos 0 y 5. Se libera el Nodo 0.
    
    El Nodo 2 queda en underflow, se trata de redistribuir con el Nodo 6, no se puede porque tiene la cantidad mínima, se fusionan en el Nodo 2. Se liberan los Nodos 6 y 7.
    
    Operaciones: L7, L2, L5, L0, E0, L6, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2097.png)
    
    ### -89:
    
    Se elimina el 89 del Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2098.png)
    
- **16:** Dada las siguientes operaciones, mostrar la construcción paso a paso de un árbol B+
de orden 4: +67, +56, +96, +10, +28, +95, +16, +46, +23, +36, +120, +130, +60, +57, -96, -67, -95, -60, -120, -57, -56. Política de resolución de underflows: derecha o izquierda.
    
    Mínimo de claves por nodo: 4 / 2 - 1 = 1.
    
    ### +67:
    
    Se agrega la clave 67 al Nodo 0.
    
    Operaciones: E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%2099.png)
    
    ### +56:
    
    Se agrega la clave 56 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20100.png)
    
    ### +96:
    
    Se agrega la clave 96 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20101.png)
    
    ### +10:
    
    Se agrega el 10 al Nodo 0, hay overflow: 10 y 56 se quedan en el Nodo 0, 67 se promociona al nodo padre (nuevo nodo raíz) y se traslada a un nuevo nodo junto con el 96.
    
    Operaciones: L0, E0, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20102.png)
    
    ### +28:
    
    Se agrega el 28 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20103.png)
    
    ### +95:
    
    Se agrega el 95 al Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20104.png)
    
    ### +16:
    
    Se agrega el 16 al Nodo 0, hay overflow: 10 y 16 se quedan en el Nodo 0, 28 se promociona al nodo padre y se traslada a un nuevo nodo junto con el 56.
    
    Operaciones: L2, L0, E0, E3, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20105.png)
    
    ### +46:
    
    Se agrega el 46 al Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20106.png)
    
    ### +23:
    
    Se agrega el 23 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20107.png)
    
    ### +36:
    
    Se agrega el 36 al Nodo 3, hay overflow: 28 y 36 se quedan en el Nodo 3, 46 se promociona al nodo padre (Nodo 2) y se traslada a un nuevo nodo junto con el 56.
    
    Operaciones: L2, L3, E3, E4, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20108.png)
    
    ### +120:
    
    Se agrega el 120 al Nodo 1, hay overflow: 67 y 95 se quedan en el Nodo 1, 96 se promociona al nodo padre y se traslada a un nuevo nodo junto con el 120.
    
    Se agrega 120 al Nodo 2, hay overflow: 28 y 46 se quedan en el Nodo 2, 67 se promociona al nodo padre y 96 se traslada a un nuevo nodo.
    
    Operaciones: L2, L1, E1, E5, E2, E6, E7.
    
    ![Screenshot 2023-05-16 105323.png](FOD%2063b469800e42486fa5bd69706b45e900/Screenshot_2023-05-16_105323.png)
    
    ### +130:
    
    Se agrega el 130 al Nodo 5.
    
    Operaciones: L7, L6, L5, E5.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20109.png)
    
    ### +60:
    
    Se agrega el 60 al Nodo 4.
    
    Operaciones: L7, L2, L4, E4.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20110.png)
    
    ### +57:
    
    Se agrega el 57 al Nodo 4, hay overflow: 46 y 56 se quedan en el Nodo 4, 57 se promociona al nodo padre y se traslada junto al 60 a un nuevo nodo.
    
    Operaciones: L7, L2, L4, E4, E8, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20111.png)
    
    ### -96:
    
    Se elimina el 96 del Nodo 5.
    
    Operaciones: L7, L6, L5, E5.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20112.png)
    
    ### -67:
    
    Se elimina el 67 del Nodo 1.
    
    Operaciones: L7, L6, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20113.png)
    
    ### -95:
    
    Se elimina el 95 del Nodo 1, hay underflow: se redistribuye con su hermano derecho, el Nodo 5. Se balancea la carga.
    
    Operaciones: L7, L6, L1, L5, E1, E5, E6.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20114.png)
    
    ### -60:
    
    Se elimina el 60 del Nodo 8.
    
    Operaciones: L7, L2, L8, E8.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20115.png)
    
    ### -120:
    
    Se elimina el 120 del Nodo 1, hay underflow: se trata de redistribuir con su hermano adyacente, no se puede porque tiene la cantidad mínima de claves, se fusionan. Queda liberado el Nodo 5.
    
    El Nodo 6 queda en underflow , se redistribuye con su hermano adyacente. 28 y 46 se quedan en el nodo de la izquierda, 57 se promociona al nodo padre y 67 se mueve al nodo de la derecha.
    
    Operaciones: L7, L6, L1, L5, E1, L2, E2, E6, E7.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20116.png)
    
- **17:** Dada las siguientes operaciones, mostrar la construcción paso a paso de un árbol B+
de orden 6:+52, +23, +10, +99, +63, +74, +19, +85, +14, +73, +5, +7, +41, +100, +130, +44, -63, -73, +15,+16, -74, -52. Política de resolución de underflows: izquierda.
    
    Cantidad mínima de claves por nodo: 6 / 2 -1 = 2.
    
    ### +52:
    
    Se agrega el 52 al Nodo 0.
    
    Operaciones: E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20117.png)
    
    ### +23:
    
    Se agrega el 23 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20118.png)
    
    ### +10:
    
    Se agrega el 10 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20119.png)
    
    ### +99:
    
    Se agrega el 99 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20120.png)
    
    ### +63:
    
    Se agrega el 63 al Nodo 0.
    
    Operaciones: L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20121.png)
    
    ### +74:
    
    Se agrega el 74 al Nodo 0, hay underflow: 10, 23 y 52 se quedan en el Nodo 0, una copia de 63 se promociona al nodo padre (nuevo nodo raíz) y 63, 74 y 99 se mueven al Nodo 1. Se incrementa la altura del árbol.
    
    Operaciones: L0, E0, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20122.png)
    
    ### +19:
    
    Se agrega el 19 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20123.png)
    
    ### +85:
    
    Se agrega el 85 al Nodo 1.
    
    Operaciones: L0, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20124.png)
    
    ### +14:
    
    Se agrega el 14 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20125.png)
    
    ### +73:
    
    Se agrega el 73 al Nodo 1.
    
    Operaciones: L2, L1, E1,
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20126.png)
    
    ### +5:
    
    Se agrega el 5 al Nodo 0, hay overflow: 5, 10 y 14 se quedan en el Nodo 0, 19, 23 y 52 se trasladan a un nuevo nodo, y una copia de 19 se promociona al nodo padre.
    
    Operaciones: L2, L0, E0, E3, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20127.png)
    
    ### +7:
    
    Se agrega el 7 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20128.png)
    
    ### +41:
    
    Se agrega el 41 al Nodo 3.
    
    Operaciones: L2, L3, E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20129.png)
    
    ### +100:
    
    Se agrega el 100 al Nodo 1, hay overflow: 63, 73 y 74 se quedan en el Nodo 1, 85, 99 y 100 se trasladan a un nuevo nodo, una copia de 85 se promociona al nodo padre.
    
    Operaciones: L2, L1, E1, E4, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20130.png)
    
    ### +130:
    
    Se agrega el 130 al Nodo 4.
    
    Operaciones: L2, L4, E4.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20131.png)
    
    ### +44:
    
    Se agrega el 44 al Nodo 3.
    
    Operaciones: L2, L3. E3.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20132.png)
    
    ### -63:
    
    Se elimina el 63 del Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20133.png)
    
    ### -73:
    
    Se elimina el 73 del Nodo 1, hay underflow: se redistribuye con su hermano izquierdo. Se juntan las cargas del Nodo 3 y del Nodo 1, la primera mitad se queda en el Nodo 3, la segunda mitad en el Nodo 1, y una copia de la clave menor de la segunda mitad se promociona al nodo padre.
    
    Operaciones: L2, L1, L3, E3, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20134.png)
    
    ### +15:
    
    Se agrega el 15 al Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20135.png)
    
    ### +16:
    
    Se agrega el 16 al Nodo 0, hay overflow: 5, 7, y10 se quedan en el Nodo 0, 14, 15 y 16 se trasladan a un nuevo nodo, una copia de 14 se promociona al nodo padre.
    
    Operaciones: L2, L0, E0, E5, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20136.png)
    
    ### -74:
    
    Se elimina el 74 del Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20137.png)
    
    ### -52:
    
    Se elimina el 52 del Nodo 1, hay underflow: se redistribuye con el hermano izquierdo. 19 y 23 se quedan en el nodo de la izquierda, 41 y 44 en el nodo de la derecha y una copia de 41 se promociona al nodo padre.
    
    Operaciones: L2, L1, L3, E3, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20138.png)
    
- **18:** Dado el siguiente árbol B+ de orden 4, mostrar cómo quedaría definido el árbol luego
de realizar las siguientes operaciones: -56, -23, -1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20139.png)
    
    Cantidad mínima de claves por nodo: 3 / 2 - 1 = 1.
    
    ### -56:
    
    Se elimina el 56 del Nodo 1.
    
    Operaciones: L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20140.png)
    
    ### -23:
    
    Se elimina el 23 del Nodo 0.
    
    Operaciones: L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20141.png)
    
    ### -1:
    
    Se elimina el 1 del Nodo 0, hay underflow: se redistribuye con el hermano adyacente. 75 se traslada al nodo izquierdo, 107 se queda en el nodo derecho, y se promociona una copia del 107 al nodo padre.
    
    Operaciones: L2, L0, L1, E0, E1, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20142.png)
    
- **19:** Dado un árbol B+ de orden 4  y con política izquierda o derecha, para cada operación dada dibuje el árbol resultante, explique brevemente las decisiones tomadas, escriba las lecturas y escrituras. Operaciones: +4, +44, -94, -104.
    
    Cantidad mínima de claves por nodo 4 / 2 - 1 = 1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20143.png)
    
    ### +4:
    
    Se agrega el 4 al Nodo 0, hay overflow: 4 y 5 se quedan en el Nodo 0, 10 y 20 se trasladan a un nuevo nodo, una copia de 10 se promociona al nodo padre.
    
    Operaciones: L7, L2, L0, E0, E8, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20144.png)
    
    ### +44:
    
    Se agrega el 44 al Nodo 1.
    
    Operaciones: L7, L2, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20145.png)
    
    ### -94:
    
    No se encuentra en el árbol.
    
    ### -104:
    
    Se elimina el 104 del Nodo 5, hay underflow: se redistribuye con su hermano adyacente.
    
    64 se queda en el nodo izquierdo, 80 se traslada al nodo derecho, y una copia de 80 se promociona al nodo padre.
    
    Operaciones: L7, L6, L5, L4, E4, E5, E6.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20146.png)
    
- **20:** Dado el árbol B+ que se detalla más abajo, con orden 6, es decir, capacidad de 5 claves como máximo. Muestre los estados sucesivos al realizar la siguiente secuencia de operaciones: +159, -5 y -190, además indicar nodos leídos y escritos en el orden de ocurrencia. Política de resolución underflow derecha.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20147.png)
    
    ### +159:
    
    Se agrega la clave 159 al Nodo 5, hay overflow: 143, 153 y 158 se quedan en el Nodo 5, 159, 160 y 177 se trasladan a un nuevo nodo y una copia de 159 se promociona al nodo padre.
    
    Se agrega una copia de 159 al Nodo 2, hay overflow: 10, 60 y 115 se quedan en el Nodo 2, 159 y 179 se trasladan a un nuevo nodo, 145 se promociona al nodo padre (nuevo nodo raíz).
    
    Se incrementa la altura del árbol. 
    
    Operaciones: L2, L5, E5, E7, E2, E8, E9.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20148.png)
    
    ### -5:
    
    Se elimina la clave 5 del Nodo 0, hay underflow: se trata de redistribuir con el hermano adyacente, pero no se puede porque ya contiene la cantidad mínima de claves, entonces se fusionan. Queda liberado el Nodo 1, se elimina una clave del Nodo 2.
    
    Operaciones: L9, L2, L0, L1, E0, E2.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20149.png)
    
    ### -190:
    
    Se elimina la clave 190 del Nodo 6, como es un nodo hoja en un extremo se redistribuye con su hermano adyacente. El 177 se traslada al Nodo 6 y una copia de éste se promociona al nodo padre, se elimina la copia del 179 del Nodo 8.
    
    Operaciones: L9, L8, L6, L7, E7, E6, E8.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20150.png)
    
- **21:** Dado un árbol B de orden 5 y con política izquierda o derecha, para cada operación
dada dibuje el árbol resultante, explique detalladamente las decisiones tomadas y escriba las lecturas y escrituras. Operaciones: +165, +260, +800, -110.
    
    Cantidad mínima de claves por nodo 5 / 2 - 1 = 1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20151.png)
    
    ### +165:
    
    Se agrega la clave 165 al Nodo 4, hay overflow: 160 y 165 se quedan en el Nodo 4, 180 y 200 se trasladan a un nuevo nodo, 170 se promociona al nodo padre.
    
    Operaciones: L8, L7, L4, E4, E5, E7.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20152.png)
    
    ### +260:
    
    Se agrega la clave 260 al Nodo 6, hay overflow: 220 y 230 se quedan en el Nodo 6, 250 y 260 se trasladan a un nuevo nodo, 240 se promociona al nodo padre.
    
    Operaciones: L8, L7, L6, E6, E9, E7. 
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20153.png)
    
    ### +800:
    
    Se agrega la clave 800 al Nodo 1, hay overflow: 400 y 500 se quedan en el Nodo 1, 700 y 800 se trasladan a un nuevo nodo, 600 se promociona al nodo padre.
    
    Se agrega la clave 600 al Nodo 7, hay overflow: 170 y 210 se quedan en el Nodo 7, 300 y 600 se trasladan a un nuevo nodo, 240 se promociona al nodo padre.
    
    Operaciones: L8, L7, L1, E1, E10, E7, E11, E8.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20154.png)
    
    ### -110:
    
    Se elimina el 110 del Nodo 0.
    
    Operaciones: L8, L2, L0, E0.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20155.png)
    
- **22:** Dado un árbol B+ de orden 5 y con política izquierda o derecha, para cada operación
dada dibuje el árbol resultante, explique detalladamente las decisiones tomadas y escriba las lecturas y escrituras. Operaciones: +250, +300, -40.
    
    Cantidad mínima de claves por nodo 5 / 2 - 1 = 1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20156.png)
    
    ### +250:
    
    Se agrega el 250 al Nodo 9, hay overflow: 210 y 220 se quedan en el Nodo 9, 230, 240 y 250 se trasladan a un nuevo nodo y una copia de 230 se promociona al nodo padre.
    
    Se agrega una copia de 230 al Nodo 7, hay overflow: 90 y 120 se quedan en el Nodo 7, 230 y 300 se trasladan a un nuevo nodo, 210 se promociona al nodo padre.
    
    Operaciones: L8, L7, L9, E9, E10, E7, E11, E8.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20157.png)
    
    ### +300:
    
    Se agrega la clave 300 al Nodo 1.
    
    Operaciones: L8, L11, L1, E1.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20158.png)
    
    ### -40:
    
    Se elimina el 40 del Nodo 0, hay underflow: se trata de redistribuir con su hermano adyacente, no se puede ya que tiene la cantidad mínima de claves, se fusionan. Se libera el Nodo 4.
    
    El Nodo 2 queda en underflow, se redistribuye con su hermano adyacente: el 70 se traslada al nodo izquierdo, 90 se promociona al nodo padre y 120 se traslada al nodo derecho.
    
    Operaciones: L8, L2, L0, L5, E0, E2, E7, E8.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20159.png)
    

---

## Práctica 5

- **1:** Explique el concepto de función de dispersión. Enumere al menos tres funciones de
dispersión y explique brevemente cómo funciona cada una.
    
    La dispersión es una técnica para generar una dirección base única para una llave dada. Se usa cuando se requiere acceso rápido a una llave. Convierte la llave del registro en un número aleatorio, el que sirve después para determinar donde se almacena el registro. Se usa una función de hash para almacenar y recuperar registros en direcciones de almacenamiento.
    
    1. Centros cuadrados: Se toma una clave de 6 dígitios, se eleva al cuadrado, se toman los dígitos centrales y se multiplican para mapear la cantidad de direcciones de memoria.
    2. Division Hash: Se realiza k mod m, donde k es la llave y m es el tamaño de la tabla hash. El resultado será la dirección de memoria donde se almacenará el registro.
    3. Variante Knuth Division Hash: Es igual a la Division Hash, solo que al valor de k inicial se le suma 3 y luego se le aplica mod m.
    
- **2:** Explique los conceptos de: sinónimo, colisión y desborde.
    
    Sinónimo: Situación en la que la función de hash genera una dirección de memoria para cierto registro que ya está siendo utilizada.
    
    Colisión: Situación en la que un registro es asignado a una dirección que está utilizada por otro registro.
    
    Desborde: Situación en la que un registro es asignado a una dirección que está utilizada por otro registro y no queda espacio para éste nuevo.
    
- **3:** Explique brevemente qué es la densidad de empaquetamiento.
    
    La densidad de empaquetamiento es la proporción de espacio del archivo asignado que en realidad almacena registros. Se calcula dividiendo el número de registros del archivo / capacidad total del archivo.
    
- **4:** Explique cómo funcionan las siguientes técnicas de resolución de colisiones:
    - Saturación progresiva: Cuando se completa el nodo, se busca el próximo hasta encontrar uno libre.
    - Saturación progresiva encadenada: Es similar a la saturación progresiva, pero los registros de saturación se encadenan y no ocupan necesariamente posiciones contiguas.
    - Saturación progresiva encadenada con área de desborde separada: No utiliza nodos de direcciones para los overflows, éstos van a nodos especiales.
    - Dispersión doble: Las técnicas de saturación tienden a agrupar en zonas contiguas y generan búsquedas largas cuando la densidad tiende a uno. La solución de esta técnica de resolución de colisiones es almacenar los registros de overflow en zonas no relacionadas, aplicándoles una segunda función de hash a la llave, el cual se suma a la dirección original tantas veces como sea necesario hasta encontrar una dirección con espacio.
- **5:** Dado el archivo dispersado a continuación, grafique los estados sucesivos para las
siguientes operaciones: +12, +45, -70, -56. Técnica de resolución de colisiones: Saturación progresiva. f(x) = x MOD 11
    
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 44 |  |
    | 1 | 23 | 56 |
    | 2 | 24 |  |
    | 3 |  |  |
    | 4 | 70 |  |
    | 5 | 60 |  |
    | 6 | 50 |  |
    | 7 | 84 |  |
    | 8 |  |  |
    | 9 | 42 |  |
    | 10 | 21 | 65 |
    
    ### +12:
    
    12 mod 11 = 1.
    
    Se trata de agregar la clave 12 a la dirección 1, no se puede porque ya están almacenadas 2 claves, hay overflow, por lo que se almacena en la siguiente dirección libre.
    
    Operaciones: L1, L2, E2.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 44 |  |
    | 1 | 23 | 56 |
    | 2 | 24 | 12 |
    | 3 |  |  |
    | 4 | 70 |  |
    | 5 | 60 |  |
    | 6 | 50 |  |
    | 7 | 84 |  |
    | 8 |  |  |
    | 9 | 42 |  |
    | 10 | 21 | 65 |
    
    ### +45:
    
    45 mod 11 = 1.
    
    Se trata de agregar la clave 45 en la dirección 1, no se puede porque ya están almacenadas 2 claves, hya overflow, por lo que se almacena en la siguiente dirección libre.
    
    Operaciones: L1, L2, L3, E3.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 44 |  |
    | 1 | 23 | 56 |
    | 2 | 24 | 12 |
    | 3 | 45 |  |
    | 4 | 70 |  |
    | 5 | 60 |  |
    | 6 | 50 |  |
    | 7 | 84 |  |
    | 8 |  |  |
    | 9 | 42 |  |
    | 10 | 21 | 65 |
    
    ### -70:
    
    70 mod 11 = 4.
    
    Se elimina la clave 70 de la dirección 4 y no se deja una marca de borrado porque la siguiente dirección no tiene datos.
    
    Operaciones: L4, E4.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 44 |  |
    | 1 | 23 | 56 |
    | 2 | 24 | 12 |
    | 3 | 45 |  |
    | 4 |  |  |
    | 5 | 60 |  |
    | 6 | 50 |  |
    | 7 | 84 |  |
    | 8 |  |  |
    | 9 | 42 |  |
    | 10 | 21 | 65 |
    
    ### -56:
    
    56 mod 11 = 1.
    
    Se elimina la clave 56 de la dirección 1. Como el nodo está lleno y en la siguiente dirección hay datos, se deja una marca de borrado.
    
    Operaciones: L1, E1.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 44 |  |
    | 1 | 23 | ### |
    | 2 | 24 | 12 |
    | 3 | 45 |  |
    | 4 |  |  |
    | 5 | 60 |  |
    | 6 | 50 |  |
    | 7 | 84 |  |
    | 8 |  |  |
    | 9 | 42 |  |
    | 10 | 21 | 65 |
    
    Densidad de empaquetamiento = Nº de registros / espacio total.
    
    Nº de registros = 11.
    
    Espacio total = 11 * 2 = 22.
    
    11 / 22 = 0,5 = 50%.
    
- **6:** Dado el archivo dispersado a continuación, grafique los estados sucesivos, indique
lecturas y escrituras y calcule la densidad de empaquetamiento para las siguientes
operaciones: +31, +82, -15, -52. Técnica de resolución de colisiones: Saturación progresiva.
f(x) = x MOD 10.
    
    
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
    | 4 |  |  |
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
    | 5 | 15 |  |
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
    | 2 | 52 | 31 |
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
    
    Densidad de empaquetamiento: 8 / 10*2 = 8 / 20 = 0,4 = 40%.
    
- **7:** Dado el archivo dispersado a continuación, grafique los estados sucesivos para las
siguientes operaciones: +20, +55, +36, +45, +50, -39, -29. Técnica de resolución de colisiones: Saturación progresiva. f(x) = x MOD 19
    
    
    | Dirección | Clave |
    | --- | --- |
    | 0 | 19 |
    | 1 | 39 |
    | 2 | 59 |
    | 3 |  |
    | 4 | 23 |
    | 5 |  |
    | 6 |  |
    | 7 | 64 |
    | 8 |  |
    | 9 | 47 |
    | 10 | 29 |
    | 11 |  |
    | 12 | 69 |
    | 13 |  |
    | 14 |  |
    | 15 | 34 |
    | 16 |  |
    | 17 |  |
    | 18 | 56 |
    
    ### +20:
    
    20 mod 19 = 1.
    
    Se trata de agregar la clave 20 a la dirección 1, no se puede porque ya está llena, hay overflow, se agrega en la siguiente dirección libre.
    
    Operaciones: L1, L2, L3, E3.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 | 19 |
    | 1 | 39 |
    | 2 | 59 |
    | 3 | 20 |
    | 4 | 23 |
    | 5 |  |
    | 6 |  |
    | 7 | 64 |
    | 8 |  |
    | 9 | 47 |
    | 10 | 29 |
    | 11 |  |
    | 12 | 69 |
    | 13 |  |
    | 14 |  |
    | 15 | 34 |
    | 16 |  |
    | 17 |  |
    | 18 | 56 |
    
    ### +55:
    
    55 mod 19: 17.
    
    Se agrega la clave 55 a la dirección 17.
    
    Operaciones: L17, E17.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 | 19 |
    | 1 | 39 |
    | 2 | 59 |
    | 3 | 20 |
    | 4 | 23 |
    | 5 |  |
    | 6 |  |
    | 7 | 64 |
    | 8 |  |
    | 9 | 47 |
    | 10 | 29 |
    | 11 |  |
    | 12 | 69 |
    | 13 |  |
    | 14 |  |
    | 15 | 34 |
    | 16 |  |
    | 17 | 55 |
    | 18 | 56 |
    
    ### +36:
    
    36 mod 19 = 17.
    
    Se trata de agregar la clave 36 a la dirección 17, no se puede porque ya está llena, hay overflow, se agrega a la siguiente dirección libre.
    
    Operaciones: L17, L18, L0, L1, L2, L3, L4, L5, E5.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 | 19 |
    | 1 | 39 |
    | 2 | 59 |
    | 3 | 20 |
    | 4 | 23 |
    | 5 | 36 |
    | 6 |  |
    | 7 | 64 |
    | 8 |  |
    | 9 | 47 |
    | 10 | 29 |
    | 11 |  |
    | 12 | 69 |
    | 13 |  |
    | 14 |  |
    | 15 | 34 |
    | 16 |  |
    | 17 | 55 |
    | 18 | 56 |
    
    ### +45:
    
    45 mod 19 = 7.
    
    Se trata de agregar la clave a la dirección 7, no se puede porque ya está llena, hay overflow y se agrega a la siguiente dirección libre.
    
    Operaciones: L7, L8, E8.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 | 19 |
    | 1 | 39 |
    | 2 | 59 |
    | 3 | 20 |
    | 4 | 23 |
    | 5 | 36 |
    | 6 |  |
    | 7 | 64 |
    | 8 | 45 |
    | 9 | 47 |
    | 10 | 29 |
    | 11 |  |
    | 12 | 69 |
    | 13 |  |
    | 14 |  |
    | 15 | 34 |
    | 16 |  |
    | 17 | 55 |
    | 18 | 56 |
    
    ### +50:
    
    50 mod 19 = 12.
    
    Se trata de agregar la clave a la dirección 12, no se puede porque ya está llena, hay overflow y se agrega a la siguiente dirección libre.
    
    Operaciones: L12, L13, E13.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 | 19 |
    | 1 | 39 |
    | 2 | 59 |
    | 3 | 20 |
    | 4 | 23 |
    | 5 | 36 |
    | 6 |  |
    | 7 | 64 |
    | 8 | 45 |
    | 9 | 47 |
    | 10 | 29 |
    | 11 |  |
    | 12 | 69 |
    | 13 | 50 |
    | 14 |  |
    | 15 | 34 |
    | 16 |  |
    | 17 | 55 |
    | 18 | 56 |
    
    ### -39:
    
    39 mod 19 = 1.
    
    Elimino la clave 39 de la dirección 1, como está llena y la siguiente dirección tiene datos se deja una marca.
    
    Operaciones: L1, E1.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 | 19 |
    | 1 | ### |
    | 2 | 59 |
    | 3 | 20 |
    | 4 | 23 |
    | 5 | 36 |
    | 6 |  |
    | 7 | 64 |
    | 8 | 45 |
    | 9 | 47 |
    | 10 | 29 |
    | 11 |  |
    | 12 | 69 |
    | 13 | 50 |
    | 14 |  |
    | 15 | 34 |
    | 16 |  |
    | 17 | 55 |
    | 18 | 56 |
    
    ### -29:
    
    29 mod 19 = 10.
    
    Se elimina la clave 29 de la dirección 10, como está llena pero la dirección siguiente no tiene datos no se deja una marca.
    
    Operaciones: L10, E10.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 | 19 |
    | 1 | ### |
    | 2 | 59 |
    | 3 | 20 |
    | 4 | 23 |
    | 5 | 36 |
    | 6 |  |
    | 7 | 64 |
    | 8 | 45 |
    | 9 | 47 |
    | 10 |  |
    | 11 |  |
    | 12 | 69 |
    | 13 | 50 |
    | 14 |  |
    | 15 | 34 |
    | 16 |  |
    | 17 | 55 |
    | 18 | 56 |
    
    Densidad de empaquetamiento = 13 / 19 = 0,68 = 68%.
    
- **8:** Dado el archivo dispersado a continuación, grafique los estados sucesivos para las
siguientes operaciones: +23, +56, +90, +61, -49, -67. Técnica de resolución de colisiones: Saturación progresiva encadenada. f(x) = x MOD 11
    
    
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
    
    ### +23:
    
    23 mod 11 = 1.
    
    Se trata de agregar la clave 23 a la dirección 1, no se puede porque está llena, se genera overflow, se agrega en la siguiente dirección libre como clave intrusa y se modifica el enlace de la dirección 1 para que esté enlazada con la dirección en la que se agrega.
    
    Operaciones: L1, L2, E2, E1.
    
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
    
    ### +56:
    
    56 mod 11 = 1.
    
    Se trata de agregar la clave 56 a la dirección 1, no se puede porque está llena, se genera overflow, se agrega en la siguiente dirección libre como clave intrusa y se modifica el enlace de la dirección 1 para que esté enlazada con la dirección en la que se agrega.
    
    Operaciones: L1, L2, L3, L4, E4, E1.
    
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
    
    ### +90:
    
    90 mod 11 = 2.
    
    Se agrega la clave 90 a la dirección 2, como estaba almacenando una clave intrusa ésta se mueve a la siguiente dirección libre, y se modifica el enlace de la dirección que estaba enlazada con la clave intrusa.
    
    Operaciones: L2, L3, L4, L5, L6, L7, L8, L9, L10, E10, L1, E4, E2.
    
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
    | 5 | 8 | 71 |
    | 6 | -1 | 61 |
    | 7 | -1 | 18 |
    | 8 | 0 | 49 |
    | 9 | -1 | 20 |
    | 10 | -1 | 23 |
    
    ### -49:
    
    49 mod 11 = 5.
    
    Se trata de eliminar la clave 49 de la dirección 5, como no se encuentra en ésta se va a la dirección enlazada, y se elimina de allí. Se actualiza el enlace de la dirección 5.
    
    Operaciones: L5, L8, E8, E5.
    
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
    
    ### -67:
    
    67 mod 11 = 1.
    
    Se elimina la clave 67 de la dirección 1, y se sustituye por la clave en la dirección que tenía enlazada (56 en la dirección 4). Se actualiza el enlace de la dirección 1 para que quede enlazada con la dirección que tenía la dirección 4.
    
    Operaciones: L1, L4, E4, E1.
    
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
    
    Densidad de empaquetamiento = 9 / 11 = 0.81 = 81%.
    
- **9:** Dado el archivo dispersado a continuación, grafique los estados sucesivos para las
siguientes operaciones: +78, +34, +23, +48, +37, -34. Técnica de resolución de colisiones: Saturación progresiva encadenada. f(x) = x MOD 11
    
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | -1 | 12 |
    | 2 | -1 |  |
    | 3 | -1 | 47 |
    | 4 | -1 |  |
    | 5 | -1 | 16 |
    | 6 | -1 |  |
    | 7 | -1 | 18 |
    | 8 | -1 |  |
    | 9 | -1 | 20 |
    | 10 | -1 |  |
    
    ### +78:
    
    78 mod 11 = 1.
    
    Se trata de agregar la clave 78 a la dirección 1, no se puede porque ya está llena, hay overflow, se agrega en la siguiente dirección libre como clave intrusa y se modifica el enlace de la dirección 1 para que esté enlazada con la dirección donde se agregó el 78.
    
    Operaciones: L1, L2, E2, E1.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 2 | 12 |
    | 2 | -1 | 78 |
    | 3 | -1 | 47 |
    | 4 | -1 |  |
    | 5 | -1 | 16 |
    | 6 | -1 |  |
    | 7 | -1 | 18 |
    | 8 | -1 |  |
    | 9 | -1 | 20 |
    | 10 | -1 |  |
    
    ### +34:
    
    34 mod 11 = 1.
    
    Se trata de agregar la clave 34 a la dirección 1, no se puede porque ya está llena, hay overflow, se agrega en la siguiente dirección libre como clave intrusa y se modifica el enlace de la dirección 1 para que quede enlazada a la dirección donde se agregó. Se modifica el enlace de la dirección donde se agregó para que quede enlazada con el previo enlace que tenía la dirección 1.
    
    Operaciones: L1, L2, L3, L4, E4, E1.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 4 | 12 |
    | 2 | -1 | 78 |
    | 3 | -1 | 47 |
    | 4 | 2 | 34 |
    | 5 | -1 | 16 |
    | 6 | -1 |  |
    | 7 | -1 | 18 |
    | 8 | -1 |  |
    | 9 | -1 | 20 |
    | 10 | -1 |  |
    
    ### +23:
    
    23 mod 11 = 1.
    
    Se trata de agregar la clave 23 a la dirección 1, no se puede porque ya está llena, hay overflow, se agrega en la siguiente dirección libre como clave intrusa y se modifica el enlace de la dirección 1 para que quede enlazada a la dirección donde se agregó. Se modifica el enlace de la dirección donde se agregó para que quede enlazada con el previo enlace que tenía la dirección 1.
    
    Operaciones: L1, L2, L3, L4, L5, L6, E6, E1.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 6 | 12 |
    | 2 | -1 | 78 |
    | 3 | -1 | 47 |
    | 4 | 2 | 34 |
    | 5 | -1 | 16 |
    | 6 | 4 | 23 |
    | 7 | -1 | 18 |
    | 8 | -1 |  |
    | 9 | -1 | 20 |
    | 10 | -1 |  |
    
    ### +48:
    
    48 mod 11 = 4.
    
    Se agrega la clave 48 a la dirección 4, hay overflow, la clave intrusa que estaba se inserta en la siguiente dirección libre y se actualizan los enlaces.
    
    Operaciones: L4, L5, L6, L7, L8, E8, E6, E4.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 6 | 12 |
    | 2 | -1 | 78 |
    | 3 | -1 | 47 |
    | 4 | -1 | 48 |
    | 5 | -1 | 16 |
    | 6 | 8 | 23 |
    | 7 | -1 | 18 |
    | 8 | 2 | 34 |
    | 9 | -1 | 20 |
    | 10 | -1 |  |
    
    ### +37:
    
    37 mod 11 = 4.
    
    Se trata de agregar la clave 37 en la dirección 4, no se puede porque ya está llena, hay overflow, se agrega en la siguiente dirección libre como clave intrusa. La dirección 4 ahora está enlazada con la dirección donde se agregó.
    
    Operaciones: L4, L5, L6, L7, L8, L9, L10, E10, E4.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 6 | 12 |
    | 2 | -1 | 78 |
    | 3 | -1 | 47 |
    | 4 | 10 | 48 |
    | 5 | -1 | 16 |
    | 6 | 8 | 23 |
    | 7 | -1 | 18 |
    | 8 | 2 | 34 |
    | 9 | -1 | 20 |
    | 10 | -1 | 37 |
    
    ### -34:
    
    34 mod 11 = 1.
    
    Se trata de eliminar el 34 de la dirección 1, no se encuentra, entonces se busca en la dirección enlazada.
    
    Se trata de eliminar el 34 de la dirección 6, no se encuentra, entonces se busca en la dirección enlazada.
    
    Se elimina el 34 de la dirección 8, y se actualiza el enlace de la dirección 6 para que quede enlazada con la dirección enlazada que tenía la dirección 8.
    
    Operaciones: L1, L6, L8, E8, E6.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 6 | 12 |
    | 2 | -1 | 78 |
    | 3 | -1 | 47 |
    | 4 | 10 | 48 |
    | 5 | -1 | 16 |
    | 6 | 2 | 23 |
    | 7 | -1 | 18 |
    | 8 | -1 |  |
    | 9 | -1 | 20 |
    | 10 | -1 | 37 |
    
    Densidad de empaquetamiento: 9 / 11 = 0,81 = 81%.
    
- **10:** Dado el archivo dispersado a continuación, grafique los estados sucesivos para las
siguientes operaciones: +81, +69, +27, +51, +56, -45, -49. Técnica de resolución de colisiones: Saturación progresiva encadenada. f(x) = x MOD 11
    
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 3 | 45 |
    | 2 | -1 | 13 |
    | 3 | -1 | 89 |
    | 4 | -1 |  |
    | 5 | -1 | 49 |
    | 6 | -1 |  |
    | 7 | -1 |  |
    | 8 | -1 | 74 |
    | 9 | -1 |  |
    | 10 | -1 |  |
    
    ### +81:
    
    81 mod 11 = 4.
    
    Se agrega la clave 81 a la dirección 4.
    
    Operaciones: L4, E4.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 3 | 45 |
    | 2 | -1 | 13 |
    | 3 | -1 | 89 |
    | 4 | -1 | 81 |
    | 5 | -1 | 49 |
    | 6 | -1 |  |
    | 7 | -1 |  |
    | 8 | -1 | 74 |
    | 9 | -1 |  |
    | 10 | -1 |  |
    
    ### +69:
    
    69 mod 11 = 3.
    
    Se agrega la clave 69 a la dirección 3, como ésta tenía una clave intrusa hay overlfow, se mueve a la siguiente dirección libre, y se actualiza el enlace de la dirección que estaba enlazada con la dirección 3.
    
    Operaciones: L3, L4, L5, L6, E6, E1, E3.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 6 | 45 |
    | 2 | -1 | 13 |
    | 3 | -1 | 69 |
    | 4 | -1 | 81 |
    | 5 | -1 | 49 |
    | 6 | -1 | 89 |
    | 7 | -1 |  |
    | 8 | -1 | 74 |
    | 9 | -1 |  |
    | 10 | -1 |  |
    
    ### +27:
    
    27 mod 11 = 5.
    
    Se trata de agregar 27 a la dirección 5, como ya tiene una clave hay overflow, y se agrega en la siguiente dirección libre como clave intrusa, y la dirección 5 queda enlazada con la dirección en donde se agregó el 27.
    
    Operaciones: L5, L6, L7, E7, E5.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 6 | 45 |
    | 2 | -1 | 13 |
    | 3 | -1 | 69 |
    | 4 | -1 | 81 |
    | 5 | 7 | 49 |
    | 6 | -1 | 89 |
    | 7 | -1 | 27 |
    | 8 | -1 | 74 |
    | 9 | -1 |  |
    | 10 | -1 |  |
    
    ### +51:
    
    51 mod 11 = 7.
    
    Se agrega la clave 51 a la dirección 7, como ésta tenía una clave intrusa, se mueve a la siguiente dirección libre y se actualiza el enlace de la dirección con la que estaba enlazada esta clave.
    
    Operaciones: L7, L8, L9, E9, E5, E7.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 6 | 45 |
    | 2 | -1 | 13 |
    | 3 | -1 | 69 |
    | 4 | -1 | 81 |
    | 5 | 9 | 49 |
    | 6 | -1 | 89 |
    | 7 | -1 | 51 |
    | 8 | -1 | 74 |
    | 9 | -1 | 27 |
    | 10 | -1 |  |
    
    ### +56:
    
    56 mod 11 = 1.
    
    Se trata de agregar el 56 a la dirección 1, no se puede porque ya hay una clave, hay overflow, se agrega en la siguiente dirección libre como clave intrusa. El enlace de la dirección 1 será la dirección donde se agregó, y el enlace de la dirección donde se agregó será el enlace previo de la dirección 1.
    
    Operaciones: L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, E10, E1.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 10 | 45 |
    | 2 | -1 | 13 |
    | 3 | -1 | 69 |
    | 4 | -1 | 81 |
    | 5 | 9 | 49 |
    | 6 | -1 | 89 |
    | 7 | -1 | 51 |
    | 8 | -1 | 74 |
    | 9 | -1 | 27 |
    | 10 | 6 | 56 |
    
    ### -45:
    
    45 mod 11 = 1.
    
    Se elimina el 45 de la dirección 1, y su contenido se reemplaza por la dirección a la cual estaba enlazada.
    
    Operaciones: L1, L10, E10, E1.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 6 | 56 |
    | 2 | -1 | 13 |
    | 3 | -1 | 69 |
    | 4 | -1 | 81 |
    | 5 | 9 | 49 |
    | 6 | -1 | 89 |
    | 7 | -1 | 51 |
    | 8 | -1 | 74 |
    | 9 | -1 | 27 |
    | 10 | -1 |  |
    
    ### -49:
    
    49 mod 11 = 5.
    
    Se elimina la clave 49 de la dirección 5, y su contenido se reemplaza por la dirección a la cual estaba enlazada.
    
    Operaciones: L5, L9, E9, E5.
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | 6 | 56 |
    | 2 | -1 | 13 |
    | 3 | -1 | 69 |
    | 4 | -1 | 81 |
    | 5 | -1 | 27 |
    | 6 | -1 | 89 |
    | 7 | -1 | 51 |
    | 8 | -1 | 74 |
    | 9 | -1 |  |
    | 10 | -1 |  |
    
    Densidad de empaquetamiento: 8 / 11 = 0,72 = 72%.
    
- **11:** Dado el archivo dispersado a continuación, grafique los estados sucesivos para las
siguientes operaciones: +56, +12, +18, -25, -56. Técnica de resolución: Saturación progresiva encadenada con área de desborde por separado. f(x) = x MOD 11
    
    
    | Dirección | Enlace | Clave | Clave |
    | --- | --- | --- | --- |
    | 0 | -1 | 22 |  |
    | 1 | -1 | 34 | 78 |
    | 2 | -1 | 46 |  |
    | 3 | -1 | 25 | 58 |
    | 4 | -1 | 15 | 59 |
    | 5 | -1 |  |  |
    | 6 | -1 |  |  |
    | 7 | -1 | 40 |  |
    | 8 | -1 |  |  |
    | 9 | -1 |  |  |
    | 10 | -1 |  |  |
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | -1 |  |
    | 2 | -1 |  |
    | 3 | -1 |  |
    
    ### +56:
    
    56 mod 11 = 1.
    
    Se trata de agregar la clave 56 a la dirección 1, no se puede porque ya tiene 2 claves, hay overflow, se tiene que agregar en el área de desborde por separado. El enlace de la dirección 1 ahora es la dirección donde se agregó la clave 56.
    
    Operaciones: L1, L0 [área de desborde], E0 [área de desborde], E1.
    
    | Dirección | Enlace | Clave | Clave |
    | --- | --- | --- | --- |
    | 0 | -1 | 22 |  |
    | 1 | 0 | 34 | 78 |
    | 2 | -1 | 46 |  |
    | 3 | -1 | 25 | 58 |
    | 4 | -1 | 15 | 59 |
    | 5 | -1 |  |  |
    | 6 | -1 |  |  |
    | 7 | -1 | 40 |  |
    | 8 | -1 |  |  |
    | 9 | -1 |  |  |
    | 10 | -1 |  |  |
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 | 56 |
    | 1 | -1 |  |
    | 2 | -1 |  |
    | 3 | -1 |  |
    
    ### +12:
    
    12 mod 11 = 1.
    
    Se trata de agregar la clave en la dirección 1, no se puede porque ya tiene 2 claves, hay overflow, se tiene que agregar en el área de desborde por separado. El enlace de la dirección ahora es la dirección donde se agregó la clave 12, el enlace de la dirección donde se agregó la clave 12 ahora es el enlace que antes tenía la dirección 1.
    
    Operaciones: L1, L0 [área de desborde], L1 [área de desborde], E1 [área de desborde], E1.
    
    | Dirección | Enlace | Clave | Clave |
    | --- | --- | --- | --- |
    | 0 | -1 | 22 |  |
    | 1 | 1 | 34 | 78 |
    | 2 | -1 | 46 |  |
    | 3 | -1 | 25 | 58 |
    | 4 | -1 | 15 | 59 |
    | 5 | -1 |  |  |
    | 6 | -1 |  |  |
    | 7 | -1 | 40 |  |
    | 8 | -1 |  |  |
    | 9 | -1 |  |  |
    | 10 | -1 |  |  |
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 | 56 |
    | 1 | 0 | 12 |
    | 2 | -1 |  |
    | 3 | -1 |  |
    
    ### +18:
    
    18 mod 11 = 7.
    
    Se agrega la clave 18 a la dirección 7.
    
    Operaciones: L7, E7.
    
    | Dirección | Enlace | Clave | Clave |
    | --- | --- | --- | --- |
    | 0 | -1 | 22 |  |
    | 1 | 1 | 34 | 78 |
    | 2 | -1 | 46 |  |
    | 3 | -1 | 25 | 58 |
    | 4 | -1 | 15 | 59 |
    | 5 | -1 |  |  |
    | 6 | -1 |  |  |
    | 7 | -1 | 40 | 18 |
    | 8 | -1 |  |  |
    | 9 | -1 |  |  |
    | 10 | -1 |  |  |
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 | 56 |
    | 1 | 0 | 12 |
    | 2 | -1 |  |
    | 3 | -1 |  |
    
    ### -25:
    
    25 mod 11 = 3.
    
    Se elimina la clave 25 de la dirección 3.
    
    Operaciones: L3, E3.
    
    | Dirección | Enlace | Clave | Clave |
    | --- | --- | --- | --- |
    | 0 | -1 | 22 |  |
    | 1 | 1 | 34 | 78 |
    | 2 | -1 | 46 |  |
    | 3 | -1 |  | 58 |
    | 4 | -1 | 15 | 59 |
    | 5 | -1 |  |  |
    | 6 | -1 |  |  |
    | 7 | -1 | 40 | 18 |
    | 8 | -1 |  |  |
    | 9 | -1 |  |  |
    | 10 | -1 |  |  |
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 | 56 |
    | 1 | 0 | 12 |
    | 2 | -1 |  |
    | 3 | -1 |  |
    
    ### -56:
    
    56 mod 11 = 1.
    
    Se trata de eliminar 56 de la dirección 1, no se encuentra, se va a la dirección enlazada, no se encuentra, se va a la dirección enlazada de esta, se encuentra y se elimina. Se actualiza el enlace de la dirección que estaba apuntando a la dirección donde se encontraba el 56.
    
    Operaciones: L1, L1 [AD], L0 [AD], E0 [AD], E1 [AD].
    
    | Dirección | Enlace | Clave | Clave |
    | --- | --- | --- | --- |
    | 0 | -1 | 22 |  |
    | 1 | 1 | 34 | 78 |
    | 2 | -1 | 46 |  |
    | 3 | -1 |  | 58 |
    | 4 | -1 | 15 | 59 |
    | 5 | -1 |  |  |
    | 6 | -1 |  |  |
    | 7 | -1 | 40 | 18 |
    | 8 | -1 |  |  |
    | 9 | -1 |  |  |
    | 10 | -1 |  |  |
    
    | Dirección | Enlace | Clave |
    | --- | --- | --- |
    | 0 | -1 |  |
    | 1 | -1 | 12 |
    | 2 | -1 |  |
    | 3 | -1 |  |
    
    Densidad de empaquetamiento = 10 / 26 = 0,38 = 38%.
    
- **12:** Dado el archivo dispersado a continuación, grafique los estados sucesivos para las
siguientes operaciones: +45, +48, +23, +21, +59, -44, -45. Técnica de resolución de colisiones: Saturación progresiva encadenada con área de desborde por separado. f(x) = x MOD 11
    
    
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
    
    ### +48:
    
    48 mod 11 = 4.
    
    Se trata de agregar la clave a la dirección 4, no se puede porque ya hay una clave, hay overflow, se agrega en la primer dirección libre del área de desborde. Se actualiza el enlace de la dirección 4 para que quede enlazada con la dirección donde se acaba de agregar el 48.
    
    Operaciones: L4, L0[AD], L1[AD], E1[AD].
    
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
    | 10 | -1 |  |
    
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
    
    ### +59:
    
    59 mod 11 = 4.
    
    Se trata de agregar el 59 a la dirección 4, no se puede porque ya hay una clave, hay overflow, se agrega en la siguiente dirección libre del área de desborde. El enlace de la dirección 4 pasa a ser la dirección donde se agregó el 59, y el enlace de la dirección donde se agregó el 59 es la clave anterior de la dirección 4.
    
    Operaciones: L4, L0 [AD], L1 [AD], L2 [AD], L3 [AD], E3 [AD], E4.
    
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
    | 0 | -1 | 45 |
    | 1 | -1 | 48 |
    | 2 | 0 | 23 |
    | 3 | 1 | 59 |
    
    ### -45:
    
    45 mod 11 = 1.
    
    Se trata de eliminar el 45 de la dirección 1, no se encuentra, se va a la dirección enlazada de ésta, no se encuentra, se va a la dirección enlazada de ésta, se encuentra y se elimina. El enlace de la dirección que tenía enlazada la dirección donde estaba el 45 se modifica.
    
    Operaciones: L1, L2 [AD], L0 [AD], E0 [AD], E2 [AD].
    
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
    
    Densidad de empaquetamiento = 8 / 15 = 0,53 = 53%.
    
- **13:** Dado el archivo dispersado a continuación, grafique los estados sucesivos para las
siguientes operaciones: +58, +63, +78, -78, -34. Técnica de resolución de colisiones: Dispersión Doble. f1(x) = x MOD 11; f2(x)= x MOD 7 + 1
    
    
    | Dirección | Clave |
    | --- | --- |
    | 0 |  |
    | 1 | 34 |
    | 2 |  |
    | 3 | 69 |
    | 4 | 26 |
    | 5 |  |
    | 6 | 72 |
    | 7 |  |
    | 8 | 41 |
    | 9 |  |
    | 10 |  |
    
    ### +58:
    
    58 mod 11 = 3.
    
    Se trata de agregar 58 a la dirección 3, no se puede porque ya hay una clave, hay overflow, se le aplica la segunda función de hash.
    
    58 mod 7 + 1 = 3.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 3 + 3 = 6.
    
    Se trata de agregar 58 a la dirección 6, no se puede porque ya hay una clave, hay overflow nuevamente, se aplica la segunda función de hash.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 6 + 3 = 9.
    
    Se agrega 58 a la dirección 9.
    
    Operaciones: L3, L6, L9, E9.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 |  |
    | 1 | 34 |
    | 2 |  |
    | 3 | 69 |
    | 4 | 26 |
    | 5 |  |
    | 6 | 72 |
    | 7 |  |
    | 8 | 41 |
    | 9 | 58 |
    | 10 |  |
    
    ### +63:
    
    63 mod 11 = 8.
    
    Se trata de agregar 63 a la dirección 8, no se puede porque ya hay una clave, hay overflow, se le aplica la segunda función de hash.
    
    63 mod 7 + 1 = 1.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 8 + 1 = 9.
    
    Se trata de agregar 63 a la dirección 4, no se puede porque ya hay una clave, hay overflow, se le aplica la segunda función de hash.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 9 + 1 = 10.
    
    Se agrega 63 a la dirección 10.
    
    Operaciones: L8, L9, L10, E10.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 |  |
    | 1 | 34 |
    | 2 |  |
    | 3 | 69 |
    | 4 | 26 |
    | 5 |  |
    | 6 | 72 |
    | 7 |  |
    | 8 | 41 |
    | 9 | 58 |
    | 10 | 63 |
    
    ### +78:
    
    78 mod 11 = 1.
    
    Se trata de agregar 78 a la dirección 1, no se puede porque ya hay una clave, hay overflow, se le aplica la segunda función de hash.
    
    78 mod 7 + 1 = 2.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 1 + 2 = 3.
    
    Se trata de agregar 78 a la dirección 3, no se puede porque ya hay una clave, hay overflow, se le aplica la segunda función de hash.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 3 + 2 = 5.
    
    Se agrega la clave 78 a la dirección 5.
    
    Operaciones: L1, L3, L5, E5.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 |  |
    | 1 | 34 |
    | 2 |  |
    | 3 | 69 |
    | 4 | 26 |
    | 5 | 78 |
    | 6 | 72 |
    | 7 |  |
    | 8 | 41 |
    | 9 | 58 |
    | 10 | 63 |
    
    ### -78:
    
    78 mod 11 = 1.
    
    Se trata de eliminar 78 de la dirección 1, no se encuentra, se aplica la segunda función de hash.
    
    78 mod 7 + 1 = 2.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 1 + 2 = 3.
    
    Se trata de eliminar 78 de la dirección 3, no se encuentra, se aplica la segunda función de hash.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 3 + 2 = 5.
    
    Se elimina el 78 de la dirección 5 y se deja una marca de borrado.
    
    Operaciones: L1, L3, L5, E5.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 |  |
    | 1 | 34 |
    | 2 |  |
    | 3 | 69 |
    | 4 | 26 |
    | 5 | ### |
    | 6 | 72 |
    | 7 |  |
    | 8 | 41 |
    | 9 | 58 |
    | 10 | 63 |
    
    ### -34:
    
    34 mod 11 = 1.
    
    Se elimina el 34 de la dirección 1 y se deja una marca de borrado.
    
    Operaciones: L1, E1.
    
    | Dirección | Clave |
    | --- | --- |
    | 0 |  |
    | 1 | ### |
    | 2 |  |
    | 3 | 69 |
    | 4 | 26 |
    | 5 | ### |
    | 6 | 72 |
    | 7 |  |
    | 8 | 41 |
    | 9 | 58 |
    | 10 | 63 |
    
    Densidad de empaquetamiento = 6 / 11 = 0,54 = 54%.
    
- **14:** Dado el archivo dispersado a continuación, grafique los estados sucesivos para las
siguientes operaciones: +47, +26, +23, -34, -28. Técnica de resolución de colisiones: Dispersión Doble. f1(x) = x MOD 11; f2(x)= x MOD 5 + 1
    
    
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
    | 8 |  |
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
    | 5 |  |
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
    | 6 | 28 |
    | 7 | 29 |
    | 8 | 26 |
    | 9 |  |
    | 10 |  |
    
    ### -28:
    
    28 mod 11 = 6.
    
    Se elimina el 28 de la dirección 6 y se deja una marca de borrado.
    
    Operaciones: L6, E6.
    
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
    
    Densidad de empaquetamiento = 5 / 11 = 0,45 = 45%.
    
- **15:** Se debe crear y cargar un archivo directo con capacidad para 2 registros con
dispersión doble para organizar registros en saturación, con los 9 registros cuyas claves
se listan a continuación y de manera que su densidad de empaquetamiento resulte del
75%: +347, +498, +729, +222, +113, +885, +431, +593, +709.
Usar como segunda función de dispersión el módulo 5 más 1.
    
    f1(x) = x mod 6; f2(x) = x mod 5 +1
    
    9 claves / 75% = x claves / 100%
    
    (9 claves / 75%) * 100 % = 12 claves.
    
    Se podrán almacenar hasta 12 claves, las cuales se almacenan de a 2. 12 / 2 = 6 direcciones.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 |  |  |
    | 1 |  |  |
    | 2 |  |  |
    | 3 |  |  |
    | 4 |  |  |
    | 5 |  |  |
    
    ### +347:
    
    347 mod 6 = 5.
    
    Se agrega el 347 a la dirección 5.
    
    Operaciones: L5, E5.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 |  |  |
    | 1 |  |  |
    | 2 |  |  |
    | 3 |  |  |
    | 4 |  |  |
    | 5 | 347 |  |
    
    ### +498:
    
    498 mod 6 = 0.
    
    Se agrega el 498 a la dirección 0.
    
    Operaciones: L0, E0.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 498 |  |
    | 1 |  |  |
    | 2 |  |  |
    | 3 |  |  |
    | 4 |  |  |
    | 5 | 347 |  |
    
    ### +729:
    
    729 mod 6 = 3.
    
    Se agrega el 729 a la dirección 3.
    
    Operaciones: L3, E3.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 498 |  |
    | 1 |  |  |
    | 2 |  |  |
    | 3 | 729 |  |
    | 4 |  |  |
    | 5 | 347 |  |
    
    ### +222:
    
    222 mod 6 = 0.
    
    Se agrega el 222 a la dirección 0.
    
    Operaciones: L0, E0.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 498 | 222 |
    | 1 |  |  |
    | 2 |  |  |
    | 3 | 729 |  |
    | 4 |  |  |
    | 5 | 347 |  |
    
    ### +113:
    
    113 mod 6 = 5.
    
    Se agrega el 113 a la dirección 5.
    
    Operaciones: L5, E5.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 498 | 222 |
    | 1 |  |  |
    | 2 |  |  |
    | 3 | 729 |  |
    | 4 |  |  |
    | 5 | 347 | 113 |
    
    ### +885:
    
    885 mod 6 = 3.
    
    Se agrega el 885 a la dirección 3.
    
    Operaciones: L3, E3.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 498 | 222 |
    | 1 |  |  |
    | 2 |  |  |
    | 3 | 729 | 885 |
    | 4 |  |  |
    | 5 | 347 | 113 |
    
    ### +431:
    
    431 mod 6 = 5.
    
    Se trata de agregar el 431 a la dirección 5, no se puede porque ya hay 2 claves, hay overflow, se aplica la segunda función de hash.
    
    431 mod 5 + 1 = 2.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 5 + 2 = 1.
    
    Se agrega el 431 a la dirección 1.
    
    Operaciones: L5, L1, E1.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 498 | 222 |
    | 1 | 431 |  |
    | 2 |  |  |
    | 3 | 729 | 885 |
    | 4 |  |  |
    | 5 | 347 | 113 |
    
    ### +593:
    
    593 mod 6 = 5.
    
    Se trata de agregar el 593 a la dirección 5, no se puede porque ya hay 2 claves, hay overflow, se aplica la segunda función de hash.
    
    593 mod 5 + 1 = 4.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 5 + 4 = 3.
    
    Se trata de agregar el 593 a la dirección 3, no se puede porque ya hay 2 claves, hay overflow, se aplica la segunda función de hash.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 3 + 4 = 1.
    
    Se agrega el 593 a la dirección 1.
    
    Operaciones: L5, L3, L1, E1.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 498 | 222 |
    | 1 | 431 | 593 |
    | 2 |  |  |
    | 3 | 729 | 885 |
    | 4 |  |  |
    | 5 | 347 | 113 |
    
    ### +709:
    
    709 mod 6 = 1.
    
    Se trata de agregar el 709 a la dirección 1, no se puede porque ya hay 2 claves, hay overflow, se aplica la segunda función de hash.
    
    709 mod 5 + 1 = 5.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 1 + 5 = 0.
    
    Se trata de agregar el 709 a la dirección 0, no se puede porque ya hay 2 claves, hay overflow, se aplica la segunda función de hash.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 0 + 5 = 5.
    
    Se trata de agregar el 709 a la dirección 5, no se puede porque ya hay 2 claves, hay overflow, se aplica la segunda función de hash.
    
    Se suma a la dirección base el resultado de la segunda función de hash. 5 + 5 = 4.
    
    Se agrega 709 a la dirección 4.
    
    Operaciones: L1, L0, L5, L4, E4.
    
    | Dirección | Clave | Clave |
    | --- | --- | --- |
    | 0 | 498 | 222 |
    | 1 | 431 | 593 |
    | 2 |  |  |
    | 3 | 729 | 885 |
    | 4 | 709 |  |
    | 5 | 347 | 113 |
- **16:** Para las siguientes claves, realice el proceso de dispersión mediante el método de
hashing extensible, sabiendo que cada nodo tiene capacidad para dos registros. El número
natural indica el orden de llegada de las claves.  Se debe mostrar el estado del archivo
para cada operación. Justifique brevemente ante colisión y desborde los pasos que realiza.
    
    
    | 1 | Darín | 00111111 | 2 | Alterio | 11110100 |
    | --- | --- | --- | --- | --- | --- |
    | 3 | Sbaraglia | 10100101 | 4 | De la Serna | 01010111 |
    | 5 | Altavista | 01101011 | 6 | Grandinetti | 10101010 |
    
    ### Darín:
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20160.png)
    
    ### Alterio:
    
    Hay colisión sin overflow. Se agrega a la dirección.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20161.png)
    
    ### Sbaraglia:
    
    Hay colisión con overflow. Se incrementa en uno el valor asociado a la dirección saturada. Se genera una nueva dirección con el mismo valor asociado a la dirección saturada. 
    
    La tabla no dispone de entradas suficientes para direccionar la nueva dirección. Se duplica la cantidad de celdas de la tabla y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20162.png)
    
    ### De la Serna:
    
    Hay colisión con overflow. Se incrementa en uno el valor asociado a la dirección saturada. Se genera una nueva dirección con el mismo valor asociado a la dirección saturada.
    
    La tabla no dispone de entradas suficientes para direccionar la nueva dirección. Se duplica la cantidad de celdas de la tabla y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20163.png)
    
    ### Altavista:
    
    Hay colisión con overflow. Se incrementa en uno el valor asociado a la dirección saturada. Se genera una nueva dirección con el mismo valor asociado a la dirección saturada.
    
    La tabla no dispone de entradas suficientes para direccionar la nueva dirección. Se duplica la cantidad de celdas de la tabla y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20164.png)
    
    ### Grandinetti:
    
    Hay colisión sin overflow. Se agrega a la dirección 010.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20165.png)
    
- **17:** Realice el proceso de dispersión mediante el método de hashing extensible, sabiendo
que cada registro tiene capacidad para dos claves. El número natural indica el orden de
llegada de las mismas. Se debe mostrar el estado del archivo para cada operación.
Justifique brevemente ante colisión y desborde los pasos que realiza.
    
    
    | 1 | Buenos Aires | …1001 | 2 | San Juan | …0100 |
    | --- | --- | --- | --- | --- | --- |
    | 3 | Entre Ríos | …1110 | 4 | Corrientes | …0010 |
    | 5 | San Luis | …0101 | 6 | Tucumán | …0111 |
    | 7 | Río Negro | …0011 | 8 | Jujuy | …1111 |
    
    ### Buenos Aires:
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20166.png)
    
    ### San Juan:
    
    Hay colisión. Se agrega a la dirección.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20167.png)
    
    ### Entre Ríos:
    
    Hay colisión con overflow. Se incrementa en uno el valor de la dirección saturada. Se genera una nueva dirección con el mismo valor de la dirección saturada.
    
    La tabla en memoria no tiene las entradas suficientes para las direcciones en disco. Se duplica la cantidad de entradas de la tabla y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20168.png)
    
    ### Corrientes:
    
    Hay colisión con overflow. Se incrementa en uno el valor de la dirección saturada. Se genera una nueva dirección con el mismo valor de la dirección saturada.
    
    La tabla en memoria no tiene las entradas suficientes para las direcciones en disco. Se duplica la cantidad de entradas de la tabla y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20169.png)
    
    ### San Luis:
    
    Hay colisión sin overflow. Se agrega a la dirección 01.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20170.png)
    
    ### Tucumán:
    
    Hay colisión con overflow. Se incrementa en uno el valor de la dirección saturada. Se genera una nueva dirección con el mismo valor de la dirección saturada. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20171.png)
    
    ### Río Negro:
    
    Hay colisión sin overflow. Se agrega a la dirección 11.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20172.png)
    
    ### Jujuy:
    
    Hay colisión con overflow. Se incrementa en uno el valor de la dirección saturada. Se genera una nueva dirección con el mismo valor de la dirección saturada.
    
    La tabla en memoria no tiene las entradas suficientes para las direcciones en disco. Se duplica la cantidad de entradas de la tabla  y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20173.png)
    
- **18:** Para las siguientes claves, realice el proceso de dispersión mediante el método de
hashing extensible, sabiendo que cada nodo tiene capacidad para dos registros. El número
natural indica el orden de llegada de las claves.  Se debe mostrar el estado del archivo
para cada operación. Justifique brevemente ante colisión y desborde los pasos que realiza.
    
    
    | 1 | Borges | 11110100 | 2 | Sabato | 00111111 |
    | --- | --- | --- | --- | --- | --- |
    | 3 | Cortázar | 01010111 | 4 | Lugones | 10100101 |
    | 5 | Casares | 10101010 | 6 | Walsh | 01101011 |
    
    ### Borges:
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20174.png)
    
    ### Sabato:
    
    Hay colisión sin overflow. Se agrega a la dirección.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20175.png)
    
    ### Cortázar:
    
    Hay colisión con overflow. Se incrementa el valor de la dirección saturada y se genera una nueva dirección con el mismo valor de la dirección saturada.
    
    La tabla en memoria no tiene las entradas suficientes para las direcciones en disco. Se duplica la cantidad de entradas de la tabla y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20176.png)
    
    ### Lugones:
    
    Hay colisión con overflow. Se incrementa el valor de la dirección saturada y se genera una nueva dirección con el mismo valor de la dirección saturada.
    
    La tabla en memoria no tiene las entradas suficientes para las direcciones en disco. Se duplica la cantidad de entradas de la tabla y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20177.png)
    
    ### Casares:
    
    Hay colisión sin overflow. Se agrega a la dirección 10.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20178.png)
    
    ### Walsh:
    
    Hay colisión con overflow. Se incrementa el valor de la dirección saturada y se genera una nueva dirección con el mismo valor de la dirección saturada.
    
    La tabla en memoria no tiene las entradas suficientes para las direcciones en disco. Se duplica la cantidad de entradas y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20179.png)
    
- **19:** Para las siguientes claves, realice el proceso de dispersión mediante el método de
hashing extensible, sabiendo que cada nodo tiene capacidad para dos registros. El
número natural indica el orden de llegada de las claves.  Se debe mostrar el estado del
archivo para cada operación. Justifique brevemente ante colisión y desborde los pasos
que realiza.
    
    
    | 1 | Guillermo .B | 01100011 | 4 | Gomez | 00000001 |
    | --- | --- | --- | --- | --- | --- |
    | 2 | Gustavo .B | 01010110 | 5 | Sosa | 11110100 |
    | 3 | Enria | 00110101 | 6 | Guli | 00101000 |
    
    ### Guillermo .B:
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20180.png)
    
    ### Gustavo .B:
    
    Hay colisión sin overflow. Se agrega en la dirección.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20181.png)
    
    ### Enria:
    
    Hay colisión con overflow. Se incrementa en uno el valorasociado a la dirección saturada, y se genera una nueva dirección con el mismo valor de la dirección saturada.
    
    La tabla en memoria no tiene suficientes entradas para las direcciones en disco. Se duplica la cantidad de entradas y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20182.png)
    
    ### Gomez:
    
    Hay colisión con overflow. Se incrementa en uno el valorasociado a la dirección saturada, y se genera una nueva dirección con el mismo valor de la dirección saturada.
    
    La tabla en memoria no tiene suficientes entradas para las direcciones en disco. Se duplica la cantidad de entradas y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20183.png)
    
    ### Sosa:
    
    Hay colisión sin overflow. Se agrega a la dirección 00.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20184.png)
    
    ### Guli:
    
    Hay colisión con overflow. Se incrementa en uno el valorasociado a la dirección saturada, y se genera una nueva dirección con el mismo valor de la dirección saturada. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20185.png)
    
- **20:** Para las siguientes claves, realice el proceso de dispersión mediante el método de
hashing extensible, sabiendo que cada nodo tiene capacidad para dos registros. El
número natural indica el orden de llegada de las claves.  Se debe mostrar el estado del
archivo para cada operación. Justifique brevemente ante colisión y desborde los pasos
que realiza.
    
    
    | 1 | Verón | 01100010 | 4 | Sosa | 10001000 |
    | --- | --- | --- | --- | --- | --- |
    | 2 | Braña | 01010111 | 5 | Pavone | 11110101 |
    | 3 | Calderón | 00110100 | 6 | Andújar | 00101001 |
    
    ### Verón:
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20186.png)
    
    ### Braña:
    
    Hay colisión sin overflow. Se agrega en la dirección.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20187.png)
    
    ### Calderón:
    
    Hay colisión con overflow. Se incrementa en uno el valor asociado a la dirección saturada, y se genera una nueva dirección con el mismo valor de la dirección saturada.
    
    La tabla en memoria no tiene suficientes entradas para las direcciones en disco. Se duplica la cantidad de entradas y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20188.png)
    
    ### Sosa:
    
    Hay colisión con overflow. Se incrementa en uno el valor asociado a la dirección saturada, y se genera una nueva dirección con el mismo valor de la dirección saturada.
    
    La tabla en memoria no tiene suficientes entradas para las direcciones en disco. Se duplica la cantidad de entradas y el valor asociado a la tabla se incrementa en uno. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20189.png)
    
    ### Pavone:
    
    Hay colisión sin overflow. Se agrega en la dirección 01.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20190.png)
    
    ### Andújar:
    
    Hay colisión con overflow. Se incrementa en uno el valor asociado a la dirección saturada, y se genera una nueva dirección con el mismo valor de la dirección saturada. Se redispersan las claves involucradas.
    
    ![Untitled](FOD%2063b469800e42486fa5bd69706b45e900/Untitled%20191.png)