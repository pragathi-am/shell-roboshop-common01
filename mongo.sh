#!/bin/bash

source ./common.sh

cp mongo.repo /etc/yum.repos.d/mongo.repo  
validate $? "mongo.repo copy" | tee -a $LOG_FILE

dnf install mongodb-org -y 
validate $? "mongodb-org installation" | tee -a $LOG_FILE


systemctl enable mongod 
validate $? "mongod service enable" | tee -a $LOG_FILE

systemctl start mongod 
validate $? "mongod service start" | tee -a $LOG_FILE

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
validate $? "mongod.conf modification" | tee -a $LOG_FILE

systemctl restart mongod
validate $? "mongod service restart" | tee -a $LOG_FILE

print_total_time | tee -a $LOG_FILE
