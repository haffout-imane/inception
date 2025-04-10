FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y mariadb-server vim procps

COPY ./tools/script.sh /usr/local/bin/

RUN  chmod +x /usr/local/bin/script.sh

RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 

ENTRYPOINT ["/usr/local/bin/script.sh"]

CMD ["mysqld_safe"]