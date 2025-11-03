#!/bin/sh

_res="[0m" # reset all
_bol="[1m" # bold

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

_shoutHelp() {
  cat <<EOF
$_bol                        $_red        :
$_grn             .          $_red       t#,    :
$_grn            ;W.    .    $_red      ;##W.   Ef
$_grn           f#Ef    Dt   $_red     :#L:WE   E#t  GEEEEEEEL
$_grn         .E#f  ai  E#i  $_red    .KG  ,#D  E#t  ,;;L#K;;.
$_grn        iWW;  E#t  E#t  $_red    EE    ;#f E#t     t#E
$_grn       L##LffiE#t  E#t  $_red   f#.     t#iE#t  i  t#E
$_grn      tLLG##L E########f$_red  .:#G     GK E#t .#j t#E
$_grn        ,W#i  E#j..K#j..$_red    ;#L   LW. E#t ;#L t#E
$_grn       j#E.   E#t  E#t  $_red     t#f f#:  E#tf#E: t#E
$_grn     .D#j     E#t  E#t  $_red      f#D#;   E###f   t#E
$_grn    ,WK,      f#t  f#t  $_red       G#t    E#K,    t#E
$_grn    EG.        ii   ii  $_red        t     EL       fE
$_grn    ,                   $_red              :         :
                        $_RED $_bol${_def}v0.1.0 $_res

Multi-modal logger taking switches log level and colors in a single ${_yel}OPT_STRING$_res.

${_mag}Philosophy:$_res
  - No background process
  - No runtime # ${_gry}shout is part of your shell process$_res
  - No subprocess # ${_gry}ok except cat | tee in stream-mode$_res
  - No JIT values # ${_gry}no \$(whatevere)$_res

${_mag}Usage:$_res
  ./shout.sh [ANYTHING]        $_gry# print this message$_res
  . ./shout.sh                 $_gry# source the lib$_res
  shout ${_yel}OPT_STRING$_res [ARGUMENT...] $_gry# line mode$_res
  command | shout ${_yel}OPT_STRING$_res   $_gry# stream mode$_res

${_mag}Environments:$_res ${_gry}You can use the following$_res
  ${_yel}SHOUT_ENABLED$_res - global logging switch. Can be bypassed with ${_yel}f$_res opt.
  ${_yel}SHOUT_LEVEL$_res - the minimal log level accepted. Can be bypassed with ${_yel}f$_res opt.
  ${_yel}SHOUT_KNOWN_LEVEL_ONLY$_res - discards logs with no level. Can be bypassed with ${_yel}f$_res opt.

${_mag}OPT_STRING:$_res ${_yel}[LOG_LEVEL|SWITCH...][COLOR...]$_res $_gry# see predefined colors at the bottom$_res

${_mag}SWITCH:$_res ${_gry}# combinable
  $_bol${_yel}h$_res: display this message
  $_bol${_yel}p$_res: display Palestine flag.
  $_bol${_yel}r$_res: display 256 colors with their index. (no worries, it's compact)
    Not all those colors are predefined. This is just a visual help for defining your own.
    Predefined colors are at the bottom.
  $_bol${_yel}a$_res: pretty print positional arguments.
  $_bol${_yel}f$_res: force print to stderr (i.e. bypass ${_yel}SHOUT_ENABLED$_res)

${_mag}LOG_LEVEL:$_res $_gry# single number$_res
  > 0 integer indicating the criticity of your log. It is the first number found in your ${_yel}OPT_STRING$_res.

${_mag}COLOR:$_res $_gry# combinable$_res
  Color sequences are passed at the end of the ${_yel}OPT_STRING$_res. They must be of the form starting with "^[".
  Preset colors are included. $_gry# See at the bottom$_res

${_mag}Supported log modes:$_res
  - ${_yel}line-mode$_res:      prints "\$@" to stderr after shifting the optstring.
  - ${_yel}stream-mode$_res:    forwards stdin to stdout and tees a colorized copy to stderr.

${_mag}Examples:$_res
  ${_gry}# This prints red logs in red to stderr even if SHOUT_ENABLED is off${_res}
  shout "f.\$_red"
  ${_gry}# This prints in grey to stderr if SHOUT_LEVEL <= 5 and forwards to myNextProcess$_res
  echo "streamed text" | shout 5 | myNextProcess

${_mag}Included colors:$_res $_gry(you can define and pass your own...)$_def
foregrounds: $_gry\$_gry # default for logging$_red \$_red$_grn \$_grn$_yel \$_yel$_blu \$_blu$_mag \$_mag$_cya \$cya$_whi \$_whi$_def \$_def $_def$_DEF$_bla \$bla $_res $_gry # the white background is just for visibility here$_res
backgrounds: $_GRY\$_GRY $_RED \$_RED $_GRN$_bla \$_GRN $_YEL \$_YEL $_BLU \$_BLU $_MAG \$_MAG $_CYA \$CYA $_WHI \$_WHI $_DEF \$_DEF $_BLA$_def \$_BLA$_res$_gry # everything combines$_res
modifiers:   $_bol\$_bol$_gry # bold combines with any color$_res
finally:     \$_res$_gry # resets everything.$_res
EOF
}

shout() {
  unset optstring_without_color color level force
  optstring=$1
  shift

  optstring_without_color=${optstring%%*}

  # terminal switches
  if [ "${optstring_without_color#*h}" != "$optstring_without_color" ]; then _shoutHelp && return 0; fi
  if [ "${optstring_without_color#*r}" != "$optstring_without_color" ]; then _shoutRainbow && return 0; fi
  if [ "${optstring_without_color#*p}" != "$optstring_without_color" ]; then _shoutPalestine && return 0; fi

  if [ "${optstring_without_color#*f}" != "$optstring_without_color" ]; then force=1; fi
  if [ ! "$SHOUT_ENABLED" ] && [ -z "$force" ]; then return 0; fi

  if [ -z "$force" ]; then                                         # further checks needed on log level
    level=${optstring_without_color%%[^0-9]*}                      # the first number only is the level
    level=${level#*[^0-9]}                                         # it can be before or after switches
    if { [ -n "$SHOUT_KNOWN_LEVEL_ONLY" ] && [ -z "$level" ]; } || # check if level-less logs are rejected or...
      { [ -n "$level" ] &&                                         # if there is a level
        [ "$level" -gt 0 ] 2>/dev/null &&                          # and it's > 0
        [ "$level" -lt "$SHOUT_LEVEL" ]; }; then                   # and it's inferior to SHOUT_LEVEL
      return 0                                                     # then abort
    fi
  fi

  # check there is a color
  if [ "${optstring#*}" != "$optstring" ]; then
    color=${optstring#*} # remove everything prepending eventual colors. the only safe stop is the escape char.
    color="$color"       # so we add it back (only) if there is a color
  fi
  : "${color:=$_gry}" # otherwise fallback to grey

  if [ -t 0 ]; then                                                            # line mode
    if [ "${optstring_without_color#*a}" != "$optstring_without_color" ]; then # args switch
      _shoutArgs "$color" "$@"
    else # regular line
      _shoutLine "$color" "$@"
    fi
  else # stream mode
    printf '%s' "$color" >&2
    cat | tee /dev/stderr
    printf '%s' "$_res" >&2
  fi
}

_shoutArgs() { # log positional arguments indexed
  color=${1:-$_gry}
  shift
  i=0
  for arg in "$@"; do
    i=$((i + 1))
    _shoutLine "$color" "\$$i: $arg"
  done
}

_shoutLine() { # log positional arguments inline
  color=$1
  shift
  printf "%s%s%s\n" "${color}" "$*" "${_res}" >&2
}

_shoutRainbow() {
  i=0
  while [ "$i" -lt 256 ]; do
    printf '%s ' "[38;5;${i}m$i${_res}"
    i=$((i + 1))
  done
  printf "%s\n" "$_res"
}

_shoutPalestine() {
  cat <<EOF
$_BLA${_red}◣                                                                               $_res
$_BLA${_red}█◣                                                                              $_res
$_BLA${_red}██◣                                                                             $_res
$_BLA${_red}███◣                                                                            $_res
$_BLA${_red}████◣                                                                           $_res
$_BLA${_red}█████◣                                                                          $_res
$_DEF${_red}██████◣                                                                         $_res
$_DEF${_red}███████◣                                                                        $_res
$_DEF${_red}████████◣                                                                       $_res
$_DEF${_red}████████◤                                                                       $_res
$_DEF${_red}███████◤                                                                        $_res
$_DEF${_red}██████◤                                                                         $_res
$_GRN${_red}█████◤                                                                          $_res
$_GRN${_red}████◤                                                                           $_res
$_GRN${_red}███◤                                                                            $_res
$_GRN${_red}██◤                                                                             $_res
$_GRN${_red}█◤                                                                              $_res
$_GRN${_red}◤                                                                               $_res
EOF
}

${1:+_shoutHelp}
