#! /bin/sh
# file: tests/test_setup.sh

oneTimeSetUp() {
  # Create the test database
  sqlite3 tests/test.db ".read SCHEMA.sql"
  sqlite3 tests/test.db ".import --csv --skip 1 tests/data/test_weights.csv weight"
}

testDatabaseLoaded() {
  assertTrue 'Database Created' "[ -r tests/test.db ]"
  assertEquals "There are 3 recordings..." "3" `sqlite3 tests/test.db 'select count(*) from weight;'`
}

oneTimeTearDown() {
  # Create the test database
  rm tests/test.db
}

testRunsh() {
  first_line=$( printf '200.00\nN' | . ./run.sh test )
  second_line=$( sqlite3 tests/test.db 'select count(*) from weight;')
  third_line=$( sqlite3 tests/test.db 'select date, weight from weight order by date desc limit 1;')
  fourth_line=$( sqlite3 tests/test.db 'select date, taken from medicine order by date desc limit 1;')

  expected='

Amazing! Thanks for updating the tracker. Here are your habit results!
+--------+----------------+
| weight | medicine taken |
+--------+----------------+
| 200    | N              |
+--------+----------------+'

  assertEquals "Results are in!" "$expected" "$first_line"
  assertEquals "There are now four entries in the test DB" "4" "$second_line"
  assertEquals "Weight recorded at 200" "$( date +'%Y-%m-%d' )|200" "$third_line"
  assertEquals "Medicine recorded as taken" "$( date +'%Y-%m-%d' )|N" "$fourth_line"
}

# Load shUnit2.
. tests/shunit2