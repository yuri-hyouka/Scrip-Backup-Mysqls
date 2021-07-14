#!/bin/bash
# NOME: Script de backup diário dos servidores mariadb
# Horário: 12:30 e 20:30
# VERSÃO: 2.0
# DATA: 19-08-2020
# SERVIDOR: mysqlserver1 
# FUNÇÃO: Script que realiza o backup lógico dos servidores de banco de dados.
#                                                                              
####################################################################################################################################################################

#SERVIDOR: mysqlserver1 
#IP: 
#DESC: Outros sistemas web

#############################
# Variaveis de Conexao      #
############################# 

USERNAME="user"
PASS="pw"
USERNAMEZABBIX="user_zabbix"
IPZABBIX="ip_zabbix"
SENHAZABBIX="pw_zabbix"
HOSTNAME=`hostname`

#############################
# Variaveis Globais         #
#############################
SERVIDOR="mysqlserver1"
IP="localhost"
OUTPUT="/backup/$SERVIDOR/backup_diario/`date +%Y`/`date +%m-%B`/`date +%d`"
HORAINICIAL=`date +%Hh-%Mm-%Ss`
MYSQLDUMP=`which mysqldump`
GZIP=`which gzip`
DATABASES=`/usr/bin/mysql -h ${IP} --user=root --password=${PASS} -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`
NAMEBKP="`date +%d-%m-%Y_%H-%M`.sql"
NAMELOG="`date +%d-%m-%Y_%H-%M`.log"
SAIDAPADRAO="DEFAULT-`date +%d-%m-%Y_%H-%M`.log" #usado pelo zabbix para monitorar se o backup foi executado
CODRETORNO="COD-`date +%d-%m-%Y_%H-%M`.log"      #usado pelo zabbix para monitorar se o backup foi executado
STATUSERROR="STS_BKP_mysqlserver1.log"	 #usado pelo zabbix para monitorar se o backup foi executado
NUMBD=0

#criando o diretório de backup e de log caso não exista.
if [ ! -d $OUTPUT ]; then
	mkdir -p "$OUTPUT/log"
fi;
		
	
#Executando o Backup e Armazenando o log	
echo "" > "$OUTPUT/log/$NAMELOG"
echo "=========== LISTA DE BD's QUE SOFRERAM BACKUP===================" >> "$OUTPUT/log/$NAMELOG"
echo $DATABASES >> "$OUTPUT/log/$NAMELOG"

for db in $DATABASES; do
	NUMBD=`expr $NUMBD + 1`
	if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] ; then
	 echo "=================================================================" >> "$OUTPUT/log/$NAMELOG"
	 echo "Dumping database: $db" >> "$OUTPUT/log/$NAMELOG"
	 echo "Dumping database: $db" 
	 echo "Log"
	 ${MYSQLDUMP} -h ${IP} --force --single-transaction --opt -u ${USERNAME} --password=${PASS} --databases $db 2>> "$OUTPUT/log/$SAIDAPADRAO" > "$OUTPUT/$db-$NAMEBKP" && echo "Backup de: $db [OK]" >> "$OUTPUT/log/$NAMELOG" 
	 echo $? >> "$OUTPUT/log/$CODRETORNO"
	 ${GZIP} -f "$OUTPUT/$db-$NAMEBKP"
	 echo "=================================================================" >> "$OUTPUT/log/$NAMELOG"
	fi
done 
echo "=================================================================" >> "$OUTPUT/log/$NAMELOG"
HORAFINAL=`date +%Hh-%Mm-%Ss`
echo "Número de Banco de Dados que sofreram backup: $NUMBD" >> "$OUTPUT/log/$NAMELOG"
echo "Hora inicial do backup: $HORAINICIAL" >> "$OUTPUT/log/$NAMELOG"
echo "Hora final do backup: $HORAFINAL" >> "$OUTPUT/log/$NAMELOG"
####################################################################################################################################################################

#SERVIDOR:
#IP: 
#DESC: 

#############################
# Variaveis de Conexao      #
############################# 

USERNAME2="user"
PASS2='pw'

#############################
# Variaveis Globais         #
#############################
SERVIDOR2="server2"
IP2="ip"
OUTPUT2="/backup/$SERVIDOR2/backup_diario/`date +%Y`/`date +%m-%B`/`date +%d`"
DATABASES2=`/usr/bin/mysql -h ${IP2} -u ${USERNAME2} --password=${PASS2} -e "SHOW DATABASES;" | tr -d "| " | egrep -v 'Database|schema'`
NUMBD2=0

#criando o diretório de backup e de log caso não exista.
if [ ! -d $OUTPUT2 ]; then
	mkdir -p "$OUTPUT2/log"
fi;

#Executando o Backup e Armazenando o log	
echo "" > "$OUTPUT2/log/$NAMELOG"
echo "=========== LISTA DE BD's QUE SOFRERAM BACKUP===================" >> "$OUTPUT2/log/$NAMELOG"
echo $DATABASES2 >> "$OUTPUT2/log/$NAMELOG"

for db2 in $DATABASES2; do
	NUMBD2=`expr $NUMBD2 + 1`
	if [[ "$db2" != "information_schema" ]] && [[ "$db2" != "performance_schema" ]] ; then
	 echo "=================================================================" >> "$OUTPUT2/log/$NAMELOG"
	 echo "Dumping database: $db2" >> "$OUTPUT2/log/$NAMELOG"
	 echo "Dumping database: $db2" 
	 echo "Log"
	 ${MYSQLDUMP} -h ${IP2} --force --single-transaction --opt -u ${USERNAME2} --password=${PASS2} --databases $db2 2>> "$OUTPUT2/log/$SAIDAPADRAO" > "$OUTPUT2/$db2-$NAMEBKP" && echo "Backup de: $db2 [OK]" >> "$OUTPUT2/log/$NAMELOG" 
	 echo $? >> "$OUTPUT2/log/$CODRETORNO"
	 ${GZIP} -f "$OUTPUT2/$db2-$NAMEBKP"
	 echo "=================================================================" >> "$OUTPUT2/log/$NAMELOG"
	fi
done 
echo "=================================================================" >> "$OUTPUT2/log/$NAMELOG"
HORAFINAL=`date +%Hh-%Mm-%Ss`
echo "Número de Banco de Dados que sofreram backup: $NUMBD2" >> "$OUTPUT2/log/$NAMELOG"
echo "Hora inicial do backup: $HORAINICIAL" >> "$OUTPUT2/log/$NAMELOG"
echo "Hora final do backup: $HORAFINAL" >> "$OUTPUT2/log/$NAMELOG"

####################################################################################################################################################################

#SERVIDOR:  
#IP: 
#DESC:  

#############################
# Variaveis de Conexao      #
############################# 

USERNAME3="user"
PASS3='pw'

#############################
# Variaveis Globais         #
#############################
SERVIDOR3="server"
IP3="ip"
OUTPUT3="/backup/$SERVIDOR3/backup_diario/`date +%Y`/`date +%m-%B`/`date +%d`"
DATABASES3=`/usr/bin/mysql -h ${IP3} -u ${USERNAME3} --password=${PASS3} -e "SHOW DATABASES;" | tr -d "| " | egrep -v 'Database|schema'`
NUMBD3=0

#criando o diretório de backup e de log caso não exista.
if [ ! -d $OUTPUT3 ]; then
	mkdir -p "$OUTPUT3/log"
fi;

#Executando o Backup e Armazenando o log	
echo "" > "$OUTPUT3/log/$NAMELOG"
echo "=========== LISTA DE BD's QUE SOFRERAM BACKUP===================" >> "$OUTPUT3/log/$NAMELOG"
echo $DATABASES3 >> "$OUTPUT3/log/$NAMELOG"

for db3 in $DATABASES3; do
	NUMBD3=`expr $NUMBD3 + 1`
	if [[ "$db3" != "information_schema" ]] && [[ "$db3" != "performance_schema" ]] ; then
	 echo "=================================================================" >> "$OUTPUT3/log/$NAMELOG"
	 echo "Dumping database: $db3" >> "$OUTPUT3/log/$NAMELOG"
	 echo "Dumping database: $db3" 
	 echo "Log"
	 ${MYSQLDUMP} -h ${IP3} --force --single-transaction --opt -u ${USERNAME3} --password=${PASS3} --databases $db3 2>> "$OUTPUT3/log/$SAIDAPADRAO" > "$OUTPUT3/$db3-$NAMEBKP" && echo "Backup de: $db3 [OK]" >> "$OUTPUT3/log/$NAMELOG" 
	 echo $? >> "$OUTPUT3/log/$CODRETORNO"
	 ${GZIP} -f "$OUTPUT3/$db3-$NAMEBKP"
	 echo "=================================================================" >> "$OUTPUT3/log/$NAMELOG"
	fi
done 
echo "=================================================================" >> "$OUTPUT3/log/$NAMELOG"
HORAFINAL=`date +%Hh-%Mm-%Ss`
echo "Número de Banco de Dados que sofreram backup: $NUMBD3" >> "$OUTPUT3/log/$NAMELOG"
echo "Hora inicial do backup: $HORAINICIAL" >> "$OUTPUT3/log/$NAMELOG"
echo "Hora final do backup: $HORAFINAL" >> "$OUTPUT3/log/$NAMELOG"
####################################################################################################################################################################

#SERVIDOR: 
#IP: 
#DESC: 

#############################
# Variaveis de Conexao      #
############################# 

USERNAME4="user"
PASS4='pw'

#############################
# Variaveis Globais         #
#############################
SERVIDOR4="server"
IP4="ip"
OUTPUT4="/backup/$SERVIDOR4/backup_diario/`date +%Y`/`date +%m-%B`/`date +%d`"
DATABASES4=`/usr/bin/mysql -h ${IP4} -u ${USERNAME4} --password=${PASS4} -e "SHOW DATABASES;" | tr -d "| " | egrep -v 'Database|schema'`
NUMBD4=0

#criando o diretório de backup e de log caso não exista.
if [ ! -d $OUTPUT4 ]; then
	mkdir -p "$OUTPUT4/log"
fi;

#Executando o Backup e Armazenando o log	
echo "" > "$OUTPUT4/log/$NAMELOG"
echo "=========== LISTA DE BD's QUE SOFRERAM BACKUP===================" >> "$OUTPUT4/log/$NAMELOG"
echo $DATABASES4 >> "$OUTPUT4/log/$NAMELOG"

for db4 in $DATABASES4; do
	NUMBD4=`expr $NUMBD4 + 1`
	if [[ "$db4" != "information_schema" ]] && [[ "$db4" != "performance_schema" ]] ; then
	 echo "=================================================================" >> "$OUTPUT4/log/$NAMELOG"
	 echo "Dumping database: $db4" >> "$OUTPUT4/log/$NAMELOG"
	 echo "Dumping database: $db4" 
	 echo "Log"
	 ${MYSQLDUMP} -h ${IP4} --force --single-transaction --opt -u ${USERNAME4} --password=${PASS4} --databases $db4 2>> "$OUTPUT4/log/$SAIDAPADRAO" > "$OUTPUT4/$db4-$NAMEBKP" && echo "Backup de: $db4 [OK]" >> "$OUTPUT4/log/$NAMELOG" 
	 echo $? >> "$OUTPUT4/log/$CODRETORNO"
	 ${GZIP} -f "$OUTPUT4/$db4-$NAMEBKP"
	 echo "=================================================================" >> "$OUTPUT4/log/$NAMELOG"
	fi
done 
echo "=================================================================" >> "$OUTPUT4/log/$NAMELOG"
HORAFINAL=`date +%Hh-%Mm-%Ss`
echo "Número de Banco de Dados que sofreram backup: $NUMBD4" >> "$OUTPUT4/log/$NAMELOG"
echo "Hora inicial do backup: $HORAINICIAL" >> "$OUTPUT4/log/$NAMELOG"
echo "Hora final do backup: $HORAFINAL" >> "$OUTPUT4/log/$NAMELOG"

####################################################################################################################################################################

#SERVIDOR: 
#IP: 
#DESC: 

#############################
# Variaveis de Conexao      #
############################# 

USERNAME5="user"
PASS5='pw'

#############################
# Variaveis Globais         #
#############################
SERVIDOR5="server"
IP5="ip"
OUTPUT5="/backup/$SERVIDOR5/backup_diario/`date +%Y`/`date +%m-%B`/`date +%d`"
DATABASES5=`/usr/bin/mysql -h ${IP5} -u ${USERNAME5} --password=${PASS5} -e "SHOW DATABASES;" | tr -d "| " | egrep -v 'Database|schema'`
NUMBD5=0

#criando o diretório de backup e de log caso não exista.
if [ ! -d $OUTPUT5 ]; then
	mkdir -p "$OUTPUT5/log"
fi;

#Executando o Backup e Armazenando o log	
echo "" > "$OUTPUT5/log/$NAMELOG"
echo "=========== LISTA DE BD's QUE SOFRERAM BACKUP===================" >> "$OUTPUT5/log/$NAMELOG"
echo $DATABASES5 >> "$OUTPUT5/log/$NAMELOG"

for db5 in $DATABASES5; do
	NUMBD5=`expr $NUMBD5 + 1`
	if [[ "$db5" != "information_schema" ]] && [[ "$db5" != "performance_schema" ]] ; then
	 echo "=================================================================" >> "$OUTPUT5/log/$NAMELOG"
	 echo "Dumping database: $db5" >> "$OUTPUT5/log/$NAMELOG"
	 echo "Dumping database: $db5" 
	 echo "Log"
	 ${MYSQLDUMP} -h ${IP5} --force --single-transaction --opt -u ${USERNAME5} --password=${PASS5} --databases $db5 2>> "$OUTPUT5/log/$SAIDAPADRAO" > "$OUTPUT5/$db5-$NAMEBKP" && echo "Backup de: $db5 [OK]" >> "$OUTPUT5/log/$NAMELOG" 
	 echo $? >> "$OUTPUT5/log/$CODRETORNO"
	 ${GZIP} -f "$OUTPUT5/$db5-$NAMEBKP"
	 echo "=================================================================" >> "$OUTPUT5/log/$NAMELOG"
	fi
done 
echo "=================================================================" >> "$OUTPUT5/log/$NAMELOG"
HORAFINAL=`date +%Hh-%Mm-%Ss`
echo "Número de Banco de Dados que sofreram backup: $NUMBD5" >> "$OUTPUT5/log/$NAMELOG"
echo "Hora inicial do backup: $HORAINICIAL" >> "$OUTPUT5/log/$NAMELOG"
echo "Hora final do backup: $HORAFINAL" >> "$OUTPUT5/log/$NAMELOG"

####################################################################################################################################################################

#Tratando o código de erro para monitoramento do zabbix
retorno=`cat "$OUTPUT/log/$CODRETORNO" | grep 1 | wc -l`
retorno2=`cat "$OUTPUT2/log/$CODRETORNO" | grep 1 | wc -l`
retorno3=`cat "$OUTPUT3/log/$CODRETORNO" | grep 1 | wc -l`
retorno4=`cat "$OUTPUT4/log/$CODRETORNO" | grep 1 | wc -l`
retorno5=`cat "$OUTPUT5/log/$CODRETORNO" | grep 1 | wc -l`

if [ ! -s "$OUTPUT/log/$SAIDAPADRAO" -a $retorno == 0 ]; then
	FLAG1=0 
else
	FLAG1=1
fi

if [ ! -s "$OUTPUT2/log/$SAIDAPADRAO" -a $retorno2 == 0 ]; then
	FLAG2=0 
else
	FLAG2=1
fi

if [ ! -s "$OUTPUT3/log/$SAIDAPADRAO" -a $retorno3 == 0 ]; then
	FLAG3=0 
else
	FLAG3=1
fi

if [ ! -s "$OUTPUT4/log/$SAIDAPADRAO" -a $retorno4 == 0 ]; then
	FLAG4=0 
else
	FLAG4=1
fi

if [ ! -s "$OUTPUT5/log/$SAIDAPADRAO" -a $retorno5 == 0 ]; then
	FLAG5=0 
else
	FLAG5=1
fi

if [ $FLAG1 == 0 -a $FLAG2 == 0 -a $FLAG3 == 0 -a $FLAG4 == 0 -a $FLAG5 == 0 ]; then
	echo "0 `date "+%Y-%m-%d %H:%M:%S"` - [$SERVIDOR: SUCESSO]: SUCESSO NA EXECUÇÃO DO BACKUP DIÁRIO DO SERVIDOR: $HOSTNAME  !!!" > "$OUTPUT/log/$STATUSERROR"
	echo "0 `date "+%Y-%m-%d %H:%M:%S"` - [$SERVIDOR2: SUCESSO]: SUCESSO NA EXECUÇÃO DO BACKUP DIÁRIO DO SERVIDOR: $HOSTNAME !!!" > "$OUTPUT2/log/$STATUSERROR"
	echo "0 `date "+%Y-%m-%d %H:%M:%S"` - [$SERVIDOR3: SUCESSO]: SUCESSO NA EXECUÇÃO DO BACKUP DIÁRIO DO SERVIDOR: $HOSTNAME !!!" > "$OUTPUT3/log/$STATUSERROR"
	echo "0 `date "+%Y-%m-%d %H:%M:%S"` - [$SERVIDOR4: SUCESSO]: SUCESSO NA EXECUÇÃO DO BACKUP DIÁRIO DO SERVIDOR: $HOSTNAME !!!" > "$OUTPUT4/log/$STATUSERROR"
	echo "0 `date "+%Y-%m-%d %H:%M:%S"` - [$SERVIDOR5: SUCESSO]: SUCESSO NA EXECUÇÃO DO BACKUP DIÁRIO DO SERVIDOR: $HOSTNAME !!!" > "$OUTPUT5/log/$STATUSERROR"
	/dbs/scripts/envia_email_backup.sh $HOSTNAME "DIÁRIO" `date "+%Y-%m-%d-%H:%M:%S"`	
else
	echo "1 `date "+%Y-%m-%d %H:%M:%S"` - [$SERVIDOR: ERROR]: ERRO NA EXECUÇÃO DO BACKUP DIÁRIO DO SERVIDOR: $HOSTNAME !!!" > "$OUTPUT/log/$STATUSERROR"
	echo "1 `date "+%Y-%m-%d %H:%M:%S"` - [$SERVIDOR2: ERROR]: ERRO NA EXECUÇÃO DO BACKUP DIÁRIO DO SERVIDOR: $HOSTNAME !!!" > "$OUTPUT2/log/$STATUSERROR"
	echo "1 `date "+%Y-%m-%d %H:%M:%S"` - [$SERVIDOR3: ERROR]: ERRO NA EXECUÇÃO DO BACKUP DIÁRIO DO SERVIDOR: $HOSTNAME !!!" > "$OUTPUT3/log/$STATUSERROR"
	echo "1 `date "+%Y-%m-%d %H:%M:%S"` - [$SERVIDOR4: ERROR]: ERRO NA EXECUÇÃO DO BACKUP DIÁRIO DO SERVIDOR: $HOSTNAME !!!" > "$OUTPUT4/log/$STATUSERROR"
	echo "1 `date "+%Y-%m-%d %H:%M:%S"` - [$SERVIDOR5: ERROR]: ERRO NA EXECUÇÃO DO BACKUP DIÁRIO DO SERVIDOR: $HOSTNAME !!!" > "$OUTPUT5/log/$STATUSERROR"
fi

#Copiando o retorno da execução para o zabbix monitorar o status do backup
SSHPASS=`which sshpass > /dev/null; echo $?`
if [ ! $SSHPASS == 0 ]; then
	apt install -y sshpass
fi
sshpass -p $SENHAZABBIX scp "$OUTPUT/log/$STATUSERROR" $USERNAMEZABBIX@$IPZABBIX:/dbs/scripts/zabbix/logs/backup_diario/


