###############################
#          common.sh          #
###############################
#
# A collection of commonly used bash functions
# and variables to reduce reused code in many
# bash scripts
#
# decaby7e - 2020.01.21


#~#~#~#~#~#~#~#~#~#~#~#
#      Variables      #
#~#~#~#~#~#~#~#~#~#~#~#

## Color Variables ##

RED='\033[0;31m'    # Red
L_RED='\033[1;31m'  # Light red
YELLOW='\033[1;33m' # Yellow
WHITE='\033[1;34m'  # White
ORANGE='\033[0;33m' # Orange
NC='\033[0m'        # No Color

## Path Variables ##

#
# Return the full path of a running script
#
SCRIPT_PATH=$(dirname $(realpath -s $0))


#~#~#~#~#~#~#~#~#~#~#~#
#      Functions      #
#~#~#~#~#~#~#~#~#~#~#~#


## Logging Variables ##

#
# For use when debugging scripts. Should be removed
# in production scripts...
#
# Usage: debug "Debug Message"
#
debug(){
  printf '\033[0;33m'[ DEBUG ]'\033[0m' $1\n"
}

#
# For use with any kind of common info to be
# displayed to the terminal. Should allow for
# sparse use of printf and echo in giving the
# user information.
#
# Usage: info "Information Message"
#
info(){
  printf "'\033[1;34m'[ INFO ]'\033[0m' $1\n"
}

#
# Warn the user of a serious error but one
# that is not serious enough to cause a crash
#
# Usage: warn "Warning Message"
#
warn(){
  printf "'\033[1;33m'[WARNING]'\033[0m' $1\n"
}

#
# Warn the user of a script-breaking crash
# then immediatly exit
#
# Usage: fatal "Error Message"
#
fatal(){
  printf "'\033[0;31m'[ FATAL ] $1\n"
  exit 1
}

## Checks ##

#
# Will check if user is root. If not, it will throw
# a fatal error and notify the user to use root.
#
# Usage: root_check
#
root_check(){
  if [ "$EUID" -ne 0 ]; then
    fatal "Must be run as root."
  fi
}

#
# Will lock a script to prevent several instances running
# at the same time.
# 
# Alternative in one line from http://man7.org/linux/man-pages/man1/flock.1.html
#
# [ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock -en "$0" "$0" "$@" || :
#
# Usage: lock_self
# 
#
lock_self(){
  LOCK_FILE=a.lock
  exec 100>"$LOCK_FILE"
  flock -n 100 ||\
  fatal "Script currently running."
}
