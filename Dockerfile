FROM ubuntu
RUN apt-get update
RUN apt-get -y install rsyslog
RUN apt-get install -y tzdata -y
RUN ln -fs /usr/share/zoneinfo/Europe/Budapest /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install mc -y
RUN apt-get install apache2 -y
RUN apt-get install php-ssh2 -y
RUN apt-get install php7.1 -y
RUN apt-get install php-mysql -y
RUN apt-get install php7.2-ldap php7.2-xml php7.2-zip -y
RUN apt-get install libapache2-mod-php -y
RUN apt-get install curl php-cli php-mbstring git unzip -y
RUN apt-get install mysql-client -y
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
COPY .bashrc /root/.bashrc
COPY apache.conf /etc/apache2/sites-available/apache.conf
RUN curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash
RUN apt-get update
RUN apt-get install php7.2-phalcon
RUN git clone https://github.com/phalcon/phalcon-devtools.git /opt/phalcon-devtools
RUN ln -s /opt/phalcon-devtools/phalcon /usr/bin/phalcon
RUN chmod ugo+x /usr/bin/phalcon
WORKDIR /var/www/
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
