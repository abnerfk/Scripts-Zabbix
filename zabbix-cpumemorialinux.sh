#!/bin/bash
mkdir /home/scripts
chown zabbix:zabbix /home/scripts
chmod 744 /home/scripts
cd /home/scripts
wget https://raw.githubusercontent.com/abnerfk/Scripts-Zabbix/master/discovertop5cpu.sh
wget https://raw.githubusercontent.com/abnerfk/Scripts-Zabbix/master/discovertop5memory.sh
wget https://github.com/abnerfk/Scripts-Zabbix/blob/master/sessions.sh
chmod 744 *
chown zabbix:zabbix *
if [ 'grep -w "# Timeout=3" /etc/zabbix/zabbix_agentd.conf' ]; then
  sed -i 's/# Timeout=3/Timeout=30/g' /etc/zabbix/zabbix_agentd.conf
elif [ 'grep -w "Timeout=3" /etc/zabbix/zabbix_agentd.conf']; then
  sed -i 's/Timeout=3/Timeout=30/g' /etc/zabbix/zabbix_agentd.conf
fi
  echo "UserParameter=discovery.processosmemoria.linux[*],/bin/bash /home/scripts/discovertop5memory.sh $1 $2" >> /etc/zabbix/zabbix_agentd.conf
  echo "UserParameter=discovery.processoscpu.linux[*],/bin/bash /home/scripts/discovertop5cpu.sh $1" >> /etc/zabbix/zabbix_agentd.conf
  echo "UserParameter=sessions.active,/bin/bash /home/scripts/sessions.sh" >> /etc/zabbix/zabbix_agentd.conf
  systemctl restart zabbix-agent;
