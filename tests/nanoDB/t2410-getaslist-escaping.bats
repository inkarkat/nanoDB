#!/usr/bin/env bats

load canned_databases

@test "table with escaped values can be gotten as list" {
    run nanoDB --table escaping --get-as-list '-'
    [ $status -eq 0 ]

    [ "${lines[0]}" = "tabs-the	foo	now contains		tabs	" ]
    [ "${lines[1]}" = "newline-this" ]
    [ "${lines[2]}" = "now" ]
    [ "${lines[3]}" = "goes" ]
    [ "${lines[4]}" = "over" ]
    [ "${lines[5]}" = "multiple" ]
    [ "${lines[6]}" = "lines" ]
    [ "${lines[7]}" = "squote-with O'Brian in 'here'" ]
    [ "${lines[8]}" = 'dquote-"Here," I said, "leave it to me."' ]
    [ "${lines[9]}" = "quotes-I muttered, \"I go with O'Brian.\"" ]
    [ "${lines[10]}" = 'various-/the\ * is {a,b} for @me in ?!' ]
    [ "${lines[11]}" = "everything-		the what ?" ]
    [ "${lines[12]}" = "\\	O'Brian has \"tons\" of stuff\!" ]
    [ "${lines[13]}" = "**for** // but not here" ]

    [ "$output" = "tabs-the	foo	now contains		tabs	
newline-this
now
goes
over
multiple

lines
squote-with O'Brian in 'here'
dquote-\"Here,\" I said, \"leave it to me.\"
quotes-I muttered, \"I go with O'Brian.\"
various-/the\\ * is {a,b} for @me in ?!
everything-		the what ?
\\	O'Brian has \"tons\" of stuff\!
**for** // but not here" ]
}

@test "table with escaped values can be gotten as list with newline as error" {
    run nanoDB --table escaping --get-as-list '-' --newline-formatting error
    [ $status -eq 1 ]

    [ "$output" = "tabs-the	foo	now contains		tabs	" ]
}

@test "table with escaped values can be gotten as list with cut-off on first newline" {
    run nanoDB --table escaping --get-as-list '-' --newline-formatting cut-off
    [ $status -eq 0 ]

    [ "$output" = "tabs-the	foo	now contains		tabs	
newline-this
squote-with O'Brian in 'here'
dquote-\"Here,\" I said, \"leave it to me.\"
quotes-I muttered, \"I go with O'Brian.\"
various-/the\\ * is {a,b} for @me in ?!
everything-		the what ?" ]
}

@test "table with escaped values can be gotten as list with newline prefixed with duplicated key" {
    run nanoDB --table escaping --get-as-list '-' --newline-formatting duplicate-key
    [ $status -eq 0 ]

    [ "$output" = "tabs-the	foo	now contains		tabs	
newline-this
newline-now
newline-goes
newline-over
newline-multiple
newline-
newline-lines
squote-with O'Brian in 'here'
dquote-\"Here,\" I said, \"leave it to me.\"
quotes-I muttered, \"I go with O'Brian.\"
various-/the\\ * is {a,b} for @me in ?!
everything-		the what ?
everything-\\	O'Brian has \"tons\" of stuff\!
everything-**for** // but not here" ]
}

@test "table with escaped values can be gotten as list with newlines replaced with XX" {
    run nanoDB --table escaping --get-as-list '-' --newline-formatting XX
    [ $status -eq 0 ]

    [ "$output" = "tabs-the	foo	now contains		tabs	
newline-thisXXnowXXgoesXXoverXXmultipleXXXXlines
squote-with O'Brian in 'here'
dquote-\"Here,\" I said, \"leave it to me.\"
quotes-I muttered, \"I go with O'Brian.\"
various-/the\\ * is {a,b} for @me in ?!
everything-		the what ?XX\\	O'Brian has \"tons\" of stuff\!XX**for** // but not here" ]
}

@test "table with escaped values can be gotten as list with newlines replaced with line continuation" {
    run nanoDB --table escaping --get-as-list '-' --newline-formatting $'\\\n'
    [ $status -eq 0 ]

    [ "$output" = "tabs-the	foo	now contains		tabs	
newline-this\\
now\\
goes\\
over\\
multiple\\
\\
lines
squote-with O'Brian in 'here'
dquote-\"Here,\" I said, \"leave it to me.\"
quotes-I muttered, \"I go with O'Brian.\"
various-/the\\ * is {a,b} for @me in ?!
everything-		the what ?\\
\\	O'Brian has \"tons\" of stuff\!\\
**for** // but not here" ]
}
