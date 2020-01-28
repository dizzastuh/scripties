#!/bin/bash

#######################################################
##################     FUNCTIONS     ##################
#######################################################

function validate_file() {
  local file=$1
  
  if [ ! -f $file ]; then
    echo "No file $file found.  Exiting."
  fi  
}

function validate_val() {
  local $val_name=$1
  local $val=$2

  if [ -z "$val" ] || [ "$val" == "null" ] ; then
    echo "Value was empty or null.  Exiting."
  fi
}