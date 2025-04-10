FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx openssl vim procps 
                    
RUN mkdir -p /etc/nginx/snippets/ && mkdir -p /var/run/nginx/ && mkdir -p /var/www/html/wordpress

RUN chmod 755 -R /var/www/html/wordpress && chown -R www-data:www-data /var/www/html/

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ./tools/script.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/script.sh

CMD ["/usr/local/bin/script.sh"]