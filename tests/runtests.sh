#! /bin/sh
# file: tests/runtests.sh

oneTimeSetUp() {
  # Create the test database
  sqlite3 tests/test.db ".read tests/tests_schema.sql"
  sqlite3 tests/test.db ".import --csv --skip 1 tests/data/test_data.csv habits"
}

testDatabaseLoaded() {
  assertTrue 'Database Created' "[ -r tests/test.db ]"
  assertEquals "There are 3 recordings..." "3" `sqlite3 tests/test.db 'select count(*) from habits;'`
}

oneTimeTearDown() {
  # Create the test database
  rm tests/test.db
}

testRunsh() {
  first_line=$( printf '200.00\nN\n' | ./habits.sh test )
  second_line=$( sqlite3 tests/test.db 'select count(*) from habits;')
  third_line=$( sqlite3 tests/test.db 'select date, weight from habits order by date desc limit 1;')
  fourth_line=$( sqlite3 tests/test.db 'select date, medicine from habits order by date desc limit 1;')

  expected='

Amazing! Thanks for updating the tracker. Here are your habit results!
+------------+--------+----------+-------+
|    date    | weight | medicine | notes |
+------------+--------+----------+-------+
| 2022-12-21 | 200    | N        |       |
+------------+--------+----------+-------+'

  assertEquals "Results are in!" "$expected" "$first_line"
  assertEquals "There are now four entries in the test DB" "4" "$second_line"
  assertEquals "Weight recorded at 200" "$( date +'%Y-%m-%d' )|200" "$third_line"
  assertEquals "Medicine recorded as taken" "$( date +'%Y-%m-%d' )|N" "$fourth_line"

  fifth_line=$( printf '201.00\nY' | ./habits.sh test )
  expected_new='

Amazing! Thanks for updating the tracker. Here are your habit results!
+------------+--------+----------+-------+
|    date    | weight | medicine | notes |
+------------+--------+----------+-------+
| 2022-12-21 | 201    | Y        |       |
+------------+--------+----------+-------+'

  assertEquals "New results are in!" "$expected_new" "$fifth_line"
  assertEquals "There are still four entries in the test DB" "4" "$second_line"

  sixth_line=$( printf '\n\n\n' | ./habits.sh test )
  expected_default='

Amazing! Thanks for updating the tracker. Here are your habit results!
+------------+--------+----------+-------+
|    date    | weight | medicine | notes |
+------------+--------+----------+-------+
| 2022-12-21 | 201    | Y        |       |
+------------+--------+----------+-------+'

  assertEquals "New results are in!" "$expected_default" "$sixth_line"
  assertEquals "There are still four entries in the test DB" "4" "$second_line"

}

# Load shUnit2.
. tests/shunit2