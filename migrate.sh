#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <table_name> <input.sql>"
  exit 1
fi

table_name=$1         # Table name to process, passed as the first argument
input_file=$2         # Input SQL file, passed as the second argument
output_file="output.sql"  # The file to save the modified SQL commands

touch "$output_file"
chmod +w "$output_file"

# Use awk to process the file, targeting the specified table
awk -v table="$table_name" '
BEGIN {
    FS="VALUES"; 
    first = 1;
}
$0 ~ ("INSERT INTO " table) {
    if(first) {
        print "Processing SQL Inserts for " table "..." >> "'$output_file'";
        print $1 "VALUES" >> "'$output_file'";  # Append the beginning of the insert statement
        first = 0;
    }
    gsub(/;$/, "", $2);  # Remove the semicolon at the end of each insert
    printf "%s,\n", $2 >> "'$output_file'";  # Append values with a comma and new line for readability
}
END {
    if (!first) {  # Only append the ending if there was at least one insert
        print "\b\b;" >> "'$output_file'";  # Replace the final comma with a semicolon to end the SQL statement
    }
}' $input_file

echo "Processed SQL file appended to $output_file"
