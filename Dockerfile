FROM ubuntu-apache2
MAINTAINER philippeassis/php7 PhilippeAssis <assis@philippeassis.com>

RUN apt-get install -y language-pack-en-base
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update -y

RUN apt-get install -y php7.0

RUN  apt-get install -y libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-json

RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php &&\
   php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '7228c001f88bee97506740ef0888240bd8a760b046ee16db8f4095c0d8d525f2367663f22a46b48d072c816e7fe19959') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" &&\
   php composer-setup.php --install-dir=bin --filename=composer &&\
   php -r "unlink('composer-setup.php');"

RUN bash &&\
   echo "alias www='cd /var/www/html'" >> ~/.bash_aliases &&\
   echo "alias gitall='git add --all && git commit -m \"commit\" && git push origin master'" >> ~/.bash_aliases &&\
   chmod -R 777 /var/www/html
