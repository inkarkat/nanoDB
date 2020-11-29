#!/usr/bin/env bats

@test "drop action with no table prints message and usage instructions" {
    run nanoDB --drop
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No TABLE passed.' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "a drop of a non-existing database fails" {
    run nanoDB --table doesNotExist --drop

    [ $status -eq 1 ]
    [ "$output" = "" ]
}
