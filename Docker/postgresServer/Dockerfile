FROM ubuntu-upstart

MAINTAINER akira 

RUN apt-get update && \
    apt-get install -y postgresql 
#VOLUME /var/lib/postgresql/9.3/main
USER postgres
#RUN mkdir ~/pgsql
#RUN /usr/lib/postgresql/9.3/bin/initdb -D ~/pgsql
RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE ROLE user01 LOGIN CREATEDB PASSWORD '0519akira';" &&\
    psql --command "CREATE DATABASE FakeCookPad OWNER user01;" &&\ 
    echo "local all  postgres                      peer" >> /etc/postgresql/9.3/main/pg_hba.conf &&\
    echo "local all  all                           trust" >> /etc/postgresql/9.3/main/pg_hba.conf &&\
    echo "host  all  all         127.0.0.1/32      md5" >> /etc/postgresql/9.3/main/pg_hba.conf &&\
    echo "host  all  all         ::1/128           md5" >> /etc/postgresql/9.3/main/pg_hba.conf &&\
    echo "host  all  postgres    0.0.0.0/0         reject" >> /etc/postgresql/9.3/main/pg_hba.conf &&\
    echo "host  all  all         0.0.0.0/0         md5" >> /etc/postgresql/9.3/main/pg_hba.conf &&\
    echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf &&\
    /etc/init.d/postgresql reload

EXPOSE 5432
#CMD ["/etc/init.d/postgresql", "start"]
#CMD ["/usr/lib/postgresql/9.3/bin/postmaster", "-D", "/etc/postgresql/9.3/main/"]  

#VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]


