#!/bin/bash
mkdir /home/scripts
chown zabbix:zabbix /home/scripts
chmod 744 /home/scripts
cd /home/scripts
wget https://raw.githubusercontent.com/abnerfk/Scripts-Zabbix/master/Top%205%20processos%20utilizando%20CPU%20e%20RAM%20em%20Linux/Scripts/discovertop5cpu.sh
wget https://raw.githubusercontent.com/abnerfk/Scripts-Zabbix/master/Top%205%20processos%20utilizando%20CPU%20e%20RAM%20em%20Linux/Scripts/discovertop5memory.sh
wget https://raw.githubusercontent.com/abnerfk/Scripts-Zabbix/master/Top%205%20processos%20utilizando%20CPU%20e%20RAM%20em%20Linux/Scripts/sessions.sh
chmod 744 *
chown zabbix:zabbix *
echo Insira o hostname do agent:
read hostname
  Hostname=Zabbix server
  sed -i 's/Hostname=Zabbix server/Hostname=$hostname/g' /etc/zabbix/zabbix_agentd.conf
  sed -i 's/Server=127.0.0.1/Server=zabbix.2cloud.com.br/g' /etc/zabbix/zabbix_agentd.conf
  sed -i 's/ServerActive=127.0.0.1/ServerActive=zabbix.2cloud.com.br/g' /etc/zabbix/zabbix_agentd.conf
  echo "zabbix	ALL=(ALL)	NOPASSWD: ALL" >> /etc/sudoers
  service zabbix-agent restart
  systemctl enable zabbix-agent
  cat /etc/zabbix/zabbix_agentd.conf | grep Timeout
  cat /etc/zabbix/zabbix_agentd.conf | grep Server=
  cat /etc/zabbix/zabbix_agentd.conf | grep ServerActive=
  tail -f /var/log/zabbix/zabbix_agentd.log
