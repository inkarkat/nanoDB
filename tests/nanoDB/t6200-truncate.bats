#!/usr/bin/env bats

load temp_database

@test "existing database can be truncated and only consists of the comment then" {
    initialize_table "$BATS_TEST_NAME" from commented-entry

    run nanoDB --table "$BATS_TEST_NAME" --truncate

    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 0 ]
    table_exists "$BATS_TEST_NAME"
    [ "$(get_row_number "$BATS_TEST_NAME")" -eq 1 ]
    assert_table_row "$BATS_TEST_NAME" 1 "# This is test=data."
}

@test "truncate of empty database is a no-op" {
    initialize_table "$BATS_TEST_NAME" from empty

    run nanoDB --table "$BATS_TEST_NAME" --truncate

    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 0 ]
    table_exists "$BATS_TEST_NAME"
    [ "$(get_row_number "$BATS_TEST_NAME")" -eq 1 ]
    assert_table_row "$BATS_TEST_NAME" 1 "# This is test=data." ]
}

@test "truncate of a non-existing table initializes it with an empty line" {
    clean_table "$BATS_TEST_NAME"

    nanoDB --table "$BATS_TEST_NAME" --truncate

    table_exists "$BATS_TEST_NAME"
    [ "$(get_row_number "$BATS_TEST_NAME")" -eq 1 ]
    assert_table_row "$BATS_TEST_NAME" 1 ""
}

@test "truncate of a non-existing table with passed comment initializes it with it" {
    clean_table "$BATS_TEST_NAME"

    nanoDB --table "$BATS_TEST_NAME" --comment "fresh data" --truncate

    table_exists "$BATS_TEST_NAME"
    [ "$(get_row_number "$BATS_TEST_NAME")" -eq 1 ]
    assert_table_row "$BATS_TEST_NAME" 1 "# fresh data"
}
