#!/bin/sh

set -e

awk <./skaffold.sh '
/^}/ {if(rec!="") print "}"; rec=""; next}

/shoutf\(\)/  { rec="f" ; print; next }
/shoutaf\(\)/ { rec="af"; print; next }
/shoutsf\(\)/ { rec="sf"; print; next }

rec=="f"  { shoutf  = shoutf  $0 ORS }
rec=="af" { shoutaf = shoutaf $0 ORS }
rec=="sf" { shoutsf = shoutsf $0 ORS }

/##! shoutf/  { print shoutf  "}"; next }
/##! shoutaf/ { print shoutaf "}"; next }
/##! shoutsf/ { print shoutsf "}"; next }

{print}
'
