# shout - a mini POSIX shell-native logging library

shout is just a `POSIX` script. Source it, use it. No daemon, no runtime, no...

## How to use

The following will explain what the `OPT_STRING` is and which values it takes.

```sh
# Any argument will display help. This avoids printing when sourcing.
% ./shout.sh help
```

## Examples

These examples are extracted from the tests. The look and feel may vary depending
on your terminal's theme. So you can just run them (~instant):

The `%` prompts are symbolic of user prompt. The `$` are used in `shout` outputs.

```sh
# Runs the tests and output example commands and output specific to your theme.
./test.sh
```

## Work In Progress

This is at the stage of "gluing together some handy logging functions I wrote here
and there".

- A chain filtering system should emerge.
- The buffer and flush logs should come back.
