#!/usr/bin/env bats

load temp_database

@test "update of a table with an empty value is okay" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    run nanoDB --table "$BATS_TEST_NAME" --update "foo="
    [ $status -eq 0 ]
    assert_table_row "$BATS_TEST_NAME" 1 "foo=''"
    assert_table_row "$BATS_TEST_NAME" \$ "foo=''"
}

@test "update of a table with an empty value as a separate command-line argument is okay" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    run nanoDB --table "$BATS_TEST_NAME" --update "foo" --value ''
    [ $status -eq 0 ]
    assert_table_row "$BATS_TEST_NAME" 1 "foo=''"
    assert_table_row "$BATS_TEST_NAME" \$ "foo=''"
}

@test "update of a table where the key contains a number is okay" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    run nanoDB --table "$BATS_TEST_NAME" --update "one4all=number inside key"
    [ $status -eq 0 ]
    assert_table_row "$BATS_TEST_NAME" 2 "one4all=number\ inside\ key"
}
