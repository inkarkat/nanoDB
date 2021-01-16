#!/usr/bin/env bats

load canned_databases

@test "table with escaped values can be gotten as dict" {
    eval "$(nanoDB --table escaping --get-as-dictionary myDict)"

    [ "${myDict[tabs]}" = "the	foo	now contains		tabs	" ]
    [ "${myDict[newline]}" = "this
now
goes
over
multiple

lines" ]
    [ "${myDict[squote]}" = "with O'Brian in 'here'" ]
    [ "${myDict[dquote]}" = '"Here," I said, "leave it to me."' ]
    [ "${myDict[quotes]}" = "I muttered, \"I go with O'Brian.\"" ]
    [ "${myDict[various]}" = '/the\ * is {a,b} for @me in ?!' ]
    [ "${myDict[everything]}" = "		the what ?
\\	O'Brian has \"tons\" of stuff\!
**for** // but not here" ]
}
