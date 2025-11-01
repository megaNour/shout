#!/bin/sh

_res="[0m"
_bol="[1m"
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
_RED="[48;5;1m"
_GRN="[48;5;2m"
_YEL="[48;5;3m"
_BLU="[48;5;4m"
_MAG="[48;5;5m"
_CYA="[48;5;6m"
_WHI="[48;5;7m"
_GRY="[48;5;8m"
_DEF="[48;5;15m"

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

                      ${_def}v0.1.0$_res

Description:
  multi-modal logger taking optstring and colors.

Usage:
  ./shout.sh [ANYTHING]        $_gry# print this message$_res
  . ./shout.sh                 $_gry# source the lib$_res
  shout OPT_STRING [ARGUMENTS] $_gry# line mode$_res
  command | shout OPT_STRING   $_gry# stream mode$_res

Environments:
  ${_yel}SHOUT_ENABLED$_res - global logging switch. Can be bypassed with ${_yel}f$_res opt.

OPT_STRING:
  Must come with the form: "${_yel}[switches][colors]$_res" where switches are: $_gry# see predefined colors at the bottom

  ${_yel}h$_res: display this message

  ${_yel}a$_res: pretty prints positional arguments. Only work in ${_bol}line-mode$_res

  ${_yel}f$_res: force prints to stderr (i.e. bypass ${_yel}SHOUT_ENABLED$_res)

  ${_yel}r$_res: display 256 colors with their index. (no worries, it's compact)

Supported log modes:
  - Single line: prints "\$@" to stderr after shifting the optstring string.
  - Stream     : forwards stdin to stdout and tees a colorized copy to stderr.

Examples:
  ${_gry}# This prints red logs in red to stderr even if SHOUT_ENABLED is off${_res}
  shout "f.\$_red"
  ${_gry}# This prints in grey to stderr even if SHOUT_ENABLED is off and forwards to myNextProcess$_res
  echo "streamed text" | shout f | myNextProcess

Included colors: $_gry(you can define and pass your own...)$_def

foregrounds: $_gry\$_gry (default for logging)$_red \$_red$_grn \$_grn$_yel \$_yel$_blu \$_blu$_mag \$_mag$_cya \$cya$_whi \$_whi$_def \$_def $_def$_bla \$bla$_res
backgrounds: $_GRY \$_GRY $_RED \$_RED $_GRN$_bla \$_GRN $_YEL \$_YEL $_BLU \$_BLU $_MAG \$_MAG $_CYA \$CYA $_WHI \$_WHI $_DEF \$_DEF$_res$_gry # everything combines$_res

Included modifiers:

$_bol  - \$_bol$_gry bold combines with any color.
$_res  - \$_res$_gry resets everything.$_res
EOF
}

shout() {
  optstring=$1
  shift

  # terminal flags
  [ "${optstring##*h}" != "$optstring" ] && _shoutHelp && return 0
  [ "${optstring##*r}" != "$optstring" ] && _rainbow && return 0

  # parse color or fallback
  color=${optstring##*[fa]}
  : "${color:=$_gry}"

  # parse mode flags
  [ "${optstring##*f}" != "$optstring" ] && force=1

  if [ "$SHOUT_ENABLED" ] || [ -n "$force" ]; then
    if [ -t 0 ]; then                                 # interactive mode
      if [ "${optstring##*a}" != "$optstring" ]; then # args mode
        _shoutargs "$color" "$@"
      else
        _shoutline "$color" "$@" # line mode
      fi
    else # stream mode
      printf '%s' "$color" >&2
      cat | tee /dev/stderr
      printf '%s' "$_res" >&2
    fi
  fi
}

_shoutargs() { # log positional arguments
  color=${1:-$_gry}
  shift
  i=0
  for arg in "$@"; do
    i=$((i + 1))
    _shoutline "$color" "\$$i: $arg"
  done
}

_shoutline() { # log positional arguments inline
  color=$1
  shift
  printf "%s%s%s\n" "${color}" "$*" "${_res}" >&2
}

_rainbow() {
  i=0
  while [ "$i" -lt 256 ]; do
    printf '%s ' "[38;5;${i}m$i${_res}"
    i=$((i + 1))
  done
  printf "%s\n" "$_res"
}

_redact() { # WIP remove sensitive or noisy output
  sed 's/--oauth2-bearer [^ ]*/--oauth2-bearer <MY_TOKEN>/gi'
}

${1:+_shoutHelp "$@"}
