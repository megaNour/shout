#!/usr/bin/env dash

eval "$(shoutctl source 2>/dev/null)"

ITERATIONS=100000 #100k

_shout_bench_loop() {
  _shout_bench_i=0
  while [ "$_shout_bench_i" -lt "$ITERATIONS" ]; do
    _shout_bench_i=$((_shout_bench_i + 1))
    "$@"
  done
}

_shout_bench_shout() {
  shout "$1" "This is a grey log. Log arguments inline in grey."
}

_shout_bench_shoutf() {
  shoutf "This is a grey log. Log arguments inline in grey."
}

_shout_bench_expand() {
  : "$SHOUT_STREAM_COLOR" "$SHOUT_STREAM_COLOR" "$_res"
}

_shout_bench_hardcode() {
  : "[38;5;8m" "[38;5;8m" "[38;5;8m"
}

_shout_bench_printfg() {
  _shout_level=${1:?shout requires a log level. Use shoutf to force.}
  [ -n "$SHOUT_DISABLED" ] && return 0
  [ "$((SHOUT_LEVEL - _shout_level))" -ge 0 ] && shift || return 0
  printf "%s%s%s\n" "$SHOUT_COLOR" "This is a grey log. Log arguments inline in grey." "$_res" >&2
}

_shout_bench_printf() {
  printf "%s%s%s\n" "$SHOUT_COLOR" "This is a grey log. Log arguments inline in grey." "$_res" >&2
}

_shout_bench_test="_shout_bench_$1"
shift

_shout_bench_loop "$_shout_bench_test" "$@"

printf "\n"
shoutf "${_grn}benched '${_shout_bench_test#_shout_bench_}'"
