#!/usr/bin/env bats

load usage

@test "multiple actions print usage error" {
    run nanoDB --table some-entries --query foo --update "fox=bar"
    [ $status -eq 2 ]
    assert_multiple_actions_error
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "invalid base-type prints usage error" {
    run nanoDB --base-type doesNotExist --table whatever --query foo
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Invalid base-type "doesNotExist".' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "invalid table with slash prints usage error" {
    run nanoDB --table not/allowed --query foo
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: TABLE must not contain slashes.' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}
