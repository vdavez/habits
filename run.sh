#!/bin/bash
# file: run.sh

if [[ ! -z "$1" ]]; then
    # Check if test DB
    if [[ "$1" == "test" ]];then DB="tests/test.db";
    else
        # Check if silent mode
        if [[ "$1" == "-s" ]]; then
            SILENT=1

            # Check if user-defined DB
            if [[ ! -z "$2" ]]; then 
                DB="$2";
            else
                DB="habits.db"
            fi
        else
            DB=$1
        fi
    fi
else
    DB="habits.db"
fi

# Check today's recordings and see if there's anything there... if so, grab them...
current=$( sqlite3 $DB 'select * from today;' )
weight_input=$(awk -F '|' '{print $1}'<<< "$current")
medicine_input=$(awk -F '|' '{print $2}'<<< "$current")

# If there's a recording and "-s" is used, exit 
if [[ ! -z "$weight_input" ]] && [[ ! -z "$SILENT" ]]; then exit 0; fi

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