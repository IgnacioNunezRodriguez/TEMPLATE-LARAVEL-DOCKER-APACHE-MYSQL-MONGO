#TEMPLATE-LARAVEL-DOCKER-APACHE-MYSQL-MONGO

Desarrollaremos un sistema docker para publicar un proyecto Laravel con conexión a una base de datos mysql.
Tendremos dos entornos diferentes:
- Desarrollo (DEV)
  Este entorno contará con un script que montará el proyecto laravel en modo de desarrollo.
  - Laravel estará en modo desarrollo
  - El código estará alojado en el equipo host y se pasará mediante un volumen.
  - La carpeta de logs estará también en el equipo host mediante un volumen
- Producción (PROD)
  - El proyecto laravel estará en modo producción
  - El código estará alojado en la propia imagen creada
  - La carpeta de logs seguirá estando fuera del contendor.