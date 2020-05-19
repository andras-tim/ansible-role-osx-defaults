#!/bin/bash
set -eufo pipefail

function main()
{
    cd "$(dirname "$0")"

    get_header
    if [ "${1-:}" == '--enable-tasks' ]; then
        get_variables
    fi
}

function get_header()
{
cat - <<EOF
---

- hosts: localhost
  remote_user: root
  roles:
    - role: ansible-role-osx-defaults
EOF
}

function get_variables()
{
    echo '      vars:'
    grep -i '_Enabled:' '../defaults/main.yml' \
        | sed -e 's|: false.*|: true|' -e 's|^|        |'
}


main "$@"
