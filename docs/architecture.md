## Arquitectura del Proyecto

La aplicación **MADCS (Manufacturing Automated Data Capture System)** es una extensión desarrollada para Microsoft Dynamics 365 Business Central, orientada a la captura automatizada de datos en entornos de manufactura. Su objetivo principal es digitalizar y optimizar la recolección de información generada en planta, integrando estos datos directamente en el ERP para mejorar la visibilidad y el control de los procesos productivos.

### Componentes Principales

- **Tablas y Extensiones de Tablas**  
  Se crean nuevas tablas y extensiones sobre las tablas estándar de Business Central para almacenar información específica de la captura de datos de planta, como registros de órdenes de producción, consumos, tiempos y movimientos de almacén.

- **Páginas y Extensiones de Páginas**  
  Interfaz de usuario personalizada para operarios y supervisores, permitiendo la introducción y consulta de datos en tiempo real desde dispositivos en planta (PCs, tablets, terminales industriales) con un aspecto reducido y adaptado a resoluciones bajas y pantallas pequeñas.

- **Codeunits**  
  Lógica de negocio centralizada para procesar la información capturada, validar datos, calcular tiempos y gestionar integraciones con los módulos estándar de producción y almacén.

- **Enums y EnumExtensions**  
  Definición de listas de opciones para estados, tipos de operación, causas de parada, etc., adaptadas a los procesos de manufactura.

- **DotNet Interop**  
  Uso de ensamblados .NET para funcionalidades avanzadas, como integración con dispositivos externos o servicios web de planta (por ejemplo, mediante [`ServicePointManager`](app/dotnet/dotnet.al)).

- **Permisos**  
  Definición de permisos específicos para controlar el acceso a las funcionalidades según el rol del usuario (operario, supervisor, administrador).

### Flujos Funcionales

1. **Captura de Datos de Órdenes de Producción**  
   Los operarios registran el inicio, avance y finalización de órdenes de producción directamente desde la planta. Se asocian los consumos de materiales y los resultados de producción a cada orden.

2. **Registro de Consumos y Tiempos**  
   Se capturan los consumos de materiales y los tiempos de fabricación y trabajo (inicio, pausas, fin), permitiendo un control detallado de la eficiencia y trazabilidad.

3. **Gestión de Picking y Almacenamiento**  
   Los movimientos de picking y almacenamiento se registran en tiempo real, facilitando la integración con la gestión de inventario y asegurando la trazabilidad de los materiales.

4. **Integración con Business Central**  
   Todos los datos capturados se integran automáticamente con los módulos estándar de Business Central, permitiendo la actualización en tiempo real de las órdenes, inventarios y reportes.

### Seguridad y Control

- **Control de Acceso**  
  Mediante permisos y perfiles de usuario, se garantiza que cada operario o supervisor solo acceda a las funciones y datos que le corresponden.

- **Validaciones y Auditoría**  
  La lógica de negocio implementa validaciones para asegurar la calidad de los datos y mantiene registros de auditoría de las operaciones realizadas.

### Extensibilidad

La arquitectura modular permite adaptar y ampliar la solución para cubrir necesidades específicas de cada planta, integrando nuevos dispositivos, procesos o reportes según los requerimientos del cliente.

---

Para más detalles sobre la estructura de carpetas y objetos AL, consulta el [README.md](../README.md), donde se describe la organización del repositorio y el propósito de cada carpeta.