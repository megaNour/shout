#!/bin/sh

cat <<EOF
$_bol                        $_red        :
$_grn             .          $_red       t#,    :
$_grn            ;W.    .    $_red      ;##W.   Ef
$_grn           f#Ef    Dt   $_red     :#L:WE   E#t  GEEEEEEEL
$_grn         .E#f  ai  E#i  $_red    .KG  ,#D  E#t  ,;;L#K;;.
$_grn        iWW;  E#t  E#t  $_red    EE    ;#f E#t     t#E
$_grn       L##LffiE#t  E#t  $_red   f#.     t#iE#t  i  t#E
$_grn      tLLG##L E########f$_red  .:#G     GK E#t .#j t#E
$_grn        ,W#i  E#j..K#j..$_red    ;#L   LW. E#t ;#L t#E
$_grn       j#E.   E#t  E#t  $_red     t#f f#:  E#tf#E: t#E
$_grn     .D#j     E#t  E#t  $_red      f#D#;   E###f   t#E
$_grn    ,WK,      f#t  f#t  $_red       G#t    E#K,    t#E
$_grn    EG.        ii   ii  $_red        t     EL       fE
$_grn    ,                   $_red              :         :
                        $_RED $_bol${_def}v0.1.0 $_res

Multi-modal logger with switches log level in a single ${_yel}OPT_STRING$_res.

${_mag}Philosophy:$_res
  - No background process
  - No runtime    ${_gry}# shout is part of your shell process$_res
  - No subprocess ${_gry}# no | no & no JIT values ${_gry}# no \$(whatevere)$_res

${_mag}Usage:$_res
  shout ${_yel}OPT_STRING$_res [ARGUMENT...] $_gry# line mode$_res
  command | shout ${_yel}OPT_STRING$_res     $_gry# stream mode$_res

${_mag}Environments:$_res
  $_gry# log levels.
  ${_yel}SHOUT_ENABLED$_res            global logging switch. Can be bypassed with ${_yel}f$_res opt.
  ${_yel}SHOUT_LEVEL$_res              the minimal log level accepted. Can be bypassed with ${_yel}f$_res opt.
  ${_yel}SHOUT_KNOWN_LEVEL_ONLY$_res   discards logs with no level. Can be bypassed with ${_yel}f$_res opt.
  $_gry# Default colors. All grey. Set them to null to use your regular text color.
  ${_yel}SHOUT_COLOR$_res              default color is always appended, provided or not.
  ${_yel}SHOUT_ARGS_COLOR$_res         default args listing color.
  ${_yel}SHOUT_STREAM_COLOR$_res       default stream color.

${_mag}OPT_STRING:$_res ${_yel}[LOG_LEVEL|SWITCH...]$_res $_gry# see predefined colors at the bottom$_res

${_mag}SWITCH:$_res ${_gry}# combinable
  $_bol${_yel}a$_res: pretty print positional arguments.
  $_bol${_yel}f$_res: force print to stderr (i.e. bypass ${_yel}SHOUT_ENABLED$_res)

${_mag}LOG_LEVEL:$_res $_gry# single number$_res
  > 0 integer indicating the criticity of your log. It is the first number found in your ${_yel}OPT_STRING$_res.

${_mag}Supported log modes:$_res
  - ${_yel}line-mode$_res:      prints "\$@" to stderr after shifting the optstring.
  - ${_yel}stream-mode$_res:    forwards stdin to stdout and tees a colorized copy to stderr.

${_mag}Examples:$_res
  ${_gry}# see much more examples by running the tests with $_yel\`shoutctl test\`${_res}
  ${_gry}# This prints a red log (and resets colors) in red to stderr even if SHOUT_ENABLED is off${_res}
  shout f "\${_red}The pizza is blue."
  ${_gry}# This prints in grey to stderr (and resets colors) if SHOUT_LEVEL <= 5 and forwards to myNextProcess$_res
  echo "streamed text" | shout 5 | myNextProcess

${_mag}Included colors:$_res $_gry(you can define and pass your own...)$_def
foregrounds:  $_gry\$_gry $_red \$_red  $_grn\$_grn  $_yel\$_yel  $_blu\$_blu  $_mag\$_mag  $_cya\$cya  $_whi\$_whi  $_def\$_def$_def $_DEF$_bla \$_bla $_res
backgrounds: $_GRY \$_GRY $_RED \$_RED $_GRN$_bla \$_GRN $_YEL \$_YEL $_BLU \$_BLU $_MAG \$_MAG $_CYA \$CYA $_WHI \$_WHI $_DEF \$_DEF $_BLA$_def \$_BLA $_res
modifiers:    $_bol\$_bol$_gry # bold combines with any color$_res
finally:      \$_res$_gry # resets everything.$_res
EOF
