#!/usr/bin/env bats

load canned_databases

@test "table with relaxed keys can be gotten" {
    run nanoDB --table relaxed --relaxed-key --get-all
    [ $status -eq 0 ]
    [ "$output" = "$(cat "${BATS_TEST_DIRNAME}/databases/relaxed")" ]
}

@test "eval of table with relaxed keys fails" {
    ! eval "$(nanoDB --table relaxed --relaxed-key --get-all)"
}
