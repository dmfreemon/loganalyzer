FROM ubuntu:14.04

# Install dependencies

RUN apt-get -qy update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy apache2 php5 vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Get application source code

COPY loganalyzer/src/ /usr/share/loganalyzer/
COPY loganalyzer/etc/ /etc/loganalyzer/

# Configure Apache

RUN echo "RedirectMatch ^/$ /loganalyzer/" >>/etc/loganalyzer/apache.conf

RUN ln -sf /etc/loganalyzer/apache.conf /etc/apache2/conf-available/loganalyzer.conf

RUN sed -i 's!<Directory .*>!<Directory /usr/share/loganalyzer>!' /etc/loganalyzer/apache.conf
RUN sed -i 's!Alias /loganalyzer .*!Alias /loganalyzer /usr/share/loganalyzer!' /etc/loganalyzer/apache.conf

RUN a2enconf loganalyzer

# Configure Application

RUN ln -sf /etc/loganalyzer/config.php /usr/share/loganalyzer/config.php

RUN sed -i 's!/var/log!/mnt/log!' /etc/loganalyzer/config.php

# Set and Launch

ENV TERM xterm

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]




#chown -R www-data:www-data /app
#MAINTAINER Regis <regis@whats.my.com>
#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
#ENV APACHE_LOG_DIR /var/log/apache2
#RUN /usr/sbin/php5enmod mcrypt
#RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
#    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
#ENV ALLOW_OVERRIDE **False**
## Add image configuration and scripts
#ADD run.sh /run.sh
#RUN chmod 755 /*.sh
#WORKDIR /app
#CMD ["/run.sh"]

