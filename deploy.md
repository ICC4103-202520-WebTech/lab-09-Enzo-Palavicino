## Introducción
Se desplegó la aplicación Recipe Book en un droplet de DigitalOcean usando Kamal y contenedores Docker preparados para producción.

## Pasos realizados
1. Instalé Kamal en el proyecto y generé la configuración base.
2. Ajusté los placeholders en `config/deploy.yml` y preparé el archivo `Dockerfile`.
3. Subí las variables y secretos necesarios al servidor con Kamal.
4. Construí la imagen, la publiqué en Docker Hub y ejecuté `kamal deploy` para lanzar el contenedor.
5. Revisé los logs y el estado del servicio para confirmar que el contenedor quedó en ejecución.

## Problemas y soluciones
- Falta de `RAILS_MASTER_KEY`: cargar el valor correcto en `.kamal/secrets` antes del deploy.
- Error de conexión a la base de datos: validar `DATABASE_URL` y que la base acepte conexiones externas.
- Puerto cerrado en el droplet: abrir el puerto expuesto (por defecto 3000) en el firewall de DigitalOcean.

## IP de la aplicación
`138.68.22.139`
