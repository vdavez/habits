# Check today's recordings and see if there's anything there... if so, grab them...

echo "Please input habits for: $_arg_update"

current=$( sqlite3 $_arg_database "select * from habits WHERE date='$_arg_update';" )
weight_input=$(awk -F '|' '{print $2}'<<< "$current")
medicine_input=$(awk -F '|' '{print $3}'<<< "$current")
exercise_input=$(awk -F '|' '{print $4}'<<< "$current")
water_input=$(awk -F '|' '{print $5}'<<< "$current")
