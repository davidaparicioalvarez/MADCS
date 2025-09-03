
# MADCS - Manufacturing Automated Data Capture System

Extensión AL para Microsoft Dynamics 365 Business Central desarrollada por David Aparicio Álvarez en APAWARE.

## Objetivo de la aplicación

Esta extensión está diseñada para digitalizar y optimizar la captura de datos generados en planta sobre las órdenes de producción. Permite registrar y gestionar:

- Información de órdenes de producción (inicio, avance, finalización)
- Consumo de materiales y resultados de producción
- Tiempos de fabricación y de trabajo (inicio, pausas, fin)
- Procesos de picking y movimientos de almacenamiento

La solución integra estos datos en tiempo real con los módulos estándar de Business Central, mejorando la trazabilidad, el control y la eficiencia de los procesos productivos.

## Estructura del repositorio

La estructura del repositorio está organizada para facilitar el desarrollo, pruebas, documentación y despliegue de la extensión AL:

- **Raíz**: Metadatos y configuración de la solución (`app.json`, `LICENSE`, `README.md`, `.gitignore`, `al.code-workspace`).
- **.github/**: Instrucciones para GitHub Copilot y flujos de trabajo.
- **app/**: Código fuente principal AL, organizado por tipo de objeto:
	- `Codeunits/`, `Pages/`, `PageExtensions/`, `Reports/`, `ReportExtensions/`, `Tables/`, `TableExtensions/`, `Enums/`, `EnumExtensions/`, `Interfaces/`, `Permissions/`, `Queries/`, `dotnet/`.
- **test/**: Estructura de pruebas para AL:
	- `TestCodeunits/`, `TestLibraries/`, `TestPages/` (listas para pruebas unitarias, de integración y de interfaz).
- **docs/**: Documentación del proyecto (ejemplo: `architecture.md`).
- **res/**: Recursos, como imágenes de logotipo (`logo/`).
- **scripts/**: Scripts de automatización (ejemplo: `deploy.ps1`).
- **Translations/**: Archivos de traducción XLF.

La mayoría de las carpetas están preparadas para facilitar la escalabilidad y el mantenimiento del desarrollo AL siguiendo las mejores prácticas.

