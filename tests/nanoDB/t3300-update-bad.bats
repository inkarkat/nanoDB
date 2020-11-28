#!/usr/bin/env bats

load temp_database

@test "update action with no table prints message and usage instructions" {
    run nanoDB --update "quux=This has been added"
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No TABLE passed.' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "update of a table with an empty key is rejected" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    run nanoDB --table "$BATS_TEST_NAME" --update "=The key is empty"
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must not be empty.' ]
}

@test "update of a table starting with 1 is rejected" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    run nanoDB --table "$BATS_TEST_NAME" --update "1more=number is invalid at start"
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must be a valid variable name.' ]
}

@test "update of a table with - in key is rejected" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    run nanoDB --table "$BATS_TEST_NAME" --update "x-y=dash is invalid"
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must be a valid variable name.' ]
}

@test "update of a table with * key is rejected" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    run nanoDB --table "$BATS_TEST_NAME" --update "*=asterisk is invalid"
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must be a valid variable name.' ]
}

@test "update of a table with key with spaces is rejected" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    run nanoDB --table "$BATS_TEST_NAME" --update "x y=space is invalid"
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must be a valid variable name.' ]
}

@test "update of a table with key with newline is rejected" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    run nanoDB --table "$BATS_TEST_NAME" --update $'x\ny=space is invalid'
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must be a valid variable name.' ]
}

@test "update without value specified is rejected" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    run nanoDB --table "$BATS_TEST_NAME" --update "key"
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Need VALUE to update.' ]
}