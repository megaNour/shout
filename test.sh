#!/bin/sh

set -e

# reinit

OLD_SHOUT_COLOR=$SHOUT_COLOR
OLD_SHOUTARGS_COLOR=$SHOUTARGS_COLOR
OLD_SHOUT_STREAM_COLOR=$SHOUT_STREAM_COLOR

cleanup() {
  SHOUT_COLOR=${OLD_SHOUT_COLOR}
  SHOUT_ARGS_COLOR=$OLD_SHOUT_ARGS_COLOR
  SHOUT_STREAM_COLOR=$OLD_SHOUT_STREAM_COLOR
  eval "$(shoutctl source 2>/dev/null)"
}

trap 'cleanup' EXIT TERM INT QUIT

# init

res="[0m"
red="[38;5;1m"
grn="[38;5;2m"
yel="[38;5;3m"
blu="[38;5;4m"
mag="[38;5;5m"
cya="[38;5;6m"
whi="[38;5;7m"
gry="[38;5;8m"
def="[38;5;15m"
bla="[38;5;16m"
tut="[38;5;22m" # tutorial color
RED="[48;5;1m"
GRN="[48;5;2m"
CYA="[48;5;6m"

assert() {
  actual=$(printf '%s' "$1" | od -ta)
  expected=$(printf '%s' "$2" | od -ta)
  if [ "$actual" = "$expected" ]; then
    printf "%s%s%s\n\n" "$grn" "Test passed!" "$res" >&2
  else
    {
      printf "%s%s%s\n" "$red" "Test failed!" "$res"
      printf "\nExpected:\n"
      cat <<EOF
$expected
EOF
      printf "\nActual:\n"
      cat <<EOF
$actual
EOF
    } >&2
    return 1
  fi
}

run() {
  run_test=$1
  run_expected=$2

  printf '%% %s\n' "$run_test"         # - indicate what's going to happen
  run_actual=$(eval "$run_test" 2>&1)  # - capture stdr or you will get nothing
  printf '%s\n' "$run_actual"          # - display the captured result
  assert "$run_actual" "$run_expected" # - check

  unset test expected actual
}

# start testing

eval $(shoutctl source 2>/dev/null)

test='shout 0 "This is a default grey log. $_CYA${_bla}Notice$_res$_gry 0 is the (most critical) log level, which is mandatory with simple shout."'
expected=$(printf "%s" "${gry}This is a default grey log. $CYA${bla}Notice$res$gry 0 is the (most critical) log level, which is mandatory with simple shout.$_res")
run "$test" "$expected"

test='shoutf "${_red}This is a red line log.$_grn You$_yel can$_blu change$_mag the$_cya color$_whi by$_def inserting your own escape sequences. They will be preserved."'
expected=$(printf "%s" "$gry${red}This is a red line log.$grn You$yel can$blu change$mag the$cya color$whi by$def inserting your own escape sequences. They will be preserved.$res")
run "$test" "$expected"

printf '%s\n' "% SHOUT_COLOR=\$_red $tut# Let's define the default color to red.$_res"
SHOUT_COLOR=$_red
printf '%s\n' "% eval \$(shoutctl source 2>/dev/null) $tut# shout is precompiled to be more efficient. We need to source it again.$_res"
eval $(shoutctl source 2>/dev/null)

test='shoutf "This is a default red line log."'
expected=$(printf "%s" "${red}This is a default red line log.$res")
run "$test" "$expected"

printf '%s\n' "% SHOUT_COLOR= \$(shoutctl source) $tut# You can also opt out of default color by setting it to null!$res"
SHOUT_COLOR=
printf '%s\n' "% eval \$(shoutctl source 2>/dev/null) $tut# don't forget to refresh$_res"
eval $(shoutctl source 2>/dev/null)
printf '%s\n' "$bol${yel}Yes,$res$tut I know you can \"${grn}eval '\$(SHOUT_COLOR=\$_foo shoutctl source 2>/dev/null)'$tut\". But I wanted to make the env setting easy to spot." "${yel}On the opposite,$tut this will not work: \"${red}SHOUT_COLOR=\$_foo eval '\$(shoutctl source)'$tut\". The subshell will expand before the env is ever set up."

test='shoutf "This is printed in regular color :'\''("'
expected=$(printf "%s" "This is printed in regular color :'($res")
run "$test" "$expected"

printf '%s\n' "% SHOUT_COLOR=\$_gry"
SHOUT_COLOR=$_gry
printf '%s\n' "% eval \$(shoutctl source 2>/dev/null) $tut# I bet you forgot to refresh...$_res"
eval $(shoutctl source 2>/dev/null)

test='shoutf "This is printed in grey :)"'
expected=$(printf "%s" "${gry}This is printed in grey :)$res")
run "$test" "$expected"

printf '%s\n' "% SHOUT_DISABLED=1"
SHOUT_DISABLED=1

test='shout 1 "${_yel}SHOUT_DISABLED$_gry applies to leveled shout. Not shout?f."'
expected=
run "$test" "$expected"

test='shoutaf This is a positional arg log.'
expected="$gry\$1: This$res
$gry\$2: is$res
$gry\$3: a$res
$gry\$4: positional$res
$gry\$5: arg$res
$gry\$6: log.$res"
run "$test" "$expected"

test='shouta 0 needs a level as well, but it will not show anyway while SHOUT_DISABLED=1'
expected=
run "$test" "$expected"

printf '%s\n' "% SHOUT_STREAM_COLOR=\$_RED\$_bla ${tut}# there is a stream color defaulting to ${yel}SHOUT_COLOR$tut that you can utilize.$res"
SHOUT_STREAM_COLOR=$_RED$_bla
printf '%s\n' "% eval \$(shoutctl source 2>/dev/null) $tut# I know I know, you wanted to tell me to refresh...$_res"
eval $(shoutctl source 2>/dev/null)

test='printf "%s" "This is streamed and forced to stdout and stderr. Thus, you see it twice." | shoutsf'
expected="$RED${bla}This is streamed and forced to stdout and stderr. Thus, you see it twice.This is streamed and forced to stdout and stderr. Thus, you see it twice.$res"
run "$test" "$expected"

printf "%s\n" "% SHOUT_DISABLED=\"\" SHOUT_LEVEL=5"
SHOUT_DISABLED=1

test='printf "%s" "This is streamed to stdout only as logs are disabled. Thus, you see it once." | shouts 42'
expected="This is streamed to stdout only as logs are disabled. Thus, you see it once."
run "$test" "$expected"

printf "%s\n" "% SHOUT_DISABLED=\"\" SHOUT_LEVEL=5"
SHOUT_DISABLED="" SHOUT_LEVEL=5

test='shout 5 This is a level 5 log, it can pass!'
expected="${gry}This is a level 5 log, it can pass!$res"
run "$test" "$expected"

test='shout 6 This is a level 6 log, it cannot display, just like for shouta and shouts!'
expected=
run "$test" "$expected"

test='shoutf Now the terrible truth:\
 multiline strings will end up on one line.'
expected=$(
  printf '%s' "${gry}Now the terrible truth: multiline strings will end up on one line.$res"
)
run "$test" "$expected"

printf '%s\n' "${tut}Here! Have a rainbow with the \"r\" switch!$_res"
printf '%s\n' "% shoutctl rainbow"
shoutctl rainbow
printf '\n'
printf '%s\n' "$GRN${bla}Victory! You passed all the tests!$res"
printf '%s\n' "${tut}Here! Have a Palestine flag with the \"p\" switch!$_res"
printf '%s\n' "% shoutctl palestine"
shoutctl palestine
