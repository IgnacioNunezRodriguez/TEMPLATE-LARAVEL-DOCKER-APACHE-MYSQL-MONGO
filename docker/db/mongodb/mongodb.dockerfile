FROM mongo:latest
COPY ./db/mongodb/loadFiles.sh /docker-entrypoint-initdb.d/
EXPOSE 27017