#!/bin/bash

prv_key="/etc/ssl/private/self-signed.key"
cs_request="/etc/ssl/certs/self-signed.csr"
certif="/etc/ssl/certs/self-signed.crt"
opt="/C=MO/L=Tetouan/O=1337/OU=Student/CN=ihaffout.42.fr"
openssl genpkey -algorithm RSA -out "$prv_key"
openssl req -new -key "$prv_key" -out "$cs_request" -subj "$opt"
openssl x509 -req -in "$cs_request" -signkey "$prv_key" -out "$certif"
echo "
ssl_certificate $certif;
ssl_certificate_key $prv_key;
" > /etc/nginx/snippets/self-signed.conf
nginx -g "daemon off;"