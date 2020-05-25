#!/bin/bash
#################################################################	
#Script para a montagem de JSON emonitoramento dos		#
#TOP 20 processosconsumindo memoria.				# 			
#								#
#Script feito por: Abner Klug					#
#								#
#								#
#								#
#Modo de utilização:						#
#LLD: bash discovertop20memory.sh DISCOVERY			#
#Uso de memória em B: bash discovertop20memory.sh PID		#
#Uso de memória em %: bash discovertop20memory.sh PID PERCENT	#
#################################################################

#########Entrada de valores nas variaveis########
CMD=$1
CMD2=$2

#########Valida se usuário deseja realizar o LLD########
if [ $1 == "DISCOVERY" ]
then 
first=1
echo -ne "{\n";
echo -ne "\"data\":[\n";

for counter in $(seq 1 5)
{
        if [ $first == 0 ]; then echo -ne ",\n"; fi
        first=0
	psname=`ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6 | tail -n +2 | awk '{print $3}' | sed -n "$counter p"`
	pid=`ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6 | tail -n +2 | awk '{print $1}' | sed -n "$counter p"`
        echo -ne "{"
        echo -ne "\t\"{#PSNAME}\":\"$psname\","
	echo -ne "\"{#PID}\":\"$pid\""
	echo -ne "}";
}


echo -ne "]";
echo -ne "}\n";
else
########Valida se usuário deseja o valor em porcentagem########
if [ $CMD2 == "PERCENT" ]
	then
	percent=`ps -p $1 -o %mem | tail -n +2`
	echo -ne "$percent\n"
########Senão, valor será exibido em bytes########
else
value=`ps -o rss= $1`
value=$((value * 1024))
echo -ne "$value\n"
fi fi 
