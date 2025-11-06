#!/bin/sh

set -e

awk <./skaffold.sh -v "res=$_res" -v "shout_color=$SHOUT_COLOR" -v "shout_args_color=$SHOUT_ARGS_COLOR" -v "shout_stream_color=$SHOUT_STREAM_COLOR" '
/^}/ {if(rec!="") print "}"; rec=""; next}

/shoutf\(\)/  { rec="f" ; print; next }
/shoutaf\(\)/ { rec="af"; print; next }
/shoutsf\(\)/ { rec="sf"; print; next }

rec=="f"  { gsub(/\$SHOUT_COLOR/, shout_color); gsub(/\$_res/, res);               shoutf   = shoutf  $0 ORS }
rec=="af" { gsub(/\$SHOUT_ARGS_COLOR/, shout_args_color); gsub(/\$_res/, res);     shoutaf  = shoutaf $0 ORS }
rec=="sf" { gsub(/\$SHOUT_STREAM_COLOR/, shout_stream_color); gsub(/\$_res/, res); shoutsf  = shoutsf $0 ORS }

/##! shoutf/  { print shoutf  "}"; next }
/##! shoutaf/ { print shoutaf "}"; next }
/##! shoutsf/ { print shoutsf "}"; next }

{print}
'
