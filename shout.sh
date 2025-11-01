#!/usr/bin/env dash

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
grey=$(tput setaf 8)
default=$(tput setaf 15)
bold=$(tput bold)
reset=$(tput sgr 0)

shoutHelp() {
  cat <<EOF
$bold                         $red       :
$green             .          $red       t#,    :
$green            ;W.    .    $red      ;##W.   Ef
$green           f#Ef    Dt   $red     :#L:WE   E#t  GEEEEEEEL
$green         .E#f  ai  E#i  $red    .KG  ,#D  E#t  ,;;L#K;;.
$green        iWW;  E#t  E#t  $red    EE    ;#f E#t     t#E
$green       L##LffiE#t  E#t  $red   f#.     t#iE#t  i  t#E
$green      tLLG##L E########f$red  .:#G     GK E#t .#j t#E
$green        ,W#i  E#j..K#j..$red    ;#L   LW. E#t ;#L t#E
$green       j#E.   E#t  E#t  $red     t#f f#:  E#tf#E: t#E
$green     .D#j     E#t  E#t  $red      f#D#;   E###f   t#E
$green    ,WK,      f#t  f#t  $red       G#t    E#K,    t#E
$green    EG.        ii   ii  $red        t     EL       fE
$green    ,                   $red              :         :

                      ${default}v0.1.0${reset}

Description:
  multi-modal logger taking options and colors.

Usage:
  ./shout.sh [ANYTHING]        ${grey}# print this message${reset}
  . ./shout.sh                 ${grey}# source the lib${reset}
  shout OPT_STRING [ARGUMENTS] ${grey}# line mode${reset}
  command | shout OPT_STRING   ${grey}# stream mode${reset}

Environments:
  ${yellow}DEBUG_ENABLED${reset} - global logging switch. Can be bypassed with ${yellow}F${reset} opt.

OPT_STRING:
  Must come with the form: "${yellow}[FA][color]${reset}" where:

  ${yellow}A${reset}: pretty prints positional arguments. Only work in ${bold}line-mode${reset}

  ${yellow}F${reset}: force prints to stderr (i.e. bypass ${yellow}DEBUG_ENABLED${reset})

Supported log modes:
  - Single line: prints "\$@" to stderr after shifting the options string.
  - Stream     : forwards stdin to stdout and tees a colorized copy to stderr.

Examples:
  ${grey}# This prints red logs in red to stderr even if DEBUG_ENABLED is off${reset}
  shout "F.\$red"
  ${grey}# This prints in grey to stderr even if DEBUG_ENABLED is off and forwards to myNextProcess${reset}
  echo "streamed text" | shout F | myNextProcess

Included colors:

${grey}  - \$grey (default)
${red}  - \$red
${green}  - \$green
${yellow}  - \$yellow
${blue}  - \$blue
${magenta}  - \$magenta
${cyan}  - \$cyan
${white}  - \$white
${default}  - \$default${reset}

Included modifiers:

${bold}  - \$bold combines with any of them.
${reset}  - \$reset resets everything.
EOF
}

shout() {
  local options force color
  options=$1
  shift

  # parse color or fallback
  color=${options##*[FA]}
  : "${color:=$grey}"

  # parse mode flags
  [ "${options##*F}" != "$options" ] && force=1

  if [ "$DEBUG_ENABLED" ] || [ -n "$force" ]; then
    # single line mode
    if [ -t 0 ]; then
      if [ "${options##*A}" != "$options" ]; then # arg mode
        shoutargs "$color" "$@"
      else
        shoutline "$color" "$@"
      fi
    else # stream mode
      printf '%s' "$color" >&2
      cat | tee /dev/stderr
      printf '%s' "$reset" >&2
    fi
  fi
}

# log positional arguments
shoutargs() {
  color=${1:-$grey}
  shift
  i=0
  for arg in "$@"; do
    i=$((i + 1))
    shoutline "$color" "\$$i: $arg"
  done
}

# log positional arguments inline
shoutline() {
  color=$1
  shift
  printf "%s%s%s\n" "${color}" "$*" "${reset}" >&2
}

# remove sensitive or noisy output
redact() {
  sed 's/--oauth2-bearer [^ ]*/--oauth2-bearer <MY_TOKEN>/gi'
}

# Display help only if any argument is passed.
${1:+shoutHelp "$@"}
