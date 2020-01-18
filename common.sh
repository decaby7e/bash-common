###############################
#          common.sh          #
###############################
#
# A collection of commonly used bash functions
# and variables to reduce reused code in many
# bash scripts
#
# decaby7e - 2020.01.17


#~#~#~#~#~#~#~#~#~#~#~#
#      Variables      #
#~#~#~#~#~#~#~#~#~#~#~#


## Path Variables ##

#
# Return the full path of a running script
#
REL_PATH="`dirname \"$0\"`"
FULL_PATH="`( cd \"$REL_PATH\" && pwd )`"


#~#~#~#~#~#~#~#~#~#~#~#
#      Functions      #
#~#~#~#~#~#~#~#~#~#~#~#


## Logging Variables ##

#
# Warn the user of a serious error but one
# that is not serious enough to cause a crash
#
# Usage: warn "Warning Message"
#
warn(){
  echo "[WARNING] $1"
}

#
# Warn the user of a script-breaking crash
# then immediatly exit
#
# Usage: fatal "Error Message"
#
fatal(){
  echo "[ FATAL ] $1"
  exit 1
}


## Try-Catch Functions ##

#
# Will attempt to run a command. On faliure,
# the specified execption is run. Should both
# fail, a fatal error is thrown.
#
# Usage: try "helloworld" "echo 'Oops! That command isn\'t real \:\\' "
#
try(){
  sh -c $1 ||\
  sh -c $2 ||\
  fatal "Failed exception!"
}

## Privilage Checks ##

#
# Will check if user is root. If not, it will throw
# a fatal error and notify the user to use root.
#
# Usage: is_root
#
is_root(){
  if [ "$EUID" -ne 0 ]; then
    fatal "Must be run as root."
  fi
}
