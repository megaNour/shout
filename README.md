# Shout - A Mini POSIX Shell-Native Logging Library

shout is just a `POSIX` script. Source it, use it. No daemon, no runtime, no...

## Look & Feel (in my terminal)

Bellow this long scroll are the same instructions in monochrome.

[shout_look_and_feel](./doodle_2025_11_05_shout.jpg)

## Setup

first install `shoutctl`. Then see the [How to Use](#how-to-use) and [Examples](#examples-to-be-run-in-your-own-terminal-for-colors)sections.

```sh
% ./install.sh # installs shoutctl
% shoutctl     # will display all you need to know to start
Description:
  shoutctl - a little helper to interact with shout and source the libs easily.

Usage:

\`\`\`sh                              # Admire the fake terminal theme!
% eval $(shoutctl source)             # Source and that's it! You can shout! (see shoutctl help for details)
% eval $(shoutctl source 2>/dev/null) # Same but silent.
% shoutctl [COMMAND]                  # See other commands!
\`\`\`                                # Look into ./shoutctl.sh to see how it's done!

COMMAND:
  help                Print help for THE ACTUAL libshout.
  source              Print the command to source libshout.
  test                Run the tests.
  bench BENCH_METHOD  Run a bench test
  rainbow             Print an indexed rainbow of 256 colors. (no worries. it's compact)
  [Pp]alestine        Print the Palestinian flag.
  [*]                 Print this message.
```

## How to Use

The following will explain what the `OPT_STRING` is and which values it takes.

```sh
% shoutctl help # display the libshoutctl help. Should look like below but with colors!
                                :
             .                 t#,    :
            ;W.    .          ;##W.   Ef
           f#Ef    Dt        :#L:WE   E#t  GEEEEEEEL
         .E#f  ai  E#i      .KG  ,#D  E#t  ,;;L#K;;.
        iWW;  E#t  E#t      EE    ;#f E#t     t#E
       L##LffiE#t  E#t     f#.     t#iE#t  i  t#E
      tLLG##L E########f  .:#G     GK E#t .#j t#E
        ,W#i  E#j..K#j..    ;#L   LW. E#t ;#L t#E
       j#E.   E#t  E#t       t#f f#:  E#tf#E: t#E
     .D#j     E#t  E#t        f#D#;   E###f   t#E
    ,WK,      f#t  f#t         G#t    E#K,    t#E
    EG.        ii   ii          t     EL       fE
    ,                                 :         :
                         v0.1.0

Multi-modal printf-speed logger with switches log level in a single OPT_STRING.

Philosophy:
  - No background process
  - No runtime    # shout is part of your shell process
  - No subprocess # no '|' no '&' no '$(whatever)'
  - No bashism    # POSIX syntax
  - No smart options # static optimization.

Usage:
  shout[as]f [ARGUMENT...]       # force log
  shout LOG_LEVEL [ARGUMENT...]  # line mode
  shouta LOG_LEVEL [ARGUMENT...] # args mode
  COMMAND | shouts LOG_LEVEL     # stream mode

Environments:
  # Log levels.
  SHOUT_LEVEL              the minimal log level accepted. Can be bypassed with f opt.
  SHOUT_DISABLED           global logging switch. Can be bypassed with f opt.
  # Default colors. All grey. Set them to null to use your regular text color.
  SHOUT_COLOR              default color is always appended, provided or not.
  SHOUT_ARGS_COLOR         default args listing color.
  SHOUT_STREAM_COLOR       default stream color.

LOG_LEVEL:
  Only logs lower or equal to SHOUT_LEVEL will display. (unless forced)

Examples:
  # see much more examples by running the tests with `shoutctl test`
  # This prints a red log (and resets colors) in red to stderr even if SHOUT_DISABLED is set.
  shoutf "${_red}The pizza is blue."
  # This prints in grey to stderr (and resets colors) if SHOUT_LEVEL >= 5 and forwards to myNextProcess
  echo "streamed text" | shouts 5 | myNextProcess

Included colors: (you can define and pass your own...)
foregrounds:  ${_gry}  ${_red}  ${_grn}  ${_yel}  ${_blu}  ${_mag}  ${_cya}  ${_whi}  ${_def}  ${_bla}
backgrounds:  ${_GRY}  ${_RED}  ${_GRN}  ${_YEL}  ${_BLU}  ${_MAG}  ${_CYA}  ${_WHI}  ${_DEF}  ${_BLA}
modifiers:    ${_rev}  ${_REV}  ${_bol} # reverse, noreverse, bold
finally:      ${_res} # resets everything
```

## Examples - To Be Run in Your Own Terminal for Colors

Examples are run live by the test suite.
No colors will show in this README.md and the look and feel may vary depending
on your terminal's theme.
So you can just run them (~instant):

```sh
% shoutctl test
# then the following will display, you don't type it.
% shout 0 "This is a default grey log. $_CYA${_bla}Notice$_res$_gry 0 is the (most critical) log level, which is mandatory with simple shout."
This is a default grey log. Notice 0 is the (most critical) log level, which is mandatory with simple shout.
Test passed!

% SHOUT_COLOR=$_red # Let's define the default color to red.
% shoutf "${_red}This is a red line log.$_grn You$_yel can$_blu change$_mag the$_cya color$_whi by$_def inserting your own escape sequences. They will be preserved."
This is a red line log. You can change the color by inserting your own escape sequences. They will be preserved.
Test passed!

% SHOUT_COLOR= # You can also opt out of default color by setting it to null. Unsetting it would activate back the default fallback!
% shoutf "This is printed in regular color :'("
This is printed in regular color :'(
Test passed!

% SHOUT_COLOR=$_gry
% shoutf "This is printed in grey :)"
This is printed in grey :)
Test passed!

% SHOUT_DISABLED=1
% shout 1 "${_yel}SHOUT_DISABLED$_gry applies to leveled shout. Not shout?f."

Test passed!

% shoutaf This is a positional arg log.
$1: This
$2: is
$3: a
$4: positional
$5: arg
$6: log.
Test passed!

% shouta needs a level as well, but it will not show anyway while SHOUT_DISABLED=1

Test passed!

% SHOUT_STREAM_COLOR=$_RED$_bla # there is a stream color defaulting to SHOUT_COLOR that you can utilize.
% printf "%s" "This is streamed and forced to stdout and stderr. Thus, you see it twice." | shoutsf
This is streamed and forced to stdout and stderr. Thus, you see it twice.This is streamed and forced to stdout and stderr. Thus, you see it twice.
Test passed!

% SHOUT_DISABLED="" SHOUT_LEVEL=5
% printf "%s" "This is streamed to stdout only as logs are disabled. Thus, you see it once." | shouts 42
This is streamed to stdout only as logs are disabled. Thus, you see it once.
Test passed!

% SHOUT_DISABLED="" SHOUT_LEVEL=5
% shout 5 This is a level 5 log, it can pass!
This is a level 5 log, it can pass!
Test passed!

% shout 6 This is a level 6 log, it cannot display, just like for shouta and shouts!

Test passed!

% shoutf Now the terrible truth:\
 multiline strings will end up on one line.
Now the terrible truth: multiline strings will end up on one line.
Test passed!

Here! Have a rainbow with the "r" switch!
% shoutctl rainbow
0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255

Victory! You passed all the tests!
Here! Have a Palestine flag with the "p" switch!
% shoutctl palestine
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
