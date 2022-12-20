# Check today's recordings and see if there's anything there... if so, grab them...
current=$( sqlite3 $_arg_database 'select * from today;' )
weight_input=$(awk -F '|' '{print $1}'<<< "$current")
medicine_input=$(awk -F '|' '{print $2}'<<< "$current")