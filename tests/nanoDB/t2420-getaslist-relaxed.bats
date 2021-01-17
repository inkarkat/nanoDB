#!/usr/bin/env bats

load canned_databases

@test "table with relaxed keys can be gotten as list" {
    run nanoDB --table relaxed --relaxed-key --get-as-list '-'
    [ $status -eq 0 ]
    [ "$output" = "key with spaces-spaces
key	with	tabs-tabs
key
with
newlines-newline
O'Brian-squote
a\"word\"-dquote
\"O'Brian.\"-quotes
the\\ * is {a,b}-various
		the what ?
\\	O'Brian has \"tons\" of stuff\\!
**for** // but not here-everything" ]
}

@test "newline table with relaxed keys can be gotten as list" {
    run nanoDB --table newlines --relaxed-key --get-as-list '-'
    [ $status -eq 0 ]
    [ "$output" = "key
with
newlines-newline
value with newlines-this
now
goes
over
multiple

lines
key and value
with
newlines-this
now
goes
over
multiple

lines" ]
}

@test "newline table with relaxed keys can be gotten as list with cut-off on first newline" {
    run nanoDB --table newlines --relaxed-key --get-as-list '-' --newline-formatting cut-off
    [ $status -eq 0 ]
    [ "$output" = "key-newline
value with newlines-this
key and value-this" ]
}

@test "newline table with relaxed keys can be gotten as list with newline prefixed with duplicated key" {
    run nanoDB --table newlines --relaxed-key --get-as-list '-' --newline-formatting duplicate-key
    [ $status -eq 0 ]
    [ "$output" = "key-newline
value with newlines-this
value with newlines-now
value with newlines-goes
value with newlines-over
value with newlines-multiple
value with newlines-
value with newlines-lines
key and value-this
key and value-now
key and value-goes
key and value-over
key and value-multiple
key and value-
key and value-lines" ]
}

