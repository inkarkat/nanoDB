#!/usr/bin/env bats

load temp_database

setup() {
    initialize_table "$BATS_TEST_NAME" from relaxed
}

@test "update relaxed key with spaces" {
    nanoDB --table "$BATS_TEST_NAME" --relaxed-key --update 'key with spaces' --value new
    assert_table_row "$BATS_TEST_NAME" 1 'key\ with\ spaces=new'
}

@test "update relaxed key with tabs" {
    nanoDB --table "$BATS_TEST_NAME" --relaxed-key --update $'key\twith\ttabs' --value new
    assert_table_row "$BATS_TEST_NAME" 2 "\$'key\twith\ttabs'=new"
}

@test "update relaxed key with newlines" {
    nanoDB --table "$BATS_TEST_NAME" --relaxed-key --update $'key\nwith\nnewlines' --value new
    assert_table_row "$BATS_TEST_NAME" 3 "\$'key\\nwith\\nnewlines'=new"
}

@test "update relaxed key with single quotes" {
    nanoDB --table "$BATS_TEST_NAME" --relaxed-key --update O\'Brian --value new
    assert_table_row "$BATS_TEST_NAME" 4 "O\\'Brian=new"
}

@test "update relaxed key with double quotes" {
    nanoDB --table "$BATS_TEST_NAME" --relaxed-key --update a\"word\" --value new
    assert_table_row "$BATS_TEST_NAME" 5 'a\"word\"=new'
}

@test "update relaxed key with single and double quotes" {
    nanoDB --table "$BATS_TEST_NAME" --relaxed-key --update \"O\'Brian.\" --value new
    assert_table_row "$BATS_TEST_NAME" 6 "\\\"O\\'Brian.\\\"=new"
}

@test "update relaxed key with various special characters" {
    nanoDB --table "$BATS_TEST_NAME" --relaxed-key --update the\\\ \*\ is\ \{a\,b\} --value new
    assert_table_row "$BATS_TEST_NAME" 7 'the\\\ \*\ is\ \{a\,b\}=new'
}

@test "update relaxed key with everything" {
    nanoDB --table "$BATS_TEST_NAME" --relaxed-key --update $'\t\tthe what ?\n\\\tO\'Brian has "tons" of stuff\\!\n**for** // but not here' --value new
    assert_table_row "$BATS_TEST_NAME" 8 "\$'\\t\\tthe what ?\\n\\\\\\tO\\'Brian has \"tons\" of stuff\\\\!\\n**for** // but not here'=new"
}
