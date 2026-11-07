Netplan DHCP:

network:
  version: 2
  ethernets:
    ens33:
      dhcp4: true
    ens34:
      dhcp4: true
      dhcp4-overrides:
        use-routes: false


# ==========================================================
# Despliegue de Zabbix 6.0 LTS y MySQL en Ubuntu Server 20.04
# Autor: Jean Heriberto Alvarez Sierra (Matrícula: 2024-2412)
# ==========================================================

# 1. Repositorio de Zabbix 6.0 LTS (Focal)
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_6.0-4+ubuntu20.04_all.deb
sudo apt update

# 2. Instalación de paquetes
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent mysql-server snmp

# 3. Creación de Base de Datos y usuario
sudo mysql -e "CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
sudo mysql -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix2024';"
sudo mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';"
sudo mysql -e "SET GLOBAL log_bin_trust_function_creators = 1;"

# 4. Importación del esquema de Zabbix
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -pzabbix2024 zabbix

# 5. Restablecer variable de creadores
sudo mysql -e "SET GLOBAL log_bin_trust_function_creators = 0;"

# 6. Configuración de contraseña en zabbix_server.conf
sudo sed -i 's/# DBPassword=/DBPassword=zabbix2024/' /etc/zabbix/zabbix_server.conf

# 7. Reiniciar y habilitar servicios
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2