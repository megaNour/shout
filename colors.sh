#!/bin/sh

export _res="[0m"  # reset all
export _bol="[1m"  # bold
export _rev="[7m"  # reverse mode
export _ver="[27m" # noreverse mode

# foregrounds
export _red="[38;5;1m"
export _grn="[38;5;2m"
export _yel="[38;5;3m"
export _blu="[38;5;4m"
export _mag="[38;5;5m"
export _cya="[38;5;6m"
export _whi="[38;5;7m"
export _gry="[38;5;8m"
export _def="[38;5;15m"
export _bla="[38;5;16m"

# backgrounds
export _RED="[48;5;1m"
export _GRN="[48;5;2m"
export _YEL="[48;5;3m"
export _BLU="[48;5;4m"
export _MAG="[48;5;5m"
export _CYA="[48;5;6m"
export _WHI="[48;5;7m"
export _GRY="[48;5;8m"
export _DEF="[48;5;15m"
export _BLA="[48;5;16m"

# If value is set and not null, keep it as the user customized it.
# If value is unset, set the default as the user may not know about it.
# If value was set to null, keep it null. It means the user wants it that way.
export SHOUT_COLOR=${SHOUT_COLOR=$_gry}
# The default args color follows the same logic and fallsback to the same value.
export SHOUT_ARGS_COLOR=${SHOUT_ARGS_COLOR=$_gry}
# The default stream color follows the same logic and fallsback to the same value.
export SHOUT_STREAM_COLOR=${SHOUT_STREAM_COLOR=$_gry}
