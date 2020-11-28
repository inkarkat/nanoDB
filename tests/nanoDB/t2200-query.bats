#!/usr/bin/env bats

load canned_databases

@test "existing single key can be queried" {
    run nanoDB --table one-entry --query foo
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "${lines[0]}" = 'The Foo is 42' ]
}

@test "non-existing key query fails" {
    run nanoDB --table one-entry --query notInHere
    [ $status -eq 4 ]
    [ "${#lines[@]}" -eq 0 ]
}

@test "key can be queried among many" {
    run nanoDB --table some-entries --query bar
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "${lines[0]}" = 'A man walks into a' ]
}

@test "key query is case-sensitive" {
    run nanoDB --table some-entries --query Foo
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "${lines[0]}" = 'The upper-case variant is 82' ]
}

@test "need a full key match" {
    run nanoDB --table some-entries --query oo
    [ $status -eq 4 ]
    [ "${#lines[@]}" -eq 0 ]
}

@test "key with underscore in it can be queried" {
    run nanoDB --table some-entries --query 'o_O'
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "${lines[0]}" = 'A key with underscore in it' ]
}
