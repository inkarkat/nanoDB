#!/usr/bin/env bats

load canned_databases

@test "table with escaped values can be gotten" {
    eval "$(nanoDB --table escaping --get-all)"

    [ "$tabs" = "the	foo	now contains		tabs	" ]
    [ "$newline" = "this
now
goes
over
multiple

lines" ]
    [ "$squote" = "with O'Brian in 'here'" ]
    [ "$dquote" = '"Here," I said, "leave it to me."' ]
    [ "$quotes" = "I muttered, \"I go with O'Brian.\"" ]
    [ "$various" = '/the\ * is {a,b} for @me in ?!' ]
    [ "$everything" = "		the what ?
\\	O'Brian has \"tons\" of stuff\!
**for** // but not here" ]
}
