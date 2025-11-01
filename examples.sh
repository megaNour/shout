#!/bin/sh

. ./shout.sh
DEBUG_ENABLED=1

shout "" "This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING."
# This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING.

shout "$red" "This is a red line log. You can change the color."
# This is a red line log. You can change the color.

unset DEBUG_ENABLED
shout "F$red" "The 'F'orce switch bypasses DEBUG_ENABLED. Switches go before any color."
# The 'F'orce switch bypasses DEBUG_ENABLED. Switches go before any color.

shout FA This is a positional arg log using the 'A' switch.
# $1: This
# $2: is
# $3: a
# $4: positional
# $5: arg
# $6: log
# $7: using
# $8: the
# $9: A
# $10: switch.

echo "This is streamed to stdin and stderr. Thus, you see it twice." | shout F
# This is streamed to stdin and stderr. Thus, you see it twice.
# This is streamed to stdin and stderr. Thus, you see it twice.
