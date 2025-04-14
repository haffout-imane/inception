#!/bin/bash


# Avoid reinstalling WordPress if it’s already set up.
# If the configuration file of WordPress exists, so wordPress is already set up.
if [ -f "/var/www/wordpress/wp-config.php" ]; then
    exec "$@"
    exit 0
    #The script just runs the default command and exits early
fi


# if not, Check if WordPress command line interface is Already Installed (to install WordPress using it instead of the web interface)
if [ ! -f "/usr/local/bin/wp" ]; then
    #Downloads the wp command-line tool.
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    #Adds execution permissions.
    chmod +x wp-cli.phar
    #Puts it in /usr/local/bin so it's globally available.
    mv wp-cli.phar /usr/local/bin/wp
fi

# ensure the WordPress directory exists (the one where WordPress will be installed)
if [ ! -d "/var/www/html/wordpress" ]; then
    #if note, create one;
    mkdir -p /var/www/html/wordpress
fi

cd /var/www/html/wordpress
rm -rf /var/www/html/wordpress/*

# download the latest version of WordPress
wp core download --allow-root
# core is a command to download the latest version of WordPress, --allow-root is used to run the command as root (because we are running the script as root)

# create a wp-config.php file with the database settings (WordPress needs database credentials to store website data)
wp config create --allow-root \
                 --dbname="$DB_NAME" \
                 --dbuser="$DB_USER" \
                 --dbpass="$DB_PASSWORD" \
                 --dbhost="mariadb:3306" \
                 --path="/var/www/html/wordpress/"

# install WordPress
wp core install --allow-root \
                --url="$WP_URL" \
                --title="$WP_TITLE" \
                --admin_user="$WP_ADMIN_USER" \
                --admin_password="$WP_ADMIN_PASSWORD" \
                --admin_email="$WP_ADMIN_EMAIL"

# creating an additional user
wp user create --allow-root \
               "$WP_USER" \
               "$WP_USER_EMAIL" \
               --role="$WP_USER_ROLE" \
               --user_pass="$WP_USER_PASSWORD"

# role is the user role (admin, editor, author, contributor, subscriber)

chmod -R g+rw /var/www/html
chown -R www-data:www-data /var/www/html

exec "$@"
