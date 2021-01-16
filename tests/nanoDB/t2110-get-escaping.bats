#!/usr/bin/env bats

load canned_databases

@test "existing value with tab characters can be gotten" {
    run nanoDB --table escaping --get tabs
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "$output" = "tabs=\$'the\\tfoo\\tnow contains\\t\\ttabs\\t'" ]
    eval "$output"
    [ "$tabs" = "the	foo	now contains		tabs	" ]
}


@test "existing value with newlines can be gotten" {
    run nanoDB --table escaping --get newline
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "$output" = "newline=\$'this\\nnow\\ngoes\\nover\\nmultiple\\n\\nlines'" ]
    eval "$output"
    [ "$newline" = "this
now
goes
over
multiple

lines" ]
}

@test "existing value with single quotes can be gotten" {
    run nanoDB --table escaping --get squote
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "$output" = "squote=with\ O\'Brian\ in\ \'here\\'" ]
    eval "$output"
    [ "$squote" = "with O'Brian in 'here'" ]
}

@test "existing value with double quotes can be gotten" {
    run nanoDB --table escaping --get dquote
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "$output" = "dquote=\\\"Here\\,\\\"\\ I\\ said\\,\\ \\\"leave\\ it\\ to\\ me.\\\"" ]
    eval "$output"
    [ "$dquote" = '"Here," I said, "leave it to me."' ]
}

@test "existing value with single and double quotes can be gotten" {
    run nanoDB --table escaping --get quotes
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "$output" = "quotes=I\\ muttered\\,\\ \\\"I\\ go\\ with\\ O\\'Brian.\\\"" ]
    eval "$output"
    [ "$quotes" = "I muttered, \"I go with O'Brian.\"" ]
}

@test "existing value with various special characters can be gotten" {
    run nanoDB --table escaping --get various
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "$output" = "various=/the\\\\\\ \\*\\ is\\ \\{a\\,b\\}\\ for\\ @me\\ in\\ \\?\\!" ]
    eval "$output"
    [ "$various" = '/the\ * is {a,b} for @me in ?!' ]
}

@test "existing value with everything can be gotten" {
    run nanoDB --table escaping --get everything
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 1 ]
    [ "$output" = "everything=\$'\\t\\tthe what ?\\n\\\\\\tO\\'Brian has \"tons\" of stuff\\\\!\\n**for** // but not here'" ]
    eval "$output"
    [ "$everything" = "		the what ?
\\	O'Brian has \"tons\" of stuff\!
**for** // but not here" ]
}
