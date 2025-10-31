# shout - a mini POSIX shell-native logging library

shout is just a POSIX script. Source it, use it. No daemon, no runtime, no...

## How to use

```sh
# Any argument will display help.
$ ./shout.sh help
```

## Examples

```sh
$ . ./shout.sh
$ shout FA This is a positional arg log.
# $1: This
# $2: is
# $3: a
# $4: positional
# $5: arg
# $6: log
$ shout F$red This is a red line log.
# This is a red line log.
$ echo "This is streamed to stdin and stderr. Thus, you see it twice." | shout F
# This is streamed to stdin and stderr. Thus, you see it twice.
# This is streamed to stdin and stderr. Thus, you see it twice.
$ DEBUG_ENABLED=1 shout $red "If you have this global switch, you don't need Force."
# If you have this global switch, you don't need to use Force.
```

## Work In Progress

This is at the stage of "gluing together some handy logging functions I wrote here
and there".

- A chain filtering system should emerge.
- The buffer and flush logs should come back.
