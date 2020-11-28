#!/usr/bin/env bats

load temp_database

setup()
{
    clean_table "$BATS_TEST_NAME"
}

@test "update of a non-existing table initializes it with the passed key and value" {
    nanoDB --table "$BATS_TEST_NAME" --update "key=value"

    assert_table_row "$BATS_TEST_NAME" 1 "key=value"
    assert_table_row "$BATS_TEST_NAME" \$ "key=value"
}

@test "update of a non-existing table initializes it with a comment and the passed key and value" {
    nanoDB --table "$BATS_TEST_NAME" --comment "fresh data" --update "key=value"

    assert_table_row "$BATS_TEST_NAME" 1 "# fresh data"
    assert_table_row "$BATS_TEST_NAME" 2 "key=value"
    assert_table_row "$BATS_TEST_NAME" \$ "key=value"
}
