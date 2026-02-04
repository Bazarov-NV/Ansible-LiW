#!/bin/bash

extra_vars=""
yaml_file="lmserver2.yml"

echo "Available Inventory Files:"
    inventories=(./inventories/*.ini) # Adjust path as needed
    for i in "${!inventories[@]}"; do
        echo "$((i+1)). ${inventories[$i]##*/}"
    done
read -p "Enter the number of the inventory file to use: " choice

    selected_inventory="${inventories[$((choice-1))]}"

    if [[ -z "$selected_inventory" ]]; then
        echo "Invalid choice. Exiting."
        exit 1
    fi

    echo "Selected inventory: $selected_inventory"

read -r -p "Ввести параметры установки/обновления вручную? [Y/n]: " yn


if [[ "${yn:-n}"  =~ ^[Yy]$ ]]; then

   read -p "Номер версии PG: " pg_version
   if [[ ! "$pg_version" =~ ^[1-9]+$ ]]; then
    echo "Error: Version incorrect"
    break
   else
     extra_vars+="--extra-vars ''{ \"pg_version\":\"$pg_version\""
   fi

   read -p "Название БД PG: " pg_db
   if [ -z "$pg_db" ]; then
    echo "Error: db name empty"
    break
   else
     extra_vars+=" ,\"pg_db\":\"$pg_db\""
   fi

   read -p "Пользователь PG:" pg_user 
   if [ -z "$pg_user" ]; then
     echo "Error: usr name empty"
     break
   else 
     extra_vars+=", \"pg_user\":\"$pg_user\""
   fi

   read -p "Пароль PG: " pg_pwd
   if [ -z "$pg_pwd" ] ; then
    echo "Error: pg password empty"
    break
   else
     extra_vars+=", \"pg_pwd\":\"$pg_pwd\""
   fi

   read -p "PG host: " pg_host
   if [ -z "$pg_host" ] ; then
    echo "Error: pg host incorrect"
    break
   else
     extra_vars+=", \"pg_host\":\"$pg_host\""
   fi

   read -p "PG port: " pg_port
   if [[ ! "$pg_port" =~ ^[1-9]+$ ]] ; then
    echo "Error: pg host incorrect"
    break
   else
     extra_vars+=", \"pg_port\":\"$pg_port\""
   fi

fi


read -r -p "Новая установка? [Y/n]: " install_request

if [[ "${install_request:-y}" =~ ^[Yy]$ ]]; then
  if [ -z "$extra_vars" ]; then
    extra_vars+=" --extra-vars '{\"new_install\":true"
  else
    extra_vars+=", \"new_install\":true"
  fi
else
  if [ -z "$extra_vars" ]; then
    extra_vars+=" --extra-vars '{\"new_install\":false"
  else
    extra_vars+=", \"new_install\":false"
  fi
fi



read -r -p "Восстановить демо виртуалку  win2k19 из snapshot? [Y/n]: " vm_request

if [[ "${vm_request:-y}" =~ ^[Yy]$ ]]; then
  if [ -z "$extra_vars" ]; then
    extra_vars+=" --extra-vars '{\"demo_server\":true"
  else
    extra_vars+=", \"demo_server\":true"
  fi
else
  if [ -z "$extra_vars" ]; then
    extra_vars+=" --extra-vars '{\"demo_server\":false"
  else
    extra_vars+=", \"demo_server\":false"
  fi
fi

if test -n "$extra_vars"; then
  extra_vars+="}'"
fi

echo "ansible-playbook -i $selected_inventory $yaml_file $extra_vars"
eval "ansible-playbook -i $selected_inventory $yaml_file $extra_vars"
