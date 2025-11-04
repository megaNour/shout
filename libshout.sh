#!/bin/sh

shout() {
  unset _shout_level _shout_force _shout_silently _shout_stream
  _shout_optstring=$1
  if [ "$#" -gt 0 ]; then shift; fi

  if [ ! -t 0 ]; then _shout_stream=1; fi
  case "$_shout_optstring" in *f*) _shout_force=1 ;; esac
  if [ "$SHOUT_DISABLED" ] && [ -z "$_shout_force" ]; then _shout_silently=1; fi

  if [ -z "$_shout_force" ]; then # further checks needed on log level
    _shout_level=${_shout_optstring%%[^0-9]*}
    if [ -n "$SHOUT_KNOWN_LEVEL_ONLY" ] && [ -z "$_shout_level" ]; then
      _shout_silently=1
    else
      if [ $((${SHOUT_LEVEL:-0} - ${_shout_level:-0})) -gt 0 ]; then
        _shout_silently=1
      fi
    fi
  fi

  if [ -z "$_shout_silently" ] && [ -z "$_shout_stream" ]; then # line mode
    case "$_shout_optstring" in *a*) _shoutArgs "$@" ;; *) _shoutLine "$*" ;; esac
  elif [ -n "$_shout_stream" ]; then # stream mode
    if [ -n "$_shout_silently" ]; then
      cat # just passthrough
    else
      if [ -n "$SHOUT_STREAM_COLOR" ]; then printf '%s' "$SHOUT_STREAM_COLOR" >&2; fi
      tee /dev/stderr
      printf '%s' "$_res" >&2 # Never spare it, maybe there are custom colors... Reset is guaranteed.
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
