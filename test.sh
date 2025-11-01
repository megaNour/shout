#!/bin/sh

. ./shout.sh
DEBUG_ENABLED=1

tred=$(tput setaf 1)
tgreen=$(tput setaf 2)
tgrey=$(tput setaf 8)
treset=$(tput sgr 0)

assert() {
  actual=$(printf '%s' "$1" | od -ta)
  expected=$(printf '%s' "$2" | od -ta)
  if [ "$actual" = "$expected" ]; then
    printf "%s%s%s\n" "$tgreen" "Test passed!" "$treset" >&2
  else
    {
      printf "%s%s%s\n" "$tred" "Test failed!" "$treset"
      printf "\nExpected:\n"
      cat <<EOF
$expected
EOF
      printf "\nActual:\n"
      cat <<EOF
$actual
EOF
    } >&2
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
expected=$(printf "%s" "${tgrey}This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING.$reset")
run "$test" "$expected"

test='shout "$red" "This is a red line log. You can change the color."'
expected=$(printf "%s" "${tred}This is a red line log. You can change the color.$reset")
run "$test" "$expected"

unset DEBUG_ENABLED
printf '%s\n' "%% unset DEBUG_ENABLED"
test='shout "F$red" "The Force switch bypasses DEBUG_ENABLED. Switches go before any color."'
expected=$(printf "%s" "${red}The Force switch bypasses DEBUG_ENABLED. Switches go before any color.$reset")
run "$test" "$expected"

test='shout FA This is a positional arg log using the A switch.'
expected="$grey\$1: This$reset
$grey\$2: is$reset
$grey\$3: a$reset
$grey\$4: positional$reset
$grey\$5: arg$reset
$grey\$6: log$reset
$grey\$7: using$reset
$grey\$8: the$reset
$grey\$9: A$reset
$grey\$10: switch.$reset"
run "$test" "$expected"

test='printf '%s' "This is streamed to stdin and stderr. Thus, you see it twice." | shout F'
expected="${tgrey}This is streamed to stdin and stderr. Thus, you see it twice.This is streamed to stdin and stderr. Thus, you see it twice.$reset"
run "$test" "$expected"
