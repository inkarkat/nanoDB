#!/usr/bin/env bats

load canned_databases

@test "table with relaxed keys can be gotten as dict" {
    eval "$(nanoDB --table relaxed --relaxed-key --get-as-dictionary myDict)"

    [ "${myDict[key\ with\ spaces]}" = "spaces" ]
    [ "${myDict[$'key\twith\ttabs']}" = "tabs" ]
    [ "${myDict[$'key\nwith\nnewlines']}" = "newline" ]
    [ "${myDict[O\'Brian]}" = "squote" ]
    [ "${myDict[a\"word\"]}" = "dquote" ]
    [ "${myDict[\"O\'Brian.\"]}" = "quotes" ]
    [ "${myDict[the\\\ \*\ is\ \{a\,b\}]}" = "various" ]
    [ "${myDict["		the what ?
\\	O'Brian has \"tons\" of stuff\\!
**for** // but not here"]}" = "everything" ]
}
