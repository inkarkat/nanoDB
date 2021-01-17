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
