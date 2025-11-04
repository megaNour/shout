#!/bin/sh

COLORS=colors.sh
EXE=libshout.sh
HELP=help.sh
PALESTINE=Palestine.sh
RAINBOW=rainbow.sh
SOURCE=source
TEST=test.sh

case "$1" in
"${SOURCE%.sh}")
  . "$ENTRY/$COLORS"
  printf '%s\n' "${_gry}eval the whole output of this command: $_yel'eval \$(shoutctl source 2>/dev/null)'${_gry}. These grey lines will not be sourced as they go to stderr.$_res" >&2
  printf '. %s; . %s' "$ENTRY/$COLORS" "$ENTRY/$EXE"
  ;;
"${TEST%.sh}") "$ENTRY/$TEST" ;;
"${HELP%.sh}")
  . "$ENTRY/$COLORS"
  . "$ENTRY/$HELP"
  ;;
"${PALESTINE%.sh}" | palestine)
  . "$ENTRY/$COLORS"
  . "$ENTRY/$PALESTINE"
  ;;
"${RAINBOW%.sh}")
  . "$ENTRY/$COLORS"
  . "$ENTRY/$RAINBOW"
  ;;
*)
  . "$ENTRY/$COLORS"
  cat <<EOF
${_mag}Description$_res:
  ${_yel}shoutctl$_res - a little helper to interact with shout and source the libs easily.

${_mag}Usage$_res:
  ${_yel}shoutctl [COMMAND]$_res

${_mag}COMMAND$_res:
  ${_yel}[Pp]alestine$_res      Print the Palestinian flag.
  ${_yel}help$_res              Print help for libshout.
  ${_yel}source$_res            Print the command to source libshout.
  ${_yel}rainbow$_res           Print an indexed rainbow of 256 colors. (no worries. it's compact)
  ${_yel}[*]$_res               Print this message.

${_mag}How to use$_res:
. \$(shoutctl source) $_gry# that's it! You can shout! (see shoutctl help for details)$_res
EOF
  ;;
esac
