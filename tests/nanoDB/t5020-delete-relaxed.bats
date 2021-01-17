#!/usr/bin/env bats

load temp_database

setup() {
    initialize_table "$BATS_TEST_NAME" from relaxed
}

@test "non-existing relaxed key deletion fails" {
    rowNum="$(get_row_number "$BATS_TEST_NAME")"

    run nanoDB --table "$BATS_TEST_NAME" --relaxed-key --delete this\\\ \*\ never\ \{a\,b\}
    [ $status -eq 4 ]
    [ "${#lines[@]}" -eq 0 ]
    updatedRowNum="$(get_row_number "$BATS_TEST_NAME")"; [ "$updatedRowNum" -eq "$rowNum" ]
}

@test "relaxed key with everything can be deleted among many" {
    rowNum="$(get_row_number "$BATS_TEST_NAME")"

    run nanoDB --table "$BATS_TEST_NAME" --relaxed-key --delete $'\t\tthe what ?\n\\\tO\'Brian has "tons" of stuff\\!\n**for** // but not here'
    [ $status -eq 0 ]
    [ "${#lines[@]}" -eq 0 ]
    updatedRowNum="$(get_row_number "$BATS_TEST_NAME")"; [ "$updatedRowNum" -eq $((rowNum - 1)) ]
}
