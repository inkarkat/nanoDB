#!/usr/bin/env bats

load canned_databases

@test "existing value from relaxed key with spaces can be gotten" {
    run nanoDB --table relaxed --relaxed-key --query 'key with spaces'
    [ $status -eq 0 ]
    [ "$output" = 'spaces' ]
}

@test "existing value from relaxed key with tabs can be gotten" {
    run nanoDB --table relaxed --relaxed-key --query $'key\twith\ttabs'
    [ $status -eq 0 ]
    [ "$output" = "tabs" ]
}

@test "existing value from relaxed key with newlines can be gotten" {
    run nanoDB --table relaxed --relaxed-key --query $'key\nwith\nnewlines'
    [ $status -eq 0 ]
    [ "$output" = "newline" ]
}

@test "existing value from relaxed key with single quotes can be gotten" {
    run nanoDB --table relaxed --relaxed-key --query O\'Brian
    [ $status -eq 0 ]
    [ "$output" = "squote" ]
}

@test "existing value from relaxed key with single quotes can be gotten" {
    run nanoDB --table relaxed --relaxed-key --query a\"word\"
    [ $status -eq 0 ]
    [ "$output" = 'dquote' ]
}

@test "existing value from relaxed key with single and double quotes can be gotten" {
    run nanoDB --table relaxed --relaxed-key --query \"O\'Brian.\"
    [ $status -eq 0 ]
    [ "$output" = "quotes" ]
}

@test "existing value from relaxed key with various special characters can be gotten" {
    run nanoDB --table relaxed --relaxed-key --query the\\\ \*\ is\ \{a\,b\}
    [ $status -eq 0 ]
    [ "$output" = 'various' ]
}

@test "existing value from relaxed key with everything can be gotten" {
    run nanoDB --table relaxed --relaxed-key --query $'\t\tthe what ?\n\\\tO\'Brian has "tons" of stuff\\!\n**for** // but not here'
    [ $status -eq 0 ]
    [ "$output" = "everything" ]
}
