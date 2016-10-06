# 03 Network
echo "Setting /etc/resolv.conf"
sudo sed -i "2a options single-request-reopen" /etc/resolv.conf
echo "Setting iptables stop"
sudo service iptables stop >/dev/null 2>&1
sudo chkconfig iptables off

# 04 Web Server
echo "Installing Apache"
sudo yum install -y httpd >/dev/null 2>&1
sudo chkconfig httpd on

# 07 epel & remi repo add
echo "Adding epel & remi repo"
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm >/dev/null 2>&1
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm >/dev/null 2>&1
sudo rpm -Uvh epel-release-6-8.noarch.rpm >/dev/null 2>&1
sudo rpm -Uvh remi-release-6.rpm >/dev/null 2>&1
sudo sed -i "6s/enabled=1/enabled=0/g" /etc/yum.repos.d/epel.repo

# 08 php
echo "Installing php"
sudo yum --enablerepo=remi install -y php php-devel php-mysql php-mbstring php-gd >/dev/null 2>&1
# sudo vi /etc/php.ini
sudo sed -i "s/;error_log = syslog/error_log = \/var\/log\/php.log/g" /etc/php.ini
sudo sed -i "s/;mbstring.language = Japanese/mbstring.language = Japanese/g" /etc/php.ini
sudo sed -i "s/;mbstring.internal_encoding = EUC-JP/mbstring.internal_encoding = UTF-8/g" /etc/php.ini
sudo sed -i "s/;mbstring.http_input = auto/mbstring.http_input = auto/g" /etc/php.ini
sudo sed -i "s/;mbstring.detect_order = auto/mbstring.detect_order = auto/g" /etc/php.ini
sudo sed -i "s/expose_php = On/expose_php = Off/g" /etc/php.ini
sudo sed -i "s/;date.timezone =/date.timezone = Asia\/Tokyo/g" /etc/php.ini

# 09 mysql
echo "Installing MySQL"
sudo yum install -y --enablerepo=remi mysql-server >/dev/null 2>&1
# sudo vi /etc/my.cnf
VAR="character_set_server=utf8\n\
default-storage-engine=InnoDB\n\
innodb_file_per_table\n\
[mysql]\n\
default-character-set=utf8\n\
[mysqldump]\n\
default-character-set=utf8\n\
"
sudo sed -i "4a $VAR" /etc/my.cnf

# Start Service
echo "Start Apache & MySQL"
sudo service httpd start >/dev/null 2>&1
sudo service mysqld start >/dev/null 2>&1

# /usr/bin/mysql_secure_installation
echo "mysql_secure_installation"
SQL="UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;"
mysql -u root -e "$SQL"

sudo chkconfig mysqld on

# appendix WordPress
echo "Installing Wordpress"
SQL="CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO root@localhost IDENTIFIED BY 'root';
FLUSH PRIVILEGES;"
mysql -u root -proot -e "$SQL"

wget http://ja.wordpress.org/latest-ja.tar.gz >/dev/null 2>&1
tar -xzf latest-ja.tar.gz -C /var/www/html >/dev/null 2>&1

sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
# sudo vi wp-config.php
sudo sed -i "s/define('DB_NAME', 'database_name_here');/define('DB_NAME', 'wordpress');/g" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/define('DB_USER', 'username_here');/define('DB_USER', 'root');/g" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/define('DB_PASSWORD', 'password_here');/define('DB_PASSWORD', 'root');/g" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/define('WP_DEBUG', false);/define('WP_DEBUG', true);\\ndefine('FS_METHOD','direct');/g" /var/www/html/wordpress/wp-config.php

# appendix phpMyAdmin
sudo yum -y install unzip >/dev/null 2>&1
echo "Installing phpMyAdmin"
wget http://downloads.sourceforge.net/project/phpmyadmin/phpMyAdmin/4.0.7/phpMyAdmin-4.0.7-all-languages.zip >/dev/null 2>&1
unzip phpMyAdmin-4.0.7-all-languages.zip -d /var/www/html >/dev/null 2>&1
mv /var/www/html/phpMyAdmin-4.0.7-all-languages /var/www/html/phpmyadmin

# chown
sudo chown -R vagrant:vagrant /var/www/html
sudo chown -R apache:apache /var/www/html/wordpress

# sudo touch /etc/httpd/conf.d/wordpress.conf
# VAR="alias \/wordpress \/var\/www\/html\/wordpress\n"
# sudo sed -i "s/$/$VAR/g" /etc/httpd/conf.d/wordpress.conf
# echo "alias /wordpress /var/www/html/wordpress\n" >> /etc/httpd/conf.d/wordpress.conf

# Setting synced_folder
# echo "Setting synced_folder"
# sudo rm -rf /var/www/html
# sudo ln -fs /vagrant /var/www/html



# 10 python
# echo "Installing Python"
# wget http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz >/dev/null 2>&1
# tar xzf Python-2.7.5.tgz >/dev/null 2>&1
# sudo Python-2.7.5/configure --enable-shared --with-threads >/dev/null 2>&1
# sudo make >/dev/null 2>&1
# sudo make install >/dev/null 2>&1
# sudo cp libpython2.7.so libpython2.7.so.1.0 /usr/lib
# sudo /sbin/ldconfig
# source ~/.bash_profile

# 11 ruby
# echo "Installing Ruby"
# sudo yum -y install git >/dev/null 2>&1
# git clone https://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv >/dev/null 2>&1
# echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile
# echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile
# exec $SHELL -l
# git clone https://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build >/dev/null 2>&1
# rbenv install 2.0.0-p247 >/dev/null 2>&1
# rbenv rehash
# rbenv global 2.0.0-p247

# 12 Ruby on Rails
# echo "Installing Ruby on Rails"
# gem update --system >/dev/null 2>&1
# gem install rails --no-ri --no-rdoc >/dev/null 2>&1
# rbenv rehash
