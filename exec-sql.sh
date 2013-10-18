#! /bin/sh
# automate testing sql
# 
# usage:
# > sh exec-sql.sh [FILE]
# where FILE is an SQL file within the 'exercises' directory

NAME="exec-sql"
PRE="[${NAME}]: "
DB="sql-hard.db"
DIR="exercises"

# verify at least one argument
if [ "$#" -ge 1 ]; then

	# remove database if it already exists
	if [ -f "${DB}" ]; then
		rm "${DB}"
	fi

	# exercise file to be tested
	FILE="${DIR}/$1"
	if [ -f "${FILE}" ]; then
		sqlite3 -column -header -echo "${DB}" < "${FILE}"
	else
		echo "${PRE} \"${FILE}\" does not exist..."
	fi

# no exercise file
else
	echo "${PRE} Must supply an exercise file..."
fi

