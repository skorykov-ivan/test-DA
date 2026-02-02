FROM postgres:13

ENV POSTGRES_USER=iv_sk_de_course
ENV POSTGRES_PASSWORD=sec_q_pass_123
ENV POSTGRES_DB=de_db

RUN mkdir -p /var/lib/postgresql/DE_course /var/lib/postgresql/iv_sk_personal

COPY init.sql /docker-entrypoint-initdb.d/

VOLUME ["/var/lib/postgresql/DE_course", "/var/lib/postgresql/iv_sk_personal"]

EXPOSE 5432