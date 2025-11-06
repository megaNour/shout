#!/bin/sh

shout() { # inline logging
  _shout_level=${1:?shout requires a log level. Use shoutf to force.}
  _shoutCheckLevel && shift && shoutf "$*" || :
}

shouta() { # "a"rguments indexed
  _shout_level=${1:?shouta requires a log level. Use shoutaf to force.}
  _shoutCheckLevel && shift && shoutaf "$@" || :
}

shouts() { # "s"tream logging
  _shout_level=${1:?shouts requires a log level. Use shoutsf to force.}
  _shoutCheckLevel && shoutsf || cat
}

_shoutCheckLevel() {
  { [ -n "$SHOUT_DISABLED" ] || [ "$((SHOUT_LEVEL - _shout_level))" -lt 0 ]; } && return 1 || :
}

shoutf() { # "f"orce inline logging
  printf "%s%s%s\n" "$SHOUT_COLOR" "$*" "$_res" >&2
}

shoutaf() { # "f"orce "a"rguments indexing
  _shout_arg_i=0
  for arg in "$@"; do
    _shout_arg_i=$((_shout_arg_i + 1))
    SHOUT_COLOR=$SHOUT_ARGS_COLOR shoutf "\$$_shout_arg_i: $arg"
  done
}

shoutsf() { # "f"orce "s"
  printf '%s' "$SHOUT_STREAM_COLOR" >&2
  tee /dev/stderr
  printf '%s' "$_res" >&2
}
