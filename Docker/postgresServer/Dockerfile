FROM ubuntu

MAINTAINER akira 

RUN apt-get update && \
    apt-get install -y postgresql 
#VOLUME /var/lib/postgresql/9.5/main
USER postgres
#RUN mkdir ~/pgsql
#RUN /usr/lib/postgresql/9.5/bin/initdb -D ~/pgsql
RUN rm -rf /var/lib/postgresql/9.5/main/* &&\
    /usr/lib/postgresql/9.5/bin/initdb -E UTF-8 -D /var/lib/postgresql/9.5/main/ &&\
    /etc/init.d/postgresql start &&\
    psql --command "CREATE ROLE engenius LOGIN CREATEDB PASSWORD 'engenius';" &&\ 
    echo "local all  postgres                      peer" >> /etc/postgresql/9.5/main/pg_hba.conf &&\
    echo "local all  all                           trust" >> /etc/postgresql/9.5/main/pg_hba.conf &&\
    echo "host  all  all         127.0.0.1/32      md5" >> /etc/postgresql/9.5/main/pg_hba.conf &&\
    echo "host  all  all         ::1/128           md5" >> /etc/postgresql/9.5/main/pg_hba.conf &&\
    echo "host  all  postgres    0.0.0.0/0         reject" >> /etc/postgresql/9.5/main/pg_hba.conf &&\
    echo "host  all  all         0.0.0.0/0         md5" >> /etc/postgresql/9.5/main/pg_hba.conf &&\
    echo "listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf &&\
    /etc/init.d/postgresql reload

EXPOSE 5432
#CMD ["/etc/init.d/postgresql", "start"]
#CMD ["/usr/lib/postgresql/9.5/bin/postmaster", "-D", "/etc/postgresql/9.5/main/"]  

#VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

CMD ["/usr/lib/postgresql/9.5/bin/postgres", "-D", "/var/lib/postgresql/9.5/main", "-c", "config_file=/etc/postgresql/9.5/main/postgresql.conf"]
