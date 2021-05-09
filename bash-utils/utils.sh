#!/bin/bash

#######################################################
#################     VALIDATION     ##################
#######################################################

function validate_file() {
  local file=$1
  
  if [ ! -f $file ]; then
    echo "No file $file found.  Exiting."
  fi  
}

function validate_val() {
  local val_name=$1
  local val=$2

  if [ -z "$val" ] || [ "$val" == "null" ] ; then
    echo "Value for '$val_name' was empty or null.  Exiting."
  else
    echo "Value '$val' was accepted for '$val_name'"
  fi
}
