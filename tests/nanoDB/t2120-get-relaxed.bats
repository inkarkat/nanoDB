#!/usr/bin/env bats

load canned_databases

@test "existing relaxed key with spaces can be gotten" {
    run nanoDB --table relaxed --relaxed-key --get 'key with spaces'
    [ $status -eq 0 ]
    [ "$output" = 'key\ with\ spaces=spaces' ]
}

@test "existing relaxed key with tabs can be gotten" {
    run nanoDB --table relaxed --relaxed-key --get $'key\twith\ttabs'
    [ $status -eq 0 ]
    [ "$output" = "\$'key\twith\ttabs'=tabs" ]
}

@test "existing relaxed key with newlines can be gotten" {
    run nanoDB --table relaxed --relaxed-key --get $'key\nwith\nnewlines'
    [ $status -eq 0 ]
    [ "$output" = "\$'key\\nwith\\nnewlines'=newline" ]
}

@test "existing relaxed key with single quotes can be gotten" {
    run nanoDB --table relaxed --relaxed-key --get O\'Brian
    [ $status -eq 0 ]
    [ "$output" = "O\\'Brian=squote" ]
}

@test "existing relaxed key with double quotes can be gotten" {
    run nanoDB --table relaxed --relaxed-key --get a\"word\"
    [ $status -eq 0 ]
    [ "$output" = 'a\"word\"=dquote' ]
}

@test "existing relaxed key with single and double quotes can be gotten" {
    run nanoDB --table relaxed --relaxed-key --get \"O\'Brian.\"
    [ $status -eq 0 ]
    [ "$output" = "\\\"O\\'Brian.\\\"=quotes" ]
}

@test "existing relaxed key with various special characters can be gotten" {
    run nanoDB --table relaxed --relaxed-key --get the\\\ \*\ is\ \{a\,b\}
    [ $status -eq 0 ]
    [ "$output" = 'the\\\ \*\ is\ \{a\,b\}=various' ]
}

@test "existing relaxed key with everything can be gotten" {
    run nanoDB --table relaxed --relaxed-key --get $'\t\tthe what ?\n\\\tO\'Brian has "tons" of stuff\\!\n**for** // but not here'
    [ $status -eq 0 ]
    [ "$output" = "\$'\\t\\tthe what ?\\n\\\\\\tO\\'Brian has \"tons\" of stuff\\\\!\\n**for** // but not here'=everything" ]
}

@test "eval of existing relaxed key with spaces fails" {
    ! eval "$(nanoDB --table relaxed --relaxed-key --get 'key with spaces')"
}

@test "eval of existing relaxed key with everything fails" {
    ! eval "$(nanoDB --table relaxed --relaxed-key --get $'\t\tthe what ?\n\\\tO\'Brian has "tons" of stuff\\!\n**for** // but not here')"
}
