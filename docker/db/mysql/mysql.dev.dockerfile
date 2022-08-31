FROM mysql:latest
COPY ./sqlscript/*.sql /docker-entrypoint-initdb.d/
EXPOSE ${MYSQL_OUTPORT}