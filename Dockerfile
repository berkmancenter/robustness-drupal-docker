# docker Drupal
#
# VERSION       0.2
# DOCKER-VERSION        0.4
FROM    ubuntu:latest
MAINTAINER Ricardo Amaro <mail@ricardoamaro.com>

RUN apt-get update

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl  

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql php-apc php5-gd php5-curl php5-memcache memcached mc curl
RUN DEBIAN_FRONTEND=noninteractive apt-get autoclean

# Make mysql listen on the outside
RUN sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf

RUN easy_install supervisor
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf
                                                           
# Install drush
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin
RUN mv /usr/local/bin/composer.phar /usr/local/bin/composer
RUN composer global require drush/drush:6.* 
RUN ln -s /.composer/vendor/bin/drush  /usr/local/bin

ADD ./robustness.mk /var/robustness.mk
 
# Retrieve drupal
RUN rm -rf /var/www/ ; cd /var; mkdir www; cd www; drush make /var/robustness.mk -y 
RUN chmod a+w /var/www/sites/default ; mkdir /var/www/sites/default/files ; chown -R www-data:www-data /var/www/

RUN chmod 755 /start.sh /etc/apache2/foreground.sh
EXPOSE 80
CMD ["/bin/bash", "/start.sh"]
