#!/bin/sh

set -e

NAME=shoutctl

install_dir=${1:-$HOME/.local/bin}
target="$install_dir/$NAME"
entry=$(CDPATH="" cd -- "$(dirname "$0")" && pwd)

mkdir -p "$install_dir"

cat <<EOF >"$target"
#!/bin/sh

set -e

export ENTRY=$entry
EOF

tail -n +2 "$entry/shoutctl.sh" >>"$target"

chmod 744 "$target"

case :$PATH: in
*":$install_dir:"*)
  # The install dir is already in the shell path, nothing to do.
  ;;
*)
  cat <<EOF
"$install_dir" is not in your shell path.
Please add it with "PATH=$install_dir:\$PATH"
or move "$target" to an appropriate place.
EOF
  ;;
esac
