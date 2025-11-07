#!/bin/sh

BUILD=build.sh
COLORS=colors.sh
EXE=libshout.sh
HELP=help.sh
PALESTINE=Palestine.sh
RAINBOW=rainbow.sh
SOURCE=source
TEST=test.sh
BENCH=bench.sh

build() {
  "$ENTRY/$BUILD" >"$ENTRY/$EXE"
}

case "$1" in
"${SOURCE}")
  . "$ENTRY/$COLORS"
  build
  printf '%s\n' "${_gry}eval the whole output of this command: ${_yel}'eval \$(shoutctl source 2>/dev/null)'${_gry}. These grey lines will not be sourced as they go to stderr.${_res}" >&2
  printf '. %s; ' "$ENTRY/$COLORS" "$ENTRY/$EXE"
  ;;
"${TEST%.sh}")
  "$ENTRY/$TEST"
  ;;
"${BENCH%.sh}")
  shift
  "$ENTRY/$BENCH" "$@"
  ;;
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
${_mag}Description${_res}:
  ${_yel}shoutctl${_res} - a little helper to interact with shout and source the libs easily.

${_mag}Usage${_res}:

${_BLA}${_mag}\`\`\`${_yel}sh${_grn}                                 ${_res}${_gry}# Admire the fake terminal theme!
${_BLA}${_grn}% eval \$(shoutctl source)             ${_res}${_gry}# Source and that's it! You can shout! (see shoutctl help for details)
${_BLA}${_grn}% eval \$(shoutctl source 2>/dev/null) ${_res}${_gry}# Same but silent.
${_BLA}${_grn}% shoutctl [COMMAND]                  ${_res}${_gry}# See other commands!
${_BLA}${_mag}\`\`\`                                   ${_res}${_gry}# Look into ${_yel}./shoutctl.sh${_gry} to see how it's done!${_res}

${_mag}COMMAND${_res}:
  ${_yel}help${_res}                Print help for ${_RED}${_def}${_bol} THE ACTUAL ${_res} libshout.
  ${_yel}source${_res}              Print the command to source libshout.
  ${_yel}test${_res}                Run the tests.
  ${_yel}bench BENCH_METHOD${_res}  Run a bench test
  ${_yel}rainbow${_res}             Print an indexed rainbow of 256 colors. (no worries. it's compact)
  ${_yel}[Pp]alestine${_res}        Print the Palestinian flag.
  ${_yel}[*]${_res}                 Print this message.
EOF
  ;;
esac
