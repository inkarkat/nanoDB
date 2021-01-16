#!/usr/bin/env bats

load canned_databases

@test "existing value with tab characters can be gotten" {
    run nanoDB --table escaping --query tabs
    [ $status -eq 0 ]
    [ "$output" = "the	foo	now contains		tabs	" ]
}


@test "existing value with newlines can be gotten" {
    run nanoDB --table escaping --query newline
    [ $status -eq 0 ]
    [ "$output" = "this
now
goes
over
multiple

lines" ]
}

@test "existing value with single quotes can be gotten" {
    run nanoDB --table escaping --query squote
    [ $status -eq 0 ]
    [ "$output" = "with O'Brian in 'here'" ]
}

@test "existing value with double quotes can be gotten" {
    run nanoDB --table escaping --query dquote
    [ $status -eq 0 ]
    [ "$output" = '"Here," I said, "leave it to me."' ]
}

@test "existing value with single and double quotes can be gotten" {
    run nanoDB --table escaping --query quotes
    [ $status -eq 0 ]
    [ "$output" = "I muttered, \"I go with O'Brian.\"" ]
}

@test "existing value with various special characters can be gotten" {
    run nanoDB --table escaping --query various
    [ $status -eq 0 ]
    [ "$output" = '/the\ * is {a,b} for @me in ?!' ]
}

@test "existing value with everything can be gotten" {
    run nanoDB --table escaping --query everything
    [ $status -eq 0 ]
    [ "$output" = "		the what ?
\\	O'Brian has \"tons\" of stuff\!
**for** // but not here" ]
}
