#!/bin/bash
set -eufo pipefail

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_APPLY='false'


function main()
{
    if [ "${1:-}" == '--check-apply' ]; then
        CHECK_APPLY='true'
    fi

    prepare_test_files
    run_static_analyzers
    run_ansible_on_test_playbooks
}

function prepare_test_files()
{
    (
        set -x
        "${BASE_DIR}/tests/.generate-test-playbook.sh" > "${BASE_DIR}/tests/test_defaults.yml"
        "${BASE_DIR}/tests/.generate-test-playbook.sh" --enable-tasks > "${BASE_DIR}/tests/test_all_modules.yml"
    )
}

function run_static_analyzers()
{
    exec_yaml_analyzers
    exec_ansible "${BASE_DIR}/tests/test_defaults.yml" --syntax-check
    exec_ansible "${BASE_DIR}/tests/test_all_modules.yml" --syntax-check
}

function exec_yaml_analyzers()
{
    cd "${BASE_DIR}"

    (
        set -x
        yamllint -f colored -c "${BASE_DIR}/tests/yamllint.yaml" "${BASE_DIR}"
        ansible-lint -v --force-color "${BASE_DIR}"
    )
}

function run_ansible_on_test_playbooks()
{
    # Test defaults do nothing
    exec_ansible_w_status_check 'Defaults' 'changed=0.*failed=0' "${BASE_DIR}/tests/test_defaults.yml"

    if [ "${CHECK_APPLY}" == 'true' ]; then
        # Test dry-run
        exec_ansible_w_status_check 'Dry-run' 'changed=[^0].*failed=0' "${BASE_DIR}/tests/test_all_modules.yml" --check

        # Test production
        exec_ansible_w_status_check 'Production' 'changed=[^0].*failed=0' "${BASE_DIR}/tests/test_all_modules.yml"

        # Test idempotence
        exec_ansible_w_status_check 'Idempotence' 'changed=0.*failed=0' "${BASE_DIR}/tests/test_all_modules.yml"
    fi
}

function exec_ansible()
{
    cd "${BASE_DIR}/tests"

    (
        set -x
        ansible-playbook -i "${BASE_DIR}/tests/inventory" "$@"
    )
}

function exec_ansible_w_status_check()
{
    local suite_name="$1"
    local expected_pattern="$2"
    local playbook_file="$3"
    shift 3
    local output_path

    output_path="$(mktemp -t "ansible-test-${suite_name}_XXXX")"

    exec_ansible "${playbook_file}" "$@" \
        | tee "${output_path}"

    tail "${output_path}" \
        | grep -q "${expected_pattern}" \
            && { echo "${suite_name} test: PASS" >&2; } \
            || { echo "${suite_name}: FAIL" >&2; exit 1; }
}

main "$@"
