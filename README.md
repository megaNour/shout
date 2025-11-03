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

## Examples - To Be Run in Your Own Terminal for Colors

Examples are run live by the test suite.
No colors will show in this README.md and the look and feel may vary depending
on your terminal's theme.
So you can just run them (~instant):

```sh
% ./test.sh # Runs the tests outputing example commands and outputs.
# The `%` prompts are symbolic of user prompt. The `$` are used in `shout` outputs.
% shout "" "This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING."
This is a grey log. Log arguments inline in grey. Notice the empty OPT_STRING.
Test passed!
% shout "$_red" "This is a red line log. You can change the color."
This is a red line log. You can change the color.
Test passed!
% unset SHOUT_ENABLED
% shout "f$_red" "The \"f\"orce switch bypasses SHOUT_ENABLED. Switches go before any color."
The "f"orce switch bypasses SHOUT_ENABLED. Switches go before any color.
Test passed!
% shout fa This is a positional arg log using the \"a\" switch.
$1: This
$2: is
$3: a
$4: positional
$5: arg
$6: log
$7: using
$8: the
$9: "a"
$10: switch.
Test passed!
% printf "%s" "This is streamed to stdin and stderr. Thus, you see it twice." | shout f
This is streamed to stdin and stderr. Thus, you see it twice.This is streamed to stdin and stderr. Thus, you see it twice.
Test passed!
% shout f$_RED$_bla "Combining colors to make sure you notice the pipe in the previous test."
Combining colors to make sure you notice the pipe in the previous test.
Test passed!
Did you notice logs did not have a level in previous tests?
They are unknown level logs.
Unknown level logs will not be filtered by log level, so they will still pass if logs are enabled or with "f"orce...
Let us see how it goes
% SHOUT_ENABLED=1 SHOUT_LEVEL=5
% shout 5 This is a level 5 log, it can pass!
This is a level 5 log, it can pass!
Test passed!
% shout 4 This is a level 4 log, it cannot display!

Test passed!
% shout a5 "By the way:" "Switches and log level can be written in any order." "Just remember:" "- Only the first number is a log level!" "- The colors are always last!"
$1: By the way:
$2: Switches and log level can be written in any order.
$3: Just remember:
$4: - Only the first number is a log level!
$5: - The colors are always last!
Test passed!
% shout "" Now the terrible truth:\
 multiline strings will end up on one line.
Now the terrible truth: multiline strings will end up on one line.
Test passed!
% SHOUT_KNOWN_LEVEL_ONLY=1
% shout "" This is an unknown level log, it cannot pass anymore!

Test passed!

Here! Have a rainbow with the "r" switch!
% shout r
0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255

Victory! You passed all the tests!
Here! Have a Palestine flag with the "p" switch!
% shout p
◣
█◣
██◣
███◣
████◣
█████◣
██████◣
███████◣
████████◣
████████◤
███████◤
██████◤
█████◤
████◤
███◤
██◤
█◤
◤

```

## TODO

- `shoutctl` a little helper to source shout, split the help and other modules etc...
- Maybe filtering, log&executing...
