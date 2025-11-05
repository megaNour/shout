#!/usr/bin/env dash

eval "$(shoutctl source 2>/dev/null)"

ITERATIONS=10000

_shout_bench_loop() {
  echo "$@"
  _shout_bench_i=0
  while [ "$_shout_bench_i" -lt "$ITERATIONS" ]; do
    _shout_bench_i=$((_shout_bench_i + 1))
    "$@"
  done
}

_shout_bench_shout() {
  shout "$1" "This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING."
}

_shout_bench_shoutf() {
  shoutf "This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING."
}

_shout_bench_printf() {
  printf "%s\n" "${_gry}This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING.$_res" 1>&2
}

_shout_bench_test="_shout_bench_$1"
shift

_shout_bench_loop "$_shout_bench_test" "$@"

printf "\n"
shout "" "${_grn}benching '${_shout_bench_test#_shout_bench_}'"
