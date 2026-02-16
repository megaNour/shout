#!/bin/sh
shoutf() { # "f"orce inline logging
  printf "%s%s%s\n" "[38;5;8m" "$*" "[0m" >&2
}
shoutaf() { # "f"orce "a"rguments indexing
  _shout_arg_i=0
  for arg in "$@"; do
    _shout_arg_i=$((_shout_arg_i + 1))
    printf '%s%s%s\n' "" "\$$_shout_arg_i: $arg" "[0m" >&2
  done
}
shoutsf() { # "f"orce "s"tream logging
  printf '%s' "[38;5;8m" >&2
  tee /dev/stderr
  printf '%s' "[0m" >&2
}
shout() { # inline logging
  [ -z "$SHOUT_LEVEL" ] && return 0
  _shout_level=${1-0}
  [ "$((SHOUT_LEVEL - _shout_level))" -ge 0 ] && shift || return 0
  printf "%s%s%s\n" "[38;5;8m" "$*" "[0m" >&2
}
shouta() { # "a"rguments indexed
  [ -z "$SHOUT_LEVEL" ] && return 0
  _shout_level=${1-0}
  [ "$((SHOUT_LEVEL - _shout_level))" -ge 0 ] && shift || return 0
  _shout_arg_i=0
  for arg in "$@"; do
    _shout_arg_i=$((_shout_arg_i + 1))
    printf '%s%s%s\n' "" "\$$_shout_arg_i: $arg" "[0m" >&2
  done
}
shouts() { # "s"tream logging
  [ -z "$SHOUT_LEVEL" ] && cat && return 0
  _shout_level=$1
  [ "$((SHOUT_LEVEL - _shout_level))" -ge 0 ] || cat && return 0
  printf '%s' "[38;5;8m" >&2
  tee /dev/stderr
  printf '%s' "[0m" >&2
}
