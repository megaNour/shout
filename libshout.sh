#!/bin/sh

shout() {
  unset _shout_level _shout_force _shout_silently _shout_stream
  _shout_optstring=$1
  if [ "$#" -gt 0 ]; then shift; fi

  case "$_shout_optstring" in *f*) _shout_force=1 ;; *) _shoutCheckLevel ;; esac

  if [ ! -t 0 ]; then # stream mode
    if [ -n "$_shout_silently" ]; then
      cat # just passthrough
    else
      printf '%s' "$SHOUT_STREAM_COLOR" >&2
      tee /dev/stderr
      printf '%s' "$_res" >&2
    fi
  elif [ -z "$_shout_silently" ]; then # line mode
    case "$_shout_optstring" in *a*) _shoutArgs "$@" ;; *) _shoutLine "$*" ;; esac
  fi
}

_shoutCheckLevel() {
  if [ -n "$SHOUT_DISABLED" ]; then
    _shout_silently=1
  else
    _shout_level=${_shout_optstring%%[^0-9]*}
    if [ $((${SHOUT_LEVEL:-0} - ${_shout_level:-0})) -gt 0 ] ||
      { [ -n "$SHOUT_KNOWN_LEVEL_ONLY" ] && [ -z "$_shout_level" ]; }; then
      _shout_silently=1
    fi
  fi
}

_shoutArgs() { # log positional arguments indexed
  _shout_arg_i=0
  for arg in "$@"; do
    _shout_arg_i=$((_shout_arg_i + 1))
    SHOUT_COLOR=$SHOUT_ARGS_COLOR _shoutLine "\$$_shout_arg_i: $arg"
  done
}

_shoutLine() { # log positional arguments inline
  printf "%s%s%s\n" "$SHOUT_COLOR" "$*" "$_res" >&2
}
