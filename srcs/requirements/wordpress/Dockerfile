#this uses Debian Buster (Debian 10) as the base image for the container.
FROM debian:buster 

#Updates and upgrades the system packages.
#Install PHP(php-fpm), PHP extensions(php-mysql php-zip php-redis), and Utilities(curl vim).
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y php-fpm php-mysql php-zip php-redis curl vim wget mariadb-server

#Changes the listen directive in the config file to listen on port 9000 instead of a Unix socket.
RUN sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
RUN mkdir -p /run/php

COPY ./tools/script.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["/usr/local/bin/script.sh"]

CMD ["php-fpm7.3", "-F"]      