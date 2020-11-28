#!/usr/bin/env bats

load canned_databases

@test "existing single key can be gotten" {
    run nanoDB --table one-entry --get foo
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "${lines[0]}" = 'foo=The\ Foo\ is\ 42' ]
}

@test "non-existing key query fails" {
    run nanoDB --table one-entry --get notInHere
    [ $status -eq 4 ]
    [ "${#lines[@]}" -eq 0 ]
}

@test "key can be queried among many" {
    run nanoDB --table some-entries --get bar
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "${lines[0]}" = 'bar=A\ man\ walks\ into\ a' ]
}

@test "key query is case-sensitive" {
    run nanoDB --table some-entries --get Foo
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "${lines[0]}" = 'Foo=The\ upper-case\ variant\ is\ 82' ]
}

@test "need a full key match" {
    run nanoDB --table some-entries --get oo
    [ $status -eq 4 ]
    [ "${#lines[@]}" -eq 0 ]
}

@test "key with underscore in it can be queried" {
    run nanoDB --table some-entries --get 'o_O'
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "${lines[0]}" = 'o_O=A\ key\ with\ underscore\ in\ it' ]
}
