#!/usr/bin/env bats

load temp_database

@test "update of a table with an existing key overwrites that record" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    nanoDB --table "$BATS_TEST_NAME" --update "foo=A Foo has been updated 43"
    assert_table_row "$BATS_TEST_NAME" 1 "foo=A\ Foo\ has\ been\ updated\ 43"
    assert_table_row "$BATS_TEST_NAME" \$ "foo=A\ Foo\ has\ been\ updated\ 43"
}

@test "update of a larger table with an existing key multiple times updates that record" {
    initialize_table "$BATS_TEST_NAME" from some-entries

    nanoDB --table "$BATS_TEST_NAME" --update "foo=A Foo has been updated 43"
    nanoDB --table "$BATS_TEST_NAME" --update "bar=A woman walks by a 22"
    nanoDB --table "$BATS_TEST_NAME" --update "o_O=A key updated with space 99"

    assert_table_row "$BATS_TEST_NAME" 1 "foo=A\ Foo\ has\ been\ updated\ 43"
    assert_table_row "$BATS_TEST_NAME" 3 "bar=A\ woman\ walks\ by\ a\ 22"
    assert_table_row "$BATS_TEST_NAME" 4 "o_O=A\ key\ updated\ with\ space\ 99"
}
