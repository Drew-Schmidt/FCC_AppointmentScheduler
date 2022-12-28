#!/bin/bash
echo -e "\n   ~~~~~~ SALON APPOINTMENT SCHEDULER ~~~~~~\n"

##############################################
#     ~~~ SOME NICE THINGS TO ADD ~~~        #
# -Option to cancel                          #
# -Phone number validation                   #
# -Required time format with business hours. #
##############################################

PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "Hello, which service will you be scheduling today?" 
  echo -e "\n 1) Cut
           \n 2) Wash
           \n 3) Color
           \n 4) None for now"
          

  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) CUT ;;
    2) WASH ;;
    3) COLOR ;;
    4) EXIT ;;
    *) MAIN_MENU "I'm sorry that is not a service option." ;;
  esac
}

CUT(){
  # get phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  # get customer name
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if not found
  if [[ -z $CUSTOMER_NAME ]]
  then
    # request name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    
    # add new customer with greeting
    UPDATE_CUSTOMER_TABLE=$($PSQL "INSERT INTO customers(name,phone) VAlUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    echo -e "\nWhat time works best for your cut, $CUSTOMER_NAME?"
    
  else
    # welcome returning customer
    echo -e "\nWhat time works best for your cut, $CUSTOMER_NAME?" 
  fi
    
    # get requested time
    read SERVICE_TIME
   
    #get service_id and customer_id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE name='cut'")
    
    # add appointment
    ADD_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES ('$CUSTOMER_ID','$SERVICE_ID','$SERVICE_TIME')")
    
    # confirmation message
    echo -e "\nI have put you down for a cut at $SERVICE_TIME, $CUSTOMER_NAME."   
}

WASH(){
  # get phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  # get customer name
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if not found
  if [[ -z $CUSTOMER_NAME ]]
  then
    # request name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    
    # add new customer with greeting
    UPDATE_CUSTOMER_TABLE=$($PSQL "INSERT INTO customers(name,phone) VAlUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    echo -e "\nWhat time works best for your wash, $CUSTOMER_NAME?"
    
  else
    # welcome returning customer
    echo -e "\nWhat time works best for your wash, $CUSTOMER_NAME?" 
  fi
   
    # get requested time
    read SERVICE_TIME
    
    #get service_id and customer_id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE name='wash'")
    
    # add appointment
    ADD_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES ('$CUSTOMER_ID','$SERVICE_ID','$SERVICE_TIME')")
    
    # confirm with customer
    echo -e "\nI have put you down for a wash at $SERVICE_TIME, $CUSTOMER_NAME."    
}

COLOR(){
  # get phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  # get customer name
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if not found
  if [[ -z $CUSTOMER_NAME ]]
  then
    # request name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    
    # add new customer with greeting
    UPDATE_CUSTOMER_TABLE=$($PSQL "INSERT INTO customers(name,phone) VAlUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    echo -e "\nWhat time works best for your cut, $CUSTOMER_NAME?"
    
  else
    # welcome returning customer
    echo -e "\nWhat time works best for your color, $CUSTOMER_NAME?" 
  fi
   
    # get requested time
    read SERVICE_TIME
    
    #get service_id and customer_id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE name='color'")
    
    # add appointment
    ADD_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES ('$CUSTOMER_ID','$SERVICE_ID','$SERVICE_TIME')")
    
    # confirmation message
    echo -e "\nI have put you down for a color at $SERVICE_TIME, $CUSTOMER_NAME."  
}

EXIT() {
  echo -e "\nThank you for stopping in.\n"
}

MAIN_MENU