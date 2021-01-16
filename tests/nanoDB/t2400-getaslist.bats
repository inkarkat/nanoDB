#!/usr/bin/env bats

load canned_databases

@test "existing single record table as list can be gotten with original = separator" {
    run nanoDB --table one-entry --get-as-list '='
    [ $status -eq 0 ]
    [ "$output" = "foo=The Foo is 42" ]
}

@test "existing single record table as list can be gotten with space separator" {
    run nanoDB --table one-entry --get-as-list ' '
    [ $status -eq 0 ]
    [ "$output" = "foo The Foo is 42" ]
}

@test "existing single record table as list can be gotten with tab separator" {
    run nanoDB --table one-entry --get-as-list $'\t'
    [ $status -eq 0 ]
    [ "$output" = "foo	The Foo is 42" ]
}

@test "existing single record table as list can be gotten with ,,, separator" {
    run nanoDB --table one-entry --get-as-list ',,,'
    [ $status -eq 0 ]
    [ "$output" = "foo,,,The Foo is 42" ]
}

@test "existing single record table as list can be gotten with empty separator" {
    run nanoDB --table one-entry --get-as-list ''
    [ $status -eq 0 ]
    [ "$output" = "fooThe Foo is 42" ]
}

@test "existing table as list can be gotten" {
    run nanoDB --table some-entries --get-as-list '-'
    [ $status -eq 0 ]
    [ "$output" = 'foo-The Foo is 42
Foo-The upper-case variant is 82
bar-A man walks into a
o_O-A key with underscore in it
baz-Last one here' ]
}

@test "commented table as list has the comment removed" {
    run nanoDB --table commented-entry --get-as-list '-'
    [ $status -eq 0 ]
    [ "$output" = 'foo-The Foo is 42' ]
}

@test "empty commented table as list returns nothing" {
    run nanoDB --table empty --get-as-list '-'
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "get-as-list of non-existing table returns 1" {
    run nanoDB --table doesNotExist --get-as-list '-'
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
