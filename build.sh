#!/bin/sh

set -e

awk -v "res=$_res" -v "shout_color=$SHOUT_COLOR" -v "shout_args_color=$SHOUT_ARGS_COLOR" -v "shout_stream_color=$SHOUT_STREAM_COLOR" '
/^[[:space:]]*:$/ {next}
/^}/ {
  if(rec!="" && rec!="early" && rec!="level") print "}";
  rec="";
  next
}

/shoutf\(\)/  { rec="shoutf" ; print; next }
/shoutaf\(\)/ { rec="shoutaf"; print; next }
/shoutsf\(\)/ { rec="shoutsf"; print; next }
/early\(\)/   { rec="early"; next }
/level\(\)/   { rec="level"; next }

rec=="shoutf"  { gsub(/\$SHOUT_COLOR/, shout_color); gsub(/\$_res/, res);               shoutf   = shoutf  $0 ORS; print; next }
rec=="shoutaf" { gsub(/\$SHOUT_ARGS_COLOR/, shout_args_color); gsub(/\$_res/, res);     shoutaf  = shoutaf $0 ORS; print; next }
rec=="shoutsf" { gsub(/\$SHOUT_STREAM_COLOR/, shout_stream_color); gsub(/\$_res/, res); shoutsf  = shoutsf $0 ORS; print; next }
rec=="early" { early = early $0 ORS; next }
rec=="level" { level = level $0 ORS; next }

/##! shoutf/  { sub(/\n$/, "", shoutf );print shoutf ORS "}"; next }
/##! shoutaf/ { sub(/\n$/, "", shoutaf );print shoutaf ORS "}"; next }
/##! shoutsf/ { sub(/\n$/, "", shoutsf );print shoutsf ORS "}"; next }
/##! early/ { sub(/\n$/, "", early );print early ; next }
/##! level/ { sub(/\n$/, "", level );print level ; next }

!/^[[:space:]]*$/ {print}
' <./skaffold.sh >./libshout.sh
