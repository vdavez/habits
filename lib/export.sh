printf "Accessing data from $_arg_database\n" 

sqlite3 $_arg_database \
".header on" \
".mode csv" \
"SELECT * FROM habits ORDER BY date DESC LIMIT 10;"
exit 0