#!/bin/bash
cd /tmp
wget https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-3+xenial_all.deb
dpkg -i zabbix-release_4.0-3+xenial_all.deb
apt update
apt-get -o Dpkg::Options::="--force-confnew" install zabbix-agent
cd /etc/zabbix/zabbix_agentd.d
wget https://raw.githubusercontent.com/abnerfk/Scripts-Zabbix/master/conf.d/2cloud-4.conf
echo Insira o hostname do agent:
read hostname
  sed -i "s/Hostname=Zabbix server/Hostname=$hostname/g" /etc/zabbix/zabbix_agentd.conf
  sed -i 's/Server=127.0.0.1/Server=zabbix.2cloud.com.br,zabbixnovo.2cloud.com.br/g' /etc/zabbix/zabbix_agentd.conf
  sed -i 's/ServerActive=127.0.0.1/ServerActive=zabbix.2cloud.com.br,zabbixnovo.2cloud.com.br/g' /etc/zabbix/zabbix_agentd.conf
  service zabbix-agent restart
  systemctl enable zabbix-agent
  cat /etc/zabbix/zabbix_agentd.conf | grep Server=
  cat /etc/zabbix/zabbix_agentd.conf | grep ServerActive=
  tail -f /var/log/zabbix/zabbix_agentd.log