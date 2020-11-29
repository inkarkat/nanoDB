#!/usr/bin/env bats

load temp_database

@test "non-existing key deletion fails" {
    initialize_table "$BATS_TEST_NAME" from one-entry
    rowNum="$(get_row_number "$BATS_TEST_NAME")"

    run nanoDB --table "$BATS_TEST_NAME" --delete notInHere
    [ $status -eq 4 ]
    [ "${#lines[@]}" -eq 0 ]
    updatedRowNum="$(get_row_number "$BATS_TEST_NAME")"; [ "$updatedRowNum" -eq "$rowNum" ]
}

@test "key can be deleted among many" {
    initialize_table "$BATS_TEST_NAME" from some-entries
    rowNum="$(get_row_number "$BATS_TEST_NAME")"

    run nanoDB --table "$BATS_TEST_NAME" --delete Foo
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 0 ]
    updatedRowNum="$(get_row_number "$BATS_TEST_NAME")"; [ "$updatedRowNum" -eq $((rowNum - 1)) ]
    assert_table_row "$BATS_TEST_NAME" 1 "foo=The\ Foo\ is\ 42"
    assert_table_row "$BATS_TEST_NAME" 2 "bar=A\ man\ walks\ into\ a"
}

@test "existing single key can be deleted and removes the entire table" {
    initialize_table "$BATS_TEST_NAME" from one-entry
    [ "$(get_row_number "$BATS_TEST_NAME")" -eq 1 ]

    run nanoDB --table "$BATS_TEST_NAME" --delete foo

    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 0 ]
    ! table_exists "$BATS_TEST_NAME"
}

@test "existing single key can be deleted and leaves behind only a comment" {
    initialize_table "$BATS_TEST_NAME" from commented-entry
    [ "$(get_row_number "$BATS_TEST_NAME")" -eq 2 ]

    run nanoDB --table "$BATS_TEST_NAME" --delete foo

    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 0 ]
    [ "$(get_row_number "$BATS_TEST_NAME")" -eq 1 ]
    assert_table_row "$BATS_TEST_NAME" 1 "# This is test data."
}
