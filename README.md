# Shout - A Mini POSIX Shell-Native Logging Library

shout is just a `POSIX` script. Source it, use it. No daemon, no runtime, no...

## How to Use

The following will explain what the `OPT_STRING` is and which values it takes.

```sh
% ./shout.sh help # Any argument will display help. This avoids printing when sourcing.
% . ./shout.sh # Source it.
% shout h # The `h` switch also displays help.
# Now! Just go and read it already!
```

## Examples

These examples are extracted from the tests. The look and feel may vary depending
on your terminal's theme. So you can just run them (~instant):

The `%` prompts are symbolic of user prompt. The `$` are used in `shout` outputs.

```sh
./test.sh # Runs the tests outputing example commands and outputs.
```

## TODO

Maybe filtering, log leveling, log&executing...
