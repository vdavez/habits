#!/bin/bash

if [ "test" == "$1" ]
    then DB="tests/test.db"
else
    DB="habits.db"
fi

sqlite3 $DB ".read SCHEMA.sql"

read -p "What did you weigh in at this morning? " weight
sqlite3 $DB "insert into weight ('weight') values ('$weight');"

read -p "Did you take your medicine this morning? (Y/N) " medicine
sqlite3 $DB "insert into medicine ('taken') values ('$medicine');"

printf '\n\nAmazing! Thanks for updating the tracker. Here are your habit results!\n'
sqlite3 $DB ".header on" ".mode table" "SELECT * FROM today;"