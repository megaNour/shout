#!/bin/sh

shout() { # inline logging
  _shout_level=${1:?shout requires a log level. Use shoutf to force.}
  [ -n "$SHOUT_DISABLED" ] && return 0
  [ "$((SHOUT_LEVEL - _shout_level))" -ge 0 ] && shift || return 0
  printf "%s%s%s\n" "$SHOUT_COLOR" "$*" "$_res" >&2
}

shouta() { # "a"rguments indexed
  _shout_level=${1:?shouta requires a log level. Use shoutaf to force.}
  [ -n "$SHOUT_DISABLED" ] && return 0
  [ "$((SHOUT_LEVEL - _shout_level))" -ge 0 ] && shift || return 0
  _shout_arg_i=0
  for arg in "$@"; do
    _shout_arg_i=$((_shout_arg_i + 1))
    printf '%s%s%s\n' "$SHOUT_ARGS_COLOR" "\$$_shout_arg_i: $arg" "$_res" >&2
  done
}

shouts() { # "s"tream logging
  _shout_level=${1:?shouts requires a log level. Use shoutsf to force.}
  [ -n "$SHOUT_DISABLED" ] && cat && return 0
  [ "$((SHOUT_LEVEL - _shout_level))" -lt 0 ] && cat && return 0
  printf '%s' "$SHOUT_STREAM_COLOR"
  tee /dev/stderr
  printf '%s' "$_res" >&2 >&2
}

shoutf() { # "f"orce inline logging
  printf "%s%s%s\n" "$SHOUT_COLOR" "$*" "$_res" >&2
}

shoutaf() { # "f"orce "a"rguments indexing
  _shout_arg_i=0
  for arg in "$@"; do
    _shout_arg_i=$((_shout_arg_i + 1))
    printf '%s%s%s\n' "$SHOUT_ARGS_COLOR" "\$$_shout_arg_i: $arg" "$_res" >&2
  done
}

shoutsf() { # "f"orce "s"
  printf '%s' "$SHOUT_STREAM_COLOR" >&2
  tee /dev/stderr
  printf '%s' "$_res" >&2
}
