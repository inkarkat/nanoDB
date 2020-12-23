#!/usr/bin/env bats

load canned_databases

@test "existing single record table can be gotten" {
    run nanoDB --table one-entry --get-as-dictionary myDict
    [ $status -eq 0 ]
    [ "$output" = "declare -A myDict
myDict[foo]=The\ Foo\ is\ 42" ]
}

@test "existing table can be gotten" {
    run nanoDB --table some-entries --get-as-dictionary myDict
    [ $status -eq 0 ]
    [ "$output" = 'declare -A myDict
myDict[foo]=The\ Foo\ is\ 42
myDict[Foo]=The\ upper-case\ variant\ is\ 82
myDict[bar]=A\ man\ walks\ into\ a
myDict[o_O]=A\ key\ with\ underscore\ in\ it
myDict[baz]=Last\ one\ here' ]
}

@test "commented table still has the comment on top" {
    run nanoDB --table commented-entry --get-as-dictionary myDict
    [ $status -eq 0 ]
    [ "$output" = '# This is test data.
declare -A myDict
myDict[foo]=The\ Foo\ is\ 42' ]
}

@test "empty commented table has the comment and the declaration only" {
    run nanoDB --table empty --get-as-dictionary myDict
    [ $status -eq 0 ]
    [ "$output" = '# This is test data.
declare -A myDict' ]
}

@test "get-as-dictionary of non-existing table returns 1" {
    run nanoDB --table doesNotExist --get-as-dictionary myDict
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "an invalid dict-name is processed just fine (but would cause eval error)" {
    run nanoDB --table one-entry --get-as-dictionary 'my&/Dict\#'
    [ $status -eq 0 ]
    [ "$output" = 'declare -A my&/Dict\#
my&/Dict\#[foo]=The\ Foo\ is\ 42' ]
}
