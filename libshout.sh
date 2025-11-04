#!/bin/sh

shout() {
  unset _shout_level _shout_force
  optstring=$1
  shift

  if [ "${optstring#*f}" != "$optstring" ]; then _shout_force=1; fi
  if [ ! "$SHOUT_ENABLED" ] && [ -z "$_shout_force" ]; then return 0; fi

  if [ -z "$_shout_force" ]; then                                         # further checks needed on log level
    _shout_level=${optstring%%[^0-9]*}                                    # the first number only is the level
    _shout_level=${_shout_level#*[^0-9]}                                  # it can be before or after switches
    if { [ -n "$SHOUT_KNOWN_LEVEL_ONLY" ] && [ -z "$_shout_level" ]; } || # check if level-less logs are rejected or...
      { [ -n "$_shout_level" ] &&                                         # if there is a level
        [ "$_shout_level" -gt 0 ] 2>/dev/null &&                          # and it's > 0
        [ "$_shout_level" -lt "$SHOUT_LEVEL" ]; }; then                   # and it's inferior to SHOUT_LEVEL
      return 0                                                            # then abort
    fi
  fi

  if [ -t 0 ]; then                                # line mode
    if [ "${optstring#*a}" != "$optstring" ]; then # args switch
      _shoutArgs "$@"
    else # regular line
      _shoutLine "$@"
    fi
  else # stream mode
    if [ -n "$SHOUT_STREAM_COLOR" ]; then printf '%s' "$SHOUT_STREAM_COLOR" >&2; fi
    cat | tee /dev/stderr
    printf '%s' "$_res" >&2 # Never spare it, we don't know if there are custom colors and we guarantee the reset.
  fi
}

_shoutArgs() { # log positional arguments indexed
  i=0
  for arg in "$@"; do
    i=$((i + 1))
    SHOUT_COLOR=$SHOUT_ARGS_COLOR _shoutLine "\$$i: $arg"
  done
}

_shoutLine() { # log positional arguments inline
  printf "%s%s%s\n" "$SHOUT_COLOR" "$*" "$_res" >&2
}
