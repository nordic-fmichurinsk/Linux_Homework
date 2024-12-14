#!/bin/bash

# Проверяем, что переданы все три аргумента
if [ "$#" -ne 3 ]; then
  echo "Использование: $0 <путь до файла> <текущее расширение> <новое расширение>"
  exit 1
fi

# Получаем аргументы
file_path="$1"
current_extension="$2"
desired_extension="$3"

# Список поддерживаемых форматов
supported_formats=("txt" "pdf" "doc")

# Проверяем, что текущее расширение поддерживается
if [[ ! " ${supported_formats[@]} " =~ " ${current_extension} " ]]; then
  echo "Ошибка: Текущее расширение '${current_extension}' не поддерживается."
  echo "Поддерживаемые форматы: ${supported_formats[*]}"
  exit 1
fi

# Проверяем, что желаемое расширение поддерживается
if [[ ! " ${supported_formats[@]} " =~ " ${desired_extension} " ]]; then
  echo "Ошибка: Желаемое расширение '${desired_extension}' не поддерживается."
  echo "Поддерживаемые форматы: ${supported_formats[*]}"
  exit 1
fi

# Проверяем, что файл существует и имеет правильное текущее расширение
if [ ! -f "$file_path" ]; then
  echo "Ошибка: Файл '${file_path}' не найден."
  exit 1
fi

file_name=$(basename -- "$file_path")
extension="${file_name##*.}"

if [ "$extension" != "$current_extension" ]; then
  echo "Ошибка: Указанное текущее расширение не совпадает с расширением файла."
  exit 1
fi

# Меняем расширение файла
new_file_path="${file_path%.*}.${desired_extension}"

mv "$file_path" "$new_file_path"

if [ $? -eq 0 ]; then
  echo "Файл успешно переименован в: $new_file_path"
else
  echo "Ошибка при переименовании файла."
fi
