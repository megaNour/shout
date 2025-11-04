#!/bin/sh

_res="[0m"  # reset all
_bol="[1m"  # bold
_rev="[7m"  # reverse mode
_REV="[27m" # noreverse mode

# foregrounds
_red="[38;5;1m"
_grn="[38;5;2m"
_yel="[38;5;3m"
_blu="[38;5;4m"
_mag="[38;5;5m"
_cya="[38;5;6m"
_whi="[38;5;7m"
_gry="[38;5;8m"
_def="[38;5;15m"
_bla="[38;5;16m"

# backgrounds
_RED="[48;5;1m"
_GRN="[48;5;2m"
_YEL="[48;5;3m"
_BLU="[48;5;4m"
_MAG="[48;5;5m"
_CYA="[48;5;6m"
_WHI="[48;5;7m"
_GRY="[48;5;8m"
_DEF="[48;5;15m"
_BLA="[48;5;16m"

# If value is set and not null, keep it as the user customized it.
# If value is unset, set the default as the user may not know about it.
# If value was set to null, keep it null. It means the user wants it that way.
SHOUT_COLOR=${SHOUT_COLOR=$_gry}
# The default args color follows the same logic and fallsback to the same value.
SHOUT_ARGS_COLOR=${SHOUT_ARGS_COLOR=$_gry}
# The default stream color follows the same logic and fallsback to the same value.
SHOUT_STREAM_COLOR=${SHOUT_STREAM_COLOR=$_gry}
