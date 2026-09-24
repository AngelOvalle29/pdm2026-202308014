# Laboratorio - Marcador deportivo

Programación de Dispositivos Móviles - UMES Quetzaltenango

Estudiante: 
Carné: 

## Descripción

Hice un marcador para dos equipos. Cada equipo tiene botones de +1 y -1, los
puntos no pueden bajar de cero y abajo sale un mensaje que dice si hay empate
o qué equipo va ganando. El equipo que va ganando se pone en verde y cuando
hay empate los dos quedan en gris. El botón Reiniciar regresa todo a 0-0.

## Capturas

Equipo ganando:

![ganando](capturas/ganando.png)

Empate:

![empate](capturas/empate.png)

## Pregunta: ¿Qué hace setState?

Cuando presiono un botón, setState cambia el valor de los puntos y le avisa a
Flutter que el estado cambió, entonces Flutter vuelve a ejecutar el build y la
pantalla se actualiza con los puntos nuevos, el mensaje y los colores.

Si cambio los puntos sin llamar a setState, la variable sí cambia pero la
pantalla no se actualiza, porque Flutter no sabe que tiene que redibujar.
Se seguiría viendo el número anterior aunque el valor real ya sea otro.