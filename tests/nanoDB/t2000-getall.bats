#!/usr/bin/env bats

load canned_databases

@test "existing single record table can be gotten" {
    run nanoDB --table one-entry --get-all
    [ $status -eq 0 ]
    [ "$output" = "foo=The\ Foo\ is\ 42" ]
}

@test "existing table can be gotten" {
    run nanoDB --table some-entries --get-all
    [ $status -eq 0 ]
    [ "$output" = "$(cat -- "${XDG_CONFIG_HOME}/some-entries")" ]
}

@test "get-all of non-existing table returns 1" {
    run nanoDB --table doesNotExist --get-all
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
