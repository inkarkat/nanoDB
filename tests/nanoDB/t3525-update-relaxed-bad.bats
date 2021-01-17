#!/usr/bin/env bats

load temp_database

@test "update of a table with an empty relaxed key is rejected" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    run nanoDB --table "$BATS_TEST_NAME" --relaxed-key --update "=The key is empty"
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: KEY must not be empty.' ]
    [ "$(get_row_number "$BATS_TEST_NAME")" -eq 1 ]
}
