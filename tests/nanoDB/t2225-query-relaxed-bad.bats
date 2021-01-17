#!/usr/bin/env bats

load canned_databases

@test "empty relaxed key cannot be queried" {
    run nanoDB --table some-entries --relaxed-key --query ''
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must not be empty.' ]
}

@test "relaxed key with = in it cannot be queried" {
    run nanoDB --table some-entries --relaxed-key --query 'x y=y'
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY cannot contain = character.' ]
}

