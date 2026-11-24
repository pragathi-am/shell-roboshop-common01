#!/bin/bash

USER_ID=$(id -u)
LOG_FOLDER="/var/log/shell-roboshop01"
LOG_FILE="/var/log/shell-roboshop01/$0.log"
START_TIME=$(date +%s)
SCRIPT_DIR=$(pwd)   
MONGODB_HOST="mongodb.daws88spr.online"


if [ $USER_ID -ne 0 ]; then 
    echo "you are not root user. please use root user to run this"
    exit 1
fi

mkdir -p $LOG_FOLDER

R='\e[31m'
G='\e[32m'  
Y='\e[33m'
B='\e[34m'


validate(){
  if [ $1 -eq 0 ]; then
        echo -e "$(date "+%Y-%m-%d %H:%M:%S") $2 $G successfully $N" | tee -a $LOG_FILE
  else
        echo -e "$(date "+%Y-%m-%d %H:%M:%S") $2 $R failed $N" | tee -a $LOG_FILE
  fi
}

nodejs_setup(){
      dnf module disable nodejs -y &>> $LOG_FILE
      validate $? "nodejs module disable" | tee -a $LOG_FILE

      dnf module enable nodejs:20 -y &>> $LOG_FILE
      validate $? "nodejs module enable" | tee -a $LOG_FILE

      dnf install nodejs -y &>> $LOG_FILE
      validate $? "nodejs installation" | tee -a $LOG_FILE
}

print_total_time(){
   END_TIME=$(date +%s) 
   TOTAL_TIME=$((END_TIME - START_TIME))
  echo -e "script executed for $(TOTAL_TIME) seconds"  | tee -a $LOG_FILE   
}    