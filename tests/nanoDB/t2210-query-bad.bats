#!/usr/bin/env bats

load canned_databases

@test "empty key cannot be queried" {
    run nanoDB --table some-entries --query ''
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must not be empty.' ]
}

@test "key with = in it cannot be queried" {
    run nanoDB --table some-entries --query 'x=y'
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY cannot contain = character.' ]
}

@test "key starting with 1 cannot be queried" {
    run nanoDB --table some-entries --query '1more'
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must be a valid variable name.' ]
}

@test "key with - in it cannot be queried" {
    run nanoDB --table some-entries --query 'x-y'
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must be a valid variable name.' ]
}

@test "key with * in it cannot be queried" {
    run nanoDB --table some-entries --query 'x*y'
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must be a valid variable name.' ]
}

@test "key with spaces in it cannot be queried" {
    run nanoDB --table some-entries --query 'x y '
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must be a valid variable name.' ]
}

@test "key with newline in it cannot be queried" {
    run nanoDB --table some-entries --query $'x\n'
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must be a valid variable name.' ]
}
