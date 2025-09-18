# Tareas pendientes MADCS

## 1. Lista de órdenes de fabricación
- ~~Mostrar solo las órdenes que tienen asignado Orden de preparación OPL.~~
- ~~Mostrar el orden de preparación en la lista de órdenes de fabricación.~~
- ~~Mostrar Agrupación CM en la lista de órdenes de fabricación, junto con producto, descripción y cantidad.~~
- Identificación previa del usuario ADCS

## 2. Ventana de verificación - Fase2
- En la ventana para productos CR habría que hacer una ventana previa con la verificación inicial de esta órden en la que ponga los datos reales que ha servido de cada producto. Esta ventana podemos hacerla en fase 2. Ojo, hacerlo esto en otro sitio donde pueda ser anterior a las órdenes. La idea es que cada usuario que va a hacer una orden, verifique previamente lo que le han servido para su orden de fabricación.
- Si no se pasa por aquí no se peude hacer nada, siempre hay que hacer la verificación inicial.
- Esta ventana debería tener un log del usuario que lo hace

## 3. Ventana de tiempos
- Video quitar
- Terminar op quitar
- Hay tres acciones:
    - 1. Preparación
    - 2. Ejecución
    - 3. Limpieza
    - 4. Paros
- Nunca deben tener dos a la vez en una orden de fabricación.
- Se puede estar haciendo dos cosas en dos órdenes de fabricación a la vez.
- Si un usuario está en preparación e inicia ejecución, finaliza preparación automáticamente
- A una hora concreta se deben parar todas las ordenes. Igual es mejor hacerlo por usuarios y calendarios.
- El paro es un tiempo más que hay que tener en cuenta y que para la acción que está en marcha si es inhabilitante.
- Lo ideal sería que de un vistazo viera una lista de los usuarios que están en marcha en esta orden y su estado.
- No inhabilitante sería una opción separada en la que habría que indicar el tipo de incidencia
- Las incidencias van al log y no paran tiempos.
- Sí inhabilitante sería una opción separada en la que habría que indicar el tipo de paro.
- Los paros es un estado más y paran todos los tiempos de todos y marcan el usuario actual con avería.
- Ver Excel de Adrián.
- Esta ventana debería tener un log del usuario que lo hace
- 
### 3.1 Paros
- Hay una tabla de paros (códigos de paro).
- Hay averías que impiden continuar y otras que sí lo permiten (marcarlo en esta tabla como inhabilitante).
- Esta ventana debería tener un log del usuario que lo hace
- 
## 4. Medidas de calidad - Fase2
- Las fotos pasarlo a esta ventana. Añadir un acceso a una imagen con la colocación de preparación de la orden de fabricación, por producto a fabricar. Esas imagenes están metidas en la ruta, serían PDF que se mostrarían al pulsar en este botón.
- Medidas calidad es el fichero Excel "HCP*" que abra el Excel para ser rellenado.
- Añadir una lista de parámetros maquinaria, de forma que muestr los parámetros de maquinaria de cada centro de trabajo de la ruta.
- Esta ventana debería tener un log del usuario que lo hace
- 
## 5. Ventana de consumos
- **CR** significa consumo de restos.
- **Q. Prev** es la cantidad prevista, pero deberían tener también la cantidad inicial, sin aplicar los incrementos de cantidad en consumir por restos (**Q. Ori**).
- **Q. Prev** es la cantidad servida - la que has hecho con el picking.
- **Q. Rest** es la cantidad restos. Siempre 0 si sirve fábrica y si es consumo por restos tiene que abrir una ventana nueva donde aparecerán los diferentes lotes del producto a consumir y las cantidades pendientes de cada lote, junto con una cantidad que tienen que indicar ellos. Lo que sobra de cada lote después de hacer el picking es la cantidad restos.
    - Montar una ventana con Producto/Lote/Cantidad resto. El usuario indica lo que le ha sobrado y el sistema consume la diferencia entre picking y el resto indicado.
    - El orden es por FEFO.
- En lugar de CR indicar quién sirve OPL. CR marcado será para los que tenga quien sirve OPL Almacén.
- **Consumir Todo** debe aplicar a todos excepto los que son quien sirve OPL almacén (consumo por restos).
- **Alta Comp.** No se usa.
- **Inc Cantidad** no se usa.
- Las que ya están consumidas que se marquen en otro color.
- La marca de la izquierda no es necesaria.
- El campo **Con. Ruta** no lo usan.
- Cuando seleccionamos un producto con CR las opciones son "Consumir restos". Esta opción te muestra una ventana para indicar lo que te sobra. Estos van uno a uno. Cuando le den a Registrar. La cantidad que tiene que consumirse realmente es la diferencia entre lo previsto y lo que dicen que les sobra.
- Cuando seleccionamos un producto sin CR las opciones son Registrar o también la opción de poner Consumir y que les muestre los lotes de ese producto, esta vez la cantidad será la que van a consumir.
- La tabla adicional se va a mostrar en ambos casos, en caso de CR y en caso de no CR, con la misma funcionalidad.
- Esta ventana debería tener un log del usuario que lo hace
- 
## 6. Ventana de salidas
- Mostrar la línea de la orden de fabricación.
- Indicar cantidad, lote y ubicación
- No se indicarn rechazos
- Botón Registrar
- Indicar el operario que da la salida
- Esta ventana debería tener un log del usuario que lo hace