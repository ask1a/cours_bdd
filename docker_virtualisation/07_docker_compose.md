## Onglet Connection
Host name/address : `postgres` -> C’est le nom du service défini dans ton `docker-compose.yml`.  
Comme pgAdmin et Postgres partagent le même réseau Docker, tu n’utilises pas `localhost` mais le nom du service.

Port : `5432`

Maintenance database : `ecommerce` -> C’est la base créée automatiquement par Postgres grâce à `POSTGRES_DB`.

Username : `postgres`

Password : `postgres` -> Ceux définis dans POSTGRES_USER et POSTGRES_PASSWORD
