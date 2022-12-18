#!/bin/bash

if [[ ! -z "$1" ]]
then 
    if [ "$1" == "test" ]; then DB="tests/test.db"; else DB="$1"; fi
else
    DB="habits.db"
fi

sqlite3 $DB ".read SCHEMA.sql"

# Check today's recordings and see if there's anything there... if so, grab them...
current=$( sqlite3 $DB 'select * from today;' )
weight_input=$(awk -F '|' '{print $1}'<<< "$current")
medicine_input=$(awk -F '|' '{print $2}'<<< "$current")

read -p "What did you weigh in at this morning? [$weight_input]: " weight
if [[ -z "$weight" ]]  && [[ ! -z "$weight_input" ]]
then
    weight=$weight_input
fi

sqlite3 $DB "insert into weight ('weight') values ('$weight') on conflict(date) do update set weight=$weight;"

read -p "Did you take your medicine this morning (Y/N)? [$medicine_input]: " medicine
if [[ -z "$medicine" ]] && [[ ! -z "$medicine_input" ]]
    then medicine=$medicine_input
fi

sqlite3 $DB "insert into medicine ('taken') values ('$medicine') on conflict(date) do update set taken='$medicine';"

printf '\n\nAmazing! Thanks for updating the tracker. Here are your habit results!\n'
sqlite3 $DB ".header on" ".mode table" "SELECT * FROM today;"