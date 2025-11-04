#!/bin/sh

eval "$(shoutctl source 2>/dev/null)"

benchShoutLines() {
  i=0
  while [ "$i" -lt 1000 ]; do
    i=$((i + 1))
    shout "" "$_red$i"

    shout "" "This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING."

    shout "" "This is a red line log. You can change the color."

    shout "" "The \"f\"orce switch bypasses SHOUT_ENABLED. Switches go before any color."

    shout f "This is a positional arg log using the \"a\" switch."

    shout "" "Combining colors to make sure you notice the pipe in the previous test."

    shout "f" "Did you notice logs did not have a level in previous tests?"

    shout "f" "They are unknown level logs."

    shout "f" "Unknown level logs will not be filtered by log level, so they will still pass if logs are enabled or with \"f\"orce..."

    shout "f" "Let's see how it goes"

    shout 5 "This is a level 5 log, it can pass!"

    shout 4 "This is a level 4 log, it cannot pass!"

    shout "" "Now the terrible truth: multiline strings will end up on one line."

    shout "" "This is an unknown level log, it cannot pass anymore!"
  done
}

benchPrintf() {
  i=0
  while [ "$i" -lt 1000 ]; do
    i=$((i + 1))
    printf "%s\n" "$_red$i" 1>&2

    printf "%s\n" "This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING." 1>&2

    printf "%s\n" "This is a red line log. You can change the color." 1>&2

    printf "%s\n" "The \"f\"orce switch bypasses SHOUT_ENABLED. Switches go before any color." 1>&2

    printf "%s\n" "This is a positional arg log using the \"a\" switch." 1>&2

    printf "%s\n" "Combining colors to make sure you notice the pipe in the previous test." 1>&2

    printf "%s\n" "Did you notice logs did not have a level in previous tests?" 1>&2

    printf "%s\n" "They are unknown level logs." 1>&2

    printf "%s\n" "Unknown level logs will not be filtered by log level, so they will still pass if logs are enabled or with \"f\"orce..." 1>&2

    printf "%s\n" "Let's see how it goes" 1>&2

    printf "%s\n" "This is a level 5 log, it can pass!" 1>&2

    printf "%s\n" "This is a level 4 log, it cannot pass!" 1>&2

    printf "%s\n" "Now the terrible truth: multiline strings will end up on one line." 1>&2

    printf "%s" "This is an unknown level log, it cannot pass anymore!" 1>&2
  done
}

time benchShoutLines 2>/dev/null
time benchPrintf 2>/dev/null
