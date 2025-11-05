#!/bin/sh

shout() {
  _shout_level=${1:?shout requires a log level. Use shoutf to force.}
  shift
  if _shoutCheckLevel; then
    shoutf "$*"
  fi
}

shouta() {
  _shout_level=${1:?shouta requires a log level. Use shoutaf to force.}
  shift
  if _shoutCheckLevel; then # line mode
    shoutaf "$@"
  fi
}

shouts() {
  _shout_level=${1:?shouts requires a log level. Use shoutsf to force.} # no need to shift
  if _shoutCheckLevel; then
    shoutsf
  else
    cat # just passthrough
  fi
}

_shoutCheckLevel() {
  if [ -n "$SHOUT_DISABLED" ] || [ "$((SHOUT_LEVEL - _shout_level))" -gt 0 ]; then
    return 1
  fi
}

shoutf() { # log positional arguments inline
  printf "%s%s%s\n" "$SHOUT_COLOR" "$*" "$_res" >&2
}

shoutaf() { # log positional arguments indexed
  _shout_arg_i=0
  for arg in "$@"; do
    _shout_arg_i=$((_shout_arg_i + 1))
    SHOUT_COLOR=$SHOUT_ARGS_COLOR shoutf "\$$_shout_arg_i: $arg"
  done
}

shoutsf() {
  printf '%s' "$SHOUT_STREAM_COLOR" >&2
  tee /dev/stderr
  printf '%s' "$_res" >&2
}
