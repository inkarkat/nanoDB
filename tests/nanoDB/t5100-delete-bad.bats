#!/usr/bin/env bats

load temp_database

@test "delete action with no table prints message and usage instructions" {
    run nanoDB --delete foo
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No TABLE passed.' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "a delete key that contains a = character is rejected" {
    run nanoDB --table "$BATS_TEST_NAME" --delete "with=equals"
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY cannot contain = character.' ]
}

@test "an empty delete key is rejected" {
    run nanoDB --table "$BATS_TEST_NAME" --delete ""
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must not be empty.' ]
}

@test "a delete on a non-existing database fails" {
    clean_table "$BATS_TEST_NAME"

    run nanoDB --table doesNotExist --delete whatever

    [ $status -eq 1 ]
    [ "$output" = "" ]
    ! table_exists "$BATS_TEST_NAME"
}
