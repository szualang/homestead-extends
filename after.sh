#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

# 配置Composer使用中国镜像
composer config -g repo.packagist composer https://packagist.phpcomposer.com

# 使用 prestissimo 加速你的包安装
composer global require hirak/prestissimo

# 配置npm使用淘宝镜像，使用淘宝镜像有两种方式

# 方式一：只修改npm镜像地址为淘宝镜像地址
sudo npm config set registry " https://registry.npm.taobao.org "

# 方式二：安装淘宝的cnpm，使用方式和npm一样，只是安装时将npm命令修改为cnpm
# npm install -g cnpm --registry=https://registry.npm.taobao.org

if [ -f /home/vagrant/.xdebug ]
then
    echo "xdebug already installed."
    exit 0
fi
touch /home/vagrant/.xdebug

# 安装xdebug
cd ~
#download and uncompress
git clone git://github.com/xdebug/xdebug.git

cp -r xdebug xdebug7.2
#compile and make install
cd xdebug7.2

#编译7.2版本xdebug
phpize7.2
./configure --with-php-config=/usr/bin/php-config7.2 --enable-xdebug
sudo make
sudo make install

sudo mkdir -p /usr/local/php/xdebug/7.2
sudo cp ~/xdebug7.2/modules/xdebug.so /usr/local/php/xdebug/7.2/xdebug.so
cat>>xdebug.ini<<EOF
zend_extension="/usr/local/php/xdebug/7.2/xdebug.so"
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_port = 9000
xdebug.max_nesting_level = 512
EOF

sudo cp xdebug.ini /etc/php/7.2/mods-available/xdebug.ini
sudo ln -snf /etc/php/7.2/mods-available/xdebug.ini /etc/php/7.2/cli/conf.d/20-xdebug.ini
sudo ln -snf /etc/php/7.2/mods-available/xdebug.ini /etc/php/7.2/fpm/conf.d/20-xdebug.ini

#编译7.1版本xdebug

cd ~
cp -r  xdebug xdebug7.1
#compile and make install
cd xdebug7.1

phpize7.1
./configure --with-php-config=/usr/bin/php-config7.1 --enable-xdebug
sudo make
sudo make install

sudo mkdir -p /usr/local/php/xdebug/7.1
sudo cp ~/xdebug7.1/modules/xdebug.so /usr/local/php/xdebug/7.1/xdebug.so
cat>>xdebug.ini<<EOF
zend_extension="/usr/local/php/xdebug/7.1/xdebug.so"
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_port = 9000
xdebug.max_nesting_level = 512
EOF

sudo cp xdebug.ini /etc/php/7.1/mods-available/xdebug.ini
sudo ln -snf /etc/php/7.1/mods-available/xdebug.ini /etc/php/7.1/cli/conf.d/20-xdebug.ini
sudo ln -snf /etc/php/7.1/mods-available/xdebug.ini /etc/php/7.1/fpm/conf.d/20-xdebug.ini

#编译7.0版本xdebug
cd ~
cp -r xdebug xdebug7.0
#compile and make install
cd xdebug7.0

phpize7.0
./configure --with-php-config=/usr/bin/php-config7.0 --enable-xdebug
sudo make
sudo make install

sudo mkdir -p /usr/local/php/xdebug/7.0
sudo cp ~/xdebug7.0/modules/xdebug.so /usr/local/php/xdebug/7.0/xdebug.so
cat>>xdebug.ini<<EOF
zend_extension="/usr/local/php/xdebug/7.0/xdebug.so"
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_port = 9000
xdebug.max_nesting_level = 512
EOF

sudo cp xdebug.ini /etc/php/7.0/mods-available/xdebug.ini
sudo ln -snf /etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/cli/conf.d/20-xdebug.ini
sudo ln -snf /etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/fpm/conf.d/20-xdebug.ini

#编译5.6版本xdebug
cd ~
wget https://xdebug.org/files/xdebug-2.5.5.tgz
tar xvzf xdebug-2.5.5.tgz
#compile and make install
cd xdebug-2.5.5

phpize5.6
./configure --with-php-config=/usr/bin/php-config5.6 --enable-xdebug
sudo make
sudo make install

sudo mkdir -p /usr/local/php/xdebug/5.6
sudo cp ~/xdebug-2.5.5/modules/xdebug.so /usr/local/php/xdebug/5.6/xdebug.so
cat>>xdebug.ini<<EOF
zend_extension="/usr/local/php/xdebug/5.6/xdebug.so"
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_port = 9000
xdebug.max_nesting_level = 512
EOF

sudo cp xdebug.ini /etc/php/5.6/mods-available/xdebug.ini
sudo ln -snf /etc/php/5.6/mods-available/xdebug.ini /etc/php/5.6/cli/conf.d/20-xdebug.ini
sudo ln -snf /etc/php/5.6/mods-available/xdebug.ini /etc/php/5.6/fpm/conf.d/20-xdebug.ini
sudo rm xdebug.ini

sudo service php5.6-fpm restart
sudo service php7.0-fpm restart
sudo service php7.1-fpm restart
sudo service php7.2-fpm restart

cd ~
sudo rm -R xdebug
sudo rm -R xdebug7.2
sudo rm -R xdebug7.1
sudo rm -R xdebug7.0
sudo rm -R xdebug-2.5.5
