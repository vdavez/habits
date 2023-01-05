echo "Please input habits for: $_arg_update"

read -p "What did you weigh in at this morning? [$weight_input]: " weight
if [[ -z "$weight" ]]  && [[ ! -z "$weight_input" ]]
then
    weight=$weight_input
fi

sqlite3 $_arg_database "insert into habits (date, weight) values ('$_arg_update', '$weight') on conflict(date) do update set weight='$weight';"

read -p "Did you take your medicine this morning (Y/N) [$medicine_input]: " medicine
if [[ -z "$medicine" ]]  && [[ ! -z "$medicine_input" ]]
then
    medicine=$medicine_input
fi

sqlite3 $_arg_database "insert into habits (date, medicine) values ('$_arg_update', '$medicine') on conflict(date) do update set medicine='$medicine';"

read -p "Did you exercise today? [$exercise_input]: " exercise
if [[ -z "$exercise" ]]  && [[ ! -z "$exercise_input" ]]
then
    exercise=$exercise_input
fi

sqlite3 $_arg_database "insert into habits (date, exercise) values ('$_arg_update', '$exercise') on conflict(date) do update set exercise='$exercise';"

read -p "How many bottles of water have you had today? [$water_input]: " water
if [[ -z "$water" ]]  && [[ ! -z "$water_input" ]]
then
    water=$water_input
fi

sqlite3 $_arg_database "insert into habits (date, water) values ('$_arg_update', '$water') on conflict(date) do update set water='$water';"
