FROM postgres:17.2

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=mysecretpassword
ENV POSTGRES_DB=mydatabase

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432