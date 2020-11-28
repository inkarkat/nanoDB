#!/usr/bin/env bats

load temp_database

@test "update of a table with a new key adds a record" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    nanoDB --table "$BATS_TEST_NAME" --update "quux=This has been added"
    assert_table_row "$BATS_TEST_NAME" 1 "foo=The\ Foo\ is\ 42"
    assert_table_row "$BATS_TEST_NAME" 2 "quux=This\ has\ been\ added"
}

@test "update of a table with new keys twice adds two records" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    nanoDB --table "$BATS_TEST_NAME" --update "quux=This has been added"
    nanoDB --table "$BATS_TEST_NAME" --update "quuu=Another addition"

    assert_table_row "$BATS_TEST_NAME" 1 "foo=The\ Foo\ is\ 42"
    assert_table_row "$BATS_TEST_NAME" 2 "quux=This\ has\ been\ added"
    assert_table_row "$BATS_TEST_NAME" 3 "quuu=Another\ addition"
}
