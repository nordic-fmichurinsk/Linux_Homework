#!/bin/bash
option="$1"
word="$2"

if [[ "$option" != "-u" && "$option" != "-l" ]]; then
  echo "Invalid option. Use -u for uppercase or -l for lowercase."
  exit 1
fi

if [ "$option" == "-u" ]; then
  echo "$word" | tr 'a-z' 'A-Z' 
elif [ "$option" == "-l" ]; then
  echo "$word" | tr 'A-Z' 'a-z' 
fi

exit 0