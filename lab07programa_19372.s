/*UNIVERSIDAD DEL VALLE DE GUATEMALA*/
/*BRYANN EDUARDO ALFARO HERNANDEZ 19372*/
/*LABORATORIO 7 Menu de notas de semestre y despliegue de nombre*/
/*REFERENCIA: CLASE VIRTUAL Y ARCHIVOS DE CLASE*/
/*ORGANIZACION DE COMPUTADORAS Y ASSEMBLER*/
/*https://www.youtube.com/watch?v=voL9JFNx7uA*/

.text
.align 2
.global main
.type main,%function

main:

	stmfd sp!, {lr}	/* SP = R13 link register */
	/* valor1 */
	
	mov r4, #0 /*indice del vector*/
	ldr r10,=notas /* arreglo nota vacia*/
	
	and r7, #0

inicio:
	
	/*PRESENTACION DE OPCIONES */
	ldr r0, =bienvenida
	bl puts
	ldr r0, =opcion1
	bl puts
	ldr r0, =opcion2
	bl puts
	ldr r0, =opcion3
	bl puts
	ldr r0, =opcion4
	bl puts
	ldr r0, =salirPrograma
	bl puts
	
	/*INGRESO DE OPCION*/
	ldr r0,=entrada
	ldr r1,=a
	bl scanf
	
	/*COMPARAR OPCION INGRESADA PARA IR A ETIQUETA CORRESPONDIENTE*/
	
	ldr r1,=a
	ldr r1,[r1]
	cmp r1,#1
	beq tarea1 /*Ir a tarea 1*/
	cmp r1,#2
	beq tarea2/*Ir a tarea 2*/
	cmp r1,#3
	beq tarea3/*Ir a tarea 3*/
	cmp r1,#4
	beq tarea4 /*Ir a tarea 4*/
	cmp r1, #5
	beq salida /*Salir del programa*/
	
/*REALIZACION DE TAREAS ELEGIDAS*/
tarea1:
	ldr r0, =ingresoNota /*Mensaje para que ingrese nota*/
	bl puts
	
	ldr r0,=entrada /*Escanear valor del arreglo*/
	ldr r1,=b
	bl scanf
	
	add r4,r4,#1
	ldr r1,=b
	ldr r1,[r1]
	
	str r1,[r10],#4	/*Settear valor a primer punto del array*/
	
	cmp r4,#6		@contador<N?
	
	bne tarea1		@si..ir a tarea1
	
	mov r4, #0
	ldr r10, =notas
	
	@Impresion del vector
	imprime:
		ldr r0,=formato
		ldr r1,[r10],#4
		bl printf
		add r4,r4,#1
		cmp r4,#6
		bne imprime
	
	ldr r10, =notas /*TRAER ARREGLO CON DATOS */
	b inicio /*volver al menu*/

tarea2:
	
	ldr r1, [r10], #4
	
	add r7, r7, r1 /*sumar valor para acumular*/
	add r5, r5 , #1 /*contador*/
	cmp r5, #6  /*Comparar si r5 ya es 6*/
	
	bne tarea2
	
	mov r5, #0
	mov r1, r7
	mov r4, #6
	
	/*Division por metodo de resta continua*/
	resta:
		sub r1, r1, r4
		add r5, r5, #1
		cmp r1, #0
		bgt resta
	
	ldr r0, =promedio
	mov r1, r5
	bl printf
	
	b inicio

/*ESTO AUN PENDIENTE*/	
tarea3:
	
	ldr r0, =ingresoNombre
	bl puts
	
	ldr r0, =formatoNombre  /*Ingreso de nombre*/
	ldr r1, =nombreIngreso
	bl scanf
	
	ldr r0, =pruebaNombre /*Mostrar que si lo imprima */
	ldr r1, =nombreIngreso
	bl printf
	
	ldr r0, =espacio
	bl puts
	
	b inicio
	
tarea4:
	ldr r0, =estas4
	bl puts
	b inicio
	
salida:
	/* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

/*SECCION DE DATOS*/
.data
.align 2

/*MENU*/
bienvenida:  .asciz "Bienvenido al programa de laboratorio.\nPorfavor escoga una de las siguientes opciones:"
opcion1:     .asciz "1.Ingresar las notas de los 6 cursos asignados este semestre\nPorfavor ingrese datos enteros y sin espacios. Gracias."
opcion2:     .asciz "2.Calcular el promedio del semestre"
opcion3:     .asciz "3.Ingresar su nombre (Porfavor sin espacios y maximo de 10 letras)"
opcion4:     .asciz "4.Obtener su nombre en mayuscula"
salirPrograma:     .asciz "5. Salir del programa"

/*NOTAS*/
ingresoNota:       .asciz "Ingrese nota: "
notas:
	.word 0,0,0,0,0,0
contadorNotas:
	.word 6
	
caracterIngreso:   .asciz " %d\n"
letraIngresada:    .asciz "Tu opcion fue la: %d\n"

	
/*ESTO FUE PARA PRUEBAS DE QUE SI INGRESA A LA ETIQUETA */
estas3:            .asciz "Estas en 3"
estas4:            .asciz "Estas en 4"


a:
	.word 0
b:
	.word 0

/*Formatos*/	
entrada:    .asciz " %d"
formatoN:	.asciz "%d "
formato:	.asciz "%d\n"
numeroIngreso: .asciz "Tu numero es: %d\n"
promedio:   .asciz "Tu promedio es: %d\n"
ingresoNombre: .asciz "Ingrese su nombre (max 10 caracteres y sin espacio): "

/*Strings no se como*/
caracter: .string ""

formatoNombre: .asciz "%s" 
nombreIngreso: .space 100
pruebaNombre: .asciz "Name: %s\n"
espacio :     .asciz "Message"
	
	