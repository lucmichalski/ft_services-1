#!/bin/sh
 
__mysql_config() {
    # Hack to get MySQL up and running... I need to look into it more.
    echo "Running the mysql_config function."
    #yum -y erase community-mysql community-mysql-server
    #rm -rf /var/lib/mysql/ /etc/my.cnf
    #yum -y install community-mysql community-mysql-server
    mysql_install_db
    chown -R mysql:mysql /var/lib/mysql
    /usr/bin/mysqld_safe & 
    sleep 10
}
 
__start_mysql() {
    echo "Running the start_mysql function."
    mysqladmin -u root password foobar
    mysql -uroot -pfoobar -e "CREATE DATABASE wp"
    mysql -uroot -pfoobar -e "CREATE USER 'admin'@'%' IDENTIFIED BY '42';"
    mysql -uroot -pfoobar -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';"
    mysql -uroot -pfoobar -e "SHOW GRANTS FOR 'admin'@'%';"

 #   mysql -uroot -pfoobar -e "CREATE USER 'user42'@'192.168.99.103' IDENTIFIED BY 'mpd';"
 #   mysql -uroot -pfoobar -e "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '42';"
#    mysql -uroot -pfoobar -e "GRANT ALL PRIVILEGES ON 42_db.* TO '42_db'@'localhost' IDENTIFIED BY '42_db'; FLUSH PRIVILEGES;"
#    mysql -uroot -pfoobar -e "GRANT ALL PRIVILEGES ON 42_db.* TO '42_db'@'%' IDENTIFIED BY '42_db'; FLUSH PRIVILEGES;"
  #  mysql -uroot -pfoobar -e "GRANT ALL PRIVILEGES ON *.* TO '42_db'@'%' IDENTIFIED BY '42_db' WITH GRANT OPTION; FLUSH PRIVILEGES;"
  #  mysql -uroot -pfoobar -e "GRANT ALL PRIVILEGES ON *.* TO '42_db'@'%' IDENTIFIED BY '42_db' WITH GRANT OPTION; FLUSH PRIVILEGES;"
 #   mysql -uroot -pfoobar -e "GRANT ALL PRIVILEGES ON *.* TO 'user42'@'%' IDENTIFIED BY '42_db' WITH GRANT OPTION; FLUSH PRIVILEGES;"
 #   mysql -uroot -pfoobar -e "select user, host FROM mysql.user;"
    killall mysqld
    sleep 10
}
 
# Call all functions
__mysql_config
__start_mysql
