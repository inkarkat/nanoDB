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
}
