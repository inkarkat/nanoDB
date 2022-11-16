#!/usr/bin/env bats

load canned_databases

@test "existing single key can be queried" {
    run nanoDB --table one-entry --query-keys
    [ $status -eq 0 ]
    [ "$output" = 'foo' ]
}

@test "existing keys can be queried" {
    run nanoDB --table some-entries --query-keys
    [ $status -eq 0 ]
    [ "$output" = $'foo\nFoo\nbar\no_O\nbaz' ]
}

@test "no output with empty (just schema) table" {
    run nanoDB --table empty --query-keys
    [ $status -eq 0 ]
    [ "$output" = '' ]
}

@test "a query on a non-existing database table fails" {
    run nanoDB --table doesNotExist --query-keys
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "existing single key on a commented table omits the comment" {
    run nanoDB --table commented-entry --query-keys
    [ $status -eq 0 ]
    [ "$output" = 'foo' ]
}
