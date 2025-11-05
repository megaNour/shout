#!/bin/sh

cat <<EOF
${_bol}                        ${_red}        :
${_grn}             .          ${_red}       t#,    :
${_grn}            ;W.    .    ${_red}      ;##W.   Ef
${_grn}           f#Ef    Dt   ${_red}     :#L:WE   E#t  GEEEEEEEL
${_grn}         .E#f  ai  E#i  ${_red}    .KG  ,#D  E#t  ,;;L#K;;.
${_grn}        iWW;  E#t  E#t  ${_red}    EE    ;#f E#t     t#E
${_grn}       L##LffiE#t  E#t  ${_red}   f#.     t#iE#t  i  t#E
${_grn}      tLLG##L E########f${_red}  .:#G     GK E#t .#j t#E
${_grn}        ,W#i  E#j..K#j..${_red}    ;#L   LW. E#t ;#L t#E
${_grn}       j#E.   E#t  E#t  ${_red}     t#f f#:  E#tf#E: t#E
${_grn}     .D#j     E#t  E#t  ${_red}      f#D#;   E###f   t#E
${_grn}    ,WK,      f#t  f#t  ${_red}       G#t    E#K,    t#E
${_grn}    EG.        ii   ii  ${_red}        t     EL       fE
${_grn}    ,                   ${_red}              :         :
                        ${_RED} ${_bol}${_def}v0.1.0 ${_res}

Multi-modal printf-speed logger with switches log level in a single ${_yel}OPT_STRING${_res}.

${_mag}Philosophy:${_res}
  - No background process
  - No runtime    ${_gry}# shout is part of your shell process${_res}
  - No subprocess ${_gry}# no '|' no '&' no '\$(whatever)'${_res}
  - No bashism    ${_gry}# POSIX syntax${_res}
  - No smart options ${_gry}# static optimization.${_res}

${_mag}Usage:${_res}
  shout${_yel}[as]${_res}f [ARGUMENT...]       ${_gry}# force log${_res}
  shout ${_yel}LOG_LEVEL${_res} [ARGUMENT...]  ${_gry}# line mode${_res}
  shouta ${_yel}LOG_LEVEL${_res} [ARGUMENT...] ${_gry}# args mode${_res}
  COMMAND | shouts ${_yel}LOG_LEVEL${_res}     ${_gry}# stream mode${_res}

${_mag}Environments:${_res}
  ${_gry}# Log levels.
  ${_yel}SHOUT_LEVEL${_res}              the minimal log level accepted. Can be bypassed with ${_yel}f${_res} opt.
  ${_yel}SHOUT_DISABLED${_res}           global logging switch. Can be bypassed with ${_yel}f${_res} opt.
  ${_gry}# Default colors. All grey. Set them to null to use your regular text color.
  ${_yel}SHOUT_COLOR${_res}              default color is always appended, provided or not.
  ${_yel}SHOUT_ARGS_COLOR${_res}         default args listing color.
  ${_yel}SHOUT_STREAM_COLOR${_res}       default stream color.

${_mag}LOG_LEVEL:${_res}
  Only logs lower or equal to ${_yel}SHOUT_LEVEL${_res} will display. (unless forced)

${_mag}Examples:${_res}
  ${_gry}# see much more examples by running the tests with ${_yel}\`shoutctl test\`${_res}
  ${_gry}# This prints a red log (and resets colors) in red to stderr even if ${_yel}SHOUT_DISABLED${_gry} is set.${_res}
  shoutf "\${_red}The pizza is blue."
  ${_gry}# This prints in grey to stderr (and resets colors) if ${_yel}SHOUT_LEVEL${_gry} >= 5 and forwards to myNextProcess${_res}
  echo "streamed text" | shouts 5 | myNextProcess

${_mag}Included colors:${_res} ${_gry}(you can define and pass your own...)${_def}
foregrounds:  ${_gry}\${_gry} ${_red} \${_red}  ${_grn}\${_grn}  ${_yel}\${_yel}  ${_blu}\${_blu}  ${_mag}\${_mag}  ${_cya}\${_cya}  ${_whi}\${_whi}  ${_def}\${_def}${_def} ${_DEF}${_bla} \${_bla} ${_res}
backgrounds: ${_GRY} \${_GRY} ${_RED} \${_RED} ${_GRN}${_bla} \${_GRN} ${_YEL} \${_YEL} ${_BLU} \${_BLU} ${_MAG} \${_MAG} ${_CYA} \${_CYA} ${_WHI} \${_WHI} ${_DEF} \${_DEF} ${_BLA}${_def} \${_BLA} ${_res}
modifiers:   ${_rev} \${_rev} ${_REV} \${_REV}  ${_bol}\${_bol}${_res}${_gry} # reverse, noreverse, bold${_res}
finally:      \${_res}${_gry} # resets everything${_res}
EOF
