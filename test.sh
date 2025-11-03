#!/bin/sh

set -e

. ./shout.sh
SHOUT_ENABLED=1

tres="[0m"
tred="[38;5;1m"
tgrn="[38;5;2m"
tgry="[38;5;8m"
tbla="[38;5;16m"
tRED="[48;5;1m"

assert() {
  actual=$(printf '%s' "$1" | od -ta)
  expected=$(printf '%s' "$2" | od -ta)
  if [ "$actual" = "$expected" ]; then
    printf "%s%s%s\n" "$tgrn" "Test passed!" "$tres" >&2
  else
    {
      printf "%s%s%s\n" "$tred" "Test failed!" "$tres"
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

test='shout "" "This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING."'
expected=$(printf "%s" "${tgry}This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING.$_res")
run "$test" "$expected"

test='shout "$_red" "This is a red line log. You can change the color."'
expected=$(printf "%s" "${tred}This is a red line log. You can change the color.$_res")
run "$test" "$expected"

printf '%s\n' "% unset SHOUT_ENABLED"
unset SHOUT_ENABLED
test='shout "f$_red" "The \"f\"orce switch bypasses SHOUT_ENABLED. Switches go before any color."'
expected=$(printf "%s" "${_red}The \"f\"orce switch bypasses SHOUT_ENABLED. Switches go before any color.$_res")
run "$test" "$expected"

test='shout fa This is a positional arg log using the \"a\" switch.'
expected="$tgry\$1: This$tres
$tgry\$2: is$tres
$tgry\$3: a$tres
$tgry\$4: positional$tres
$tgry\$5: arg$tres
$tgry\$6: log$tres
$tgry\$7: using$tres
$tgry\$8: the$tres
$tgry\$9: \"a\"$tres
$tgry\$10: switch.$tres"
run "$test" "$expected"

test='printf "%s" "This is streamed to stdin and stderr. Thus, you see it twice." | shout f'
expected="${tgry}This is streamed to stdin and stderr. Thus, you see it twice.This is streamed to stdin and stderr. Thus, you see it twice.$tres"
run "$test" "$expected"

test='shout f$_RED$_bla "Combining colors to make sure you notice the pipe in the previous test."'
expected="${tRED}${tbla}Combining colors to make sure you notice the pipe in the previous test.$tres"
run "$test" "$expected"

printf "%s\n" "${_gry}Did you notice logs did not have a level in previous tests?$_res"
printf "%s\n" "${_gry}They are unknown level logs.$_res"
printf "%s\n" "${_gry}Unknown level logs will not be filtered by log level, so they will still pass if logs are enabled or with \"f\"orce...$_res"
printf "%s\n" "${_gry}Let us see how it goes$_res"

printf "%s\n" "% SHOUT_ENABLED=1 SHOUT_LEVEL=5"
SHOUT_ENABLED=1 SHOUT_LEVEL=5

test='shout 5 This is a level 5 log, it can pass!'
expected="${tgry}This is a level 5 log, it can pass!$tres"
run "$test" "$expected"

test='shout 4 This is a level 4 log, it cannot display!'
expected=
run "$test" "$expected"

test='shout a5 "By the way:" "Switches and log level can be written in any order." "Just remember:" "- Only the first number is a log level!" "- The colors are always last!"'
expected="$tgry\$1: By the way:$tres
$tgry\$2: Switches and log level can be written in any order.$tres
$tgry\$3: Just remember:$tres
$tgry\$4: - Only the first number is a log level!$tres
$tgry\$5: - The colors are always last!$tres"
run "$test" "$expected"

test='shout "" Now the terrible truth:\
 multiline strings will end up on one line.'
expected=$(
  printf '%s' "${tgry}Now the terrible truth: multiline strings will end up on one line.$tres"
)
run "$test" "$expected"

printf "%s\n" "% SHOUT_KNOWN_LEVEL_ONLY=1"
SHOUT_KNOWN_LEVEL_ONLY=1

test='shout "" This is an unknown level log, it cannot pass anymore!'
expected=
run "$test" "$expected"

printf '\n%s\n' "${_gry}Here! Have a rainbow with the \"r\" switch!$_res"
printf '%s\n' "% shout r"
shout r
printf '\n'
shout f$_GRN$_bla Victory! You passed all the tests!
printf '%s\n' "${_grn}Here! Have a Palestine flag with the \"p\" switch!$_res"
printf '%s\n' "% shout p"
shout p
