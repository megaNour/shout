#!/bin/sh

set -e

. ./shout.sh
SHOUT_ENABLED=1

shout "" "This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING."

shout "$_red" "This is a red line log. You can change the color."

unset SHOUT_ENABLED
shout "f$_red" "The \"f\"orce switch bypasses SHOUT_ENABLED. Switches go before any color."

shout fa This is a positional arg log using the \"a\" switch.

printf "%s" "This is streamed to stdin and stderr. Thus, you see it twice." | shout f

shout f$_RED$_bla "Combining colors to make sure you notice the pipe in the previous test."

shout "f" "Did you notice logs did not have a level in previous tests?"
shout "f" "They are unknown level logs."
shout "f" "Unknown level logs will not be filtered by log level, so they will still pass if logs are enabled or with \"f\"orce..."
shout "f" "Let's see how it goes"

SHOUT_ENABLED=1 SHOUT_LEVEL=5

shout 5 This is a level 5 log, it can pass!

shout 4 This is a level 4 log, it cannot pass!

shout a5 "By the way:" "Switches and log level can be written in any order." "Just remember:" "- Only the first number is a log level!" "- The colors are always last!"

shout "" Now the terrible truth: multiline strings will end up on one line.

SHOUT_KNOWN_LEVEL_ONLY=1

shout "" This is an unknown level log, it cannot pass anymore!

# printf '\n'
# shout f "Here! Have a rainbow with the \"r\" switch!"
# printf '%s\n' "% shout r"
# shout r
# printf '\n'
# shout f "Here! Have a Palestine flag with the \"p\" switch!"
# printf '%s\n' "% shout p"
# shout p
