# Scripts de inicialización del MySQL local (Docker)

MySQL ejecuta automáticamente los archivos `.sql` de esta carpeta **solo la primera vez**
que se crea el volumen `mysql_data`, sobre la base `portafolio_bd`.

| Archivo | Contenido | ¿Se sube a GitHub? |
|---|---|---|
| `backup_portafolio.sql` | Respaldo real exportado desde TiDB Cloud (estructura + datos) | ❌ No (contiene datos sensibles; está en `.gitignore`) |

## Regenerar el respaldo desde TiDB

Desde la carpeta `evidencias/`, con tus credenciales en `tidb.cnf`:

```powershell
mysqldump --defaults-extra-file=tidb.cnf --skip-lock-tables --set-gtid-purged=OFF `
  --column-statistics=0 --no-tablespaces --skip-triggers --default-character-set=utf8mb4 `
  --hex-blob --result-file=docker/mysql/init/backup_portafolio.sql portafolio_bd
```

> No uses `--single-transaction` (TiDB falla con `SAVEPOINT sp does not exist`) ni `>`
> en PowerShell 5 (guarda en UTF-16 y MySQL no puede leerlo).

## Volver a cargar los datos

Los scripts no se re-ejecutan si el volumen ya existe. Para empezar de cero:

```powershell
docker compose down -v
docker compose up -d --build
```

Si no hay ningún `.sql` aquí (por ejemplo, en un clon nuevo), la app arranca igual y
Hibernate (`ddl-auto=update`) crea las tablas vacías.
