#!/usr/bin/env dash

res="[0m"
bol="[1m"
red="[38;5;1m"
grn="[38;5;2m"
yel="[38;5;3m"
blu="[38;5;4m"
mag="[38;5;5m"
cya="[38;5;6m"
whi="[38;5;7m"
gry="[38;5;8m"
def="[38;5;15m"

_shoutHelp() {
  cat <<EOF
$bol                        $red        :
$grn             .          $red       t#,    :
$grn            ;W.    .    $red      ;##W.   Ef
$grn           f#Ef    Dt   $red     :#L:WE   E#t  GEEEEEEEL
$grn         .E#f  ai  E#i  $red    .KG  ,#D  E#t  ,;;L#K;;.
$grn        iWW;  E#t  E#t  $red    EE    ;#f E#t     t#E
$grn       L##LffiE#t  E#t  $red   f#.     t#iE#t  i  t#E
$grn      tLLG##L E########f$red  .:#G     GK E#t .#j t#E
$grn        ,W#i  E#j..K#j..$red    ;#L   LW. E#t ;#L t#E
$grn       j#E.   E#t  E#t  $red     t#f f#:  E#tf#E: t#E
$grn     .D#j     E#t  E#t  $red      f#D#;   E###f   t#E
$grn    ,WK,      f#t  f#t  $red       G#t    E#K,    t#E
$grn    EG.        ii   ii  $red        t     EL       fE
$grn    ,                   $red              :         :

                      ${def}v0.1.0${res}

Description:
  multi-modal logger taking options and colors.

Usage:
  ./shout.sh [ANYTHING]        $gry# print this message$res
  . ./shout.sh                 $gry# source the lib$res
  shout OPT_STRING [ARGUMENTS] $gry# line mode$res
  command | shout OPT_STRING   $gry# stream mode$res

Environments:
  ${yel}SHOUT_ENABLED${res} - global logging switch. Can be bypassed with ${yel}F$res opt.

OPT_STRING:
  Must come with the form: "${yel}[FA][color]$res" where:

  ${yel}A$res: pretty prints positional arguments. Only work in ${bol}line-mode$res

  ${yel}F$res: force prints to stderr (i.e. bypass ${yel}SHOUT_ENABLED$res)

Supported log modes:
  - Single line: prints "\$@" to stderr after shifting the options string.
  - Stream     : forwards stdin to stdout and tees a colorized copy to stderr.

Examples:
  ${gry}# This prints red logs in red to stderr even if SHOUT_ENABLED is off${res}
  shout "F.\$red"
  ${gry}# This prints in grey to stderr even if SHOUT_ENABLED is off and forwards to myNextProcess$res
  echo "streamed text" | shout F | myNextProcess

Included colors: $gry(you can define and pass your own...)$def

$gry  - \$gry (default for logging) $red  - \$red $grn  - \$grn $yel  - \$yel $blu  - \$blu $mag  - \$mag $cya  - \$cya $whi  - \$whi $def  - \$def

Included modifiers:

$bol  - \$bol$gry bold combines with any color.
$res  - \$res$gry resets everything.$res
EOF
}

shout() {
  local options force color
  options=$1
  shift

  # parse color or fallback
  color=${options##*[FA]}
  : "${color:=$gry}"

  # parse mode flags
  [ "${options##*F}" != "$options" ] && force=1

  if [ "$SHOUT_ENABLED" ] || [ -n "$force" ]; then
    if [ -t 0 ]; then                             # interactive mode
      if [ "${options##*A}" != "$options" ]; then # args mode
        _shoutargs "$color" "$@"
      else
        _shoutline "$color" "$@" # line mode
      fi
    else # stream mode
      printf '%s' "$color" >&2
      cat | tee /dev/stderr
      printf '%s' "$res" >&2
    fi
  fi
}

_shoutargs() { # log positional arguments
  color=${1:-$gry}
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
  printf "%s%s%s\n" "${color}" "$*" "${res}" >&2
}

_redact() { # remove sensitive or noisy output
  sed 's/--oauth2-bearer [^ ]*/--oauth2-bearer <MY_TOKEN>/gi'
}

${1:+_shoutHelp "$@"}
