#!/bin/bash

sqlite3 habits.db ".read SCHEMA.sql"

read -p "What did you weigh in at this morning? " weight
sqlite3 habits.db "insert into weight ('weight') values ('$weight');"

read -p "Did you take your medicine this morning? (Y/N) " medicine
sqlite3 habits.db "insert into medicine ('taken') values ('$medicine');"

echo -e '\n\nAmazing! Thanks for updating the tracker. Here are your habit results!'
sqlite3 habits.db ".header on" ".mode table" "SELECT * FROM today;"