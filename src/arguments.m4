#!/bin/bash

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11  #)Created by argbash-init v2.10.0
# ARG_OPTIONAL_SINGLE([database], [d], [the database name], [habits.db])
# ARG_OPTIONAL_BOOLEAN([silent], [s], [silent mode])
# ARG_POSITIONAL_SINGLE([mode], [the mode (currently: run, test, export)], [run])
# ARG_DEFAULTS_POS
# ARG_POSITIONAL_DOUBLEDASH()
# ARG_HELP([habits: A habit tracker for the CLI using Bash and SQLite])
# ARGBASH_GO

# [ <-- needed because of Argbash

# vvv  PLACE YOUR CODE HERE  vvv
# For example:
printf 'Value of -%s: %s\n' 'd' "$_arg_database"
printf "'%s' is %s\\n" 's' "$_arg_silent"
printf "Value of '%s': %s\\n" 'mode' "$_arg_mode"

# ^^^  TERMINATE YOUR CODE BEFORE THE BOTTOM ARGBASH MARKER  ^^^

# ] <-- needed because of Argbash
