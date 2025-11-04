#!/bin/sh

set -e

ENTRY=$(dirname "$0")
. "$ENTRY/colors.sh"
. "$ENTRY/libshout.sh"
SHOUT_ENABLED=1

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

test='shout "" "This is a default grey log. Notice the empty OPT_STRING."'
expected=$(printf "%s" "${gry}This is a default grey log. Notice the empty OPT_STRING.$_res")
run "$test" "$expected"

printf '%s\n' "$RED${bla}Important!$res$tut always pass the OPT_STRING to avoid your first arg to be mistaken with it.$_res"

printf '%s\n' "% SHOUT_COLOR=\$_red $tut# Let's define the default color to red.$_res"
SHOUT_COLOR=$_red

test='shout "" "${_red}This is a red line log.$_grn You$_yel can$_blu change$_mag the$_cya color$_whi by$_def inserting your own escape sequences. They will be preserved."'
expected=$(printf "%s" "$red${red}This is a red line log.$grn You$yel can$blu change$mag the$cya color$whi by$def inserting your own escape sequences. They will be preserved.$res")
run "$test" "$expected"

printf '%s\n' "% SHOUT_COLOR= $tut# You can also opt out of default color by setting it to null. Unsetting it would activate back the default fallback!$res"
SHOUT_COLOR=

test='shout "" "This is printed in regular color :'\''("'
expected=$(printf "%s" "This is printed in regular color :'($res")
run "$test" "$expected"

printf '%s\n' "% SHOUT_COLOR=\$_gry"
SHOUT_COLOR=$_gry

test='shout "" "This is printed in grey :)"'
expected=$(printf "%s" "${gry}This is printed in grey :)$res")
run "$test" "$expected"

printf '%s\n' "% unset SHOUT_ENABLED"
unset SHOUT_ENABLED

test='shout "f" "${_red}The \"f\"orce switch bypasses SHOUT_ENABLED. Switches go before any color."'
expected=$(printf "%s" "$gry${_red}The \"f\"orce switch bypasses SHOUT_ENABLED. Switches go before any color.$_res")
run "$test" "$expected"

test='shout fa This is a positional arg log using the \"a\" switch.'
expected="$gry\$1: This$res
$gry\$2: is$res
$gry\$3: a$res
$gry\$4: positional$res
$gry\$5: arg$res
$gry\$6: log$res
$gry\$7: using$res
$gry\$8: the$res
$gry\$9: \"a\"$res
$gry\$10: switch.$res"
run "$test" "$expected"

printf '%s\n' "% SHOUT_STREAM_COLOR=\$_RED\$_bla ${tut}# there is a stream color defaulting to ${yel}SHOUT_COLOR$tut that you can utilize.$res"
SHOUT_STREAM_COLOR=$_RED$_bla

test='printf "%s" "This is streamed to stdin and stderr. Thus, you see it twice." | shout f'
expected="$RED${bla}This is streamed to stdin and stderr. Thus, you see it twice.This is streamed to stdin and stderr. Thus, you see it twice.$res"
run "$test" "$expected"

printf "%s\n" "${tut}Did you notice logs did not have a level in previous tests?"
printf "%s\n" "${tut}They are unknown level logs."
printf "%s\n" "${tut}Unknown level logs will not be filtered by log level, so they will still pass if logs are enabled or with \"f\"orce..."
printf "%s\n" "${tut}Let us see how it goes$_res"

printf "%s\n" "% SHOUT_ENABLED=1 SHOUT_LEVEL=5"
SHOUT_ENABLED=1 SHOUT_LEVEL=5

test='shout 5 This is a level 5 log, it can pass!'
expected="${gry}This is a level 5 log, it can pass!$res"
run "$test" "$expected"

test='shout 4 This is a level 4 log, it cannot display!'
expected=
run "$test" "$expected"

test='shout a5 "By the way:" "Switches and log level can be written in any order." "Just remember:" "- Only the first number is a log level!" "- The colors are always last!"'
expected="$gry\$1: By the way:$res
$gry\$2: Switches and log level can be written in any order.$res
$gry\$3: Just remember:$res
$gry\$4: - Only the first number is a log level!$res
$gry\$5: - The colors are always last!$res"
run "$test" "$expected"

test='shout "" Now the terrible truth:\
 multiline strings will end up on one line.'
expected=$(
  printf '%s' "${gry}Now the terrible truth: multiline strings will end up on one line.$res"
)
run "$test" "$expected"

printf "%s\n" "% SHOUT_KNOWN_LEVEL_ONLY=1"
SHOUT_KNOWN_LEVEL_ONLY=1

test='shout "" This is an unknown level log, it cannot pass anymore!'
expected=
run "$test" "$expected"

printf '%s\n' "${tut}Here! Have a rainbow with the \"r\" switch!$_res"
printf '%s\n' "% shoutctl rainbow"
shoutctl rainbow
printf '\n'
printf '%s\n' "$GRN${bla}Victory! You passed all the tests!$res"
printf '%s\n' "${tut}Here! Have a Palestine flag with the \"p\" switch!$_res"
printf '%s\n' "% shoutctl palestine"
shoutctl palestine
