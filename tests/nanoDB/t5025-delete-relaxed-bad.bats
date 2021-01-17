#!/usr/bin/env bats

load temp_database

@test "a relaxed delete key that contains a = character is rejected" {
    run nanoDB --table "$BATS_TEST_NAME" --relaxed-key --delete "x y=equals"
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY cannot contain = character.' ]
}

@test "an empty relaxed delete key is rejected" {
    run nanoDB --table "$BATS_TEST_NAME" --relaxed-key --delete ""
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must not be empty.' ]
}
