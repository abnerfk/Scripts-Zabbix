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
if [ $(grep -w "# Timeout=3" /etc/zabbix/zabbix_agentd.conf | wc -l) -eq 1 ]; then
  sed -i 's/# Timeout=3/Timeout=30/g' /etc/zabbix/zabbix_agentd.conf
elif [ $(grep -w "Timeout=3" /etc/zabbix/zabbix_agentd.conf | wc -l) -eq 1 ]; then
  sed -i 's/Timeout=3/Timeout=30/g' /etc/zabbix/zabbix_agentd.conf
fi
  echo "UserParameter=discovery.processosmemoria.linux[*],/bin/bash /home/scripts/discovertop5memory.sh \$1 \$2" >> /etc/zabbix/zabbix_agentd.conf
  echo "UserParameter=discovery.processoscpu.linux[*],/bin/bash /home/scripts/discovertop5cpu.sh \$1" >> /etc/zabbix/zabbix_agentd.conf
  echo "UserParameter=sessions.active,/bin/bash /home/scripts/sessions.sh" >> /etc/zabbix/zabbix_agentd.conf
  echo "zabbix	ALL=(ALL)	NOPASSWD: ALL" >> /etc/sudoers
  service zabbix-agent restart
  cat /etc/zabbix/zabbix_agentd.conf | grep Timeout
  cat /etc/zabbix/zabbix_agentd.conf | grep UserParameter=
  cat /etc/zabbix/zabbix_agentd.conf | grep Server=
  cat /etc/zabbix/zabbix_agentd.conf | grep ServerActive=
  tail -f /var/log/zabbix/zabbix_agentd.log
