#!/bin/sh

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

shoutsf() { # "f"orce "s"tream logging
  printf '%s' "$SHOUT_STREAM_COLOR" >&2
  tee /dev/stderr
  printf '%s' "$_res" >&2
}

early() {
  [ -z "$SHOUT_LEVEL" ] && return 0
  _shout_level=${1-0}
}

level() {
  [ "$((SHOUT_LEVEL - _shout_level))" -ge 0 ] && shift || return 0
}

shout() { # inline logging
  :
  ##! early
  ##! level
  ##! shoutf
}

shouta() { # "a"rguments indexed
  :
  ##! early
  ##! level
  ##! shoutaf
}

shouts() { # "s"tream logging
  [ -z "$SHOUT_LEVEL" ] && cat && return 0
  _shout_level=$1
  [ "$((SHOUT_LEVEL - _shout_level))" -ge 0 ] || cat && return 0
  ##! shoutsf
}
