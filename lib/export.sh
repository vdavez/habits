printf "Accessing data from $_arg_database\n" 

sqlite3 $_arg_database \
".header on" \
".mode csv" \
"SELECT w.date, 
    w.weight, 
    m.taken AS 'medicine taken' 
FROM weight w 
JOIN medicine m
ON w.date = m.date
ORDER BY w.date ASC
LIMIT 10;"

exit 0