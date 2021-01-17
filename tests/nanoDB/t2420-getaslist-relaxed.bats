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

@test "newline table with relaxed keys can be gotten as list with newline as error" {
    run nanoDB --table newlines --relaxed-key --get-as-list '-' --newline-formatting error
    [ $status -eq 1 ]
    [ "$output" = "ERROR: Key \$'key\\nwith\\nnewlines' spans multiple lines." ]
}

@test "table with relaxed keys and escaped values can be gotten as list with newline as error" {
    run nanoDB --table escaping --relaxed-key --get-as-list '-' --newline-formatting error
    [ $status -eq 1 ]

    [ "$output" = "tabs-the	foo	now contains		tabs	
ERROR: Value \$'this\\nnow\\ngoes\\nover\\nmultiple\\n\\nlines' spans multiple lines." ]
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


@test "newline table with relaxed keys can be gotten as list with newlines replaced with XX" {
    run nanoDB --table newlines --relaxed-key --get-as-list '-' --newline-formatting XX
    [ $status -eq 0 ]
    [ "$output" = "keyXXwithXXnewlines-newline
value with newlines-thisXXnowXXgoesXXoverXXmultipleXXXXlines
key and valueXXwithXXnewlines-thisXXnowXXgoesXXoverXXmultipleXXXXlines" ]
}

@test "newline table with relaxed keys can be gotten as list with newlines replaced with line continuation" {
    run nanoDB --table newlines --relaxed-key --get-as-list '-' --newline-formatting $'\\\n'
    [ $status -eq 0 ]
    [ "$output" = "key\\
with\\
newlines-newline
value with newlines-this\\
now\\
goes\\
over\\
multiple\\
\\
lines
key and value\\
with\\
newlines-this\\
now\\
goes\\
over\\
multiple\\
\\
lines" ]
}
