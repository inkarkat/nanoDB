#!/usr/bin/env bats

load temp_database

@test "update with tab characters" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    nanoDB --table "$BATS_TEST_NAME" --update "foo=the	foo	now contains		tabs	"
    assert_table_row "$BATS_TEST_NAME" 1 "foo=\$'the\\tfoo\\tnow contains\\t\\ttabs\\t'"
}

@test "update with newlines" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    nanoDB --table "$BATS_TEST_NAME" --update "foo=this
now
goes
over
multiple

lines"
    assert_table_row "$BATS_TEST_NAME" 1 "foo=\$'this\\nnow\\ngoes\\nover\\nmultiple\\n\\nlines'"
}

@test "update with single quotes" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    nanoDB --table "$BATS_TEST_NAME" --update "foo=with O'Brian in 'here'"
    assert_table_row "$BATS_TEST_NAME" 1 "foo=with\ O\'Brian\ in\ \'here\\'"
}

@test "update with double quotes" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    nanoDB --table "$BATS_TEST_NAME" --update 'foo="Here," I said, "leave it to me."'
    assert_table_row "$BATS_TEST_NAME" 1 "foo=\\\"Here\\,\\\"\\ I\\ said\\,\\ \\\"leave\\ it\\ to\\ me.\\\""
}

@test "update with single and double quotes" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    nanoDB --table "$BATS_TEST_NAME" --update "foo=I muttered, \"I go with O'Brian.\""
    assert_table_row "$BATS_TEST_NAME" 1 "foo=I\\ muttered\\,\\ \\\"I\\ go\\ with\\ O\\'Brian.\\\""
}

@test "update with various special characters" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    nanoDB --table "$BATS_TEST_NAME" --update 'foo=/the\ * is {a,b} for @me in ?!'
    assert_table_row "$BATS_TEST_NAME" 1 "foo=/the\\\\\\ \\*\\ is\\ \\{a\\,b\\}\\ for\\ @me\\ in\\ \\?\\!"
}

@test "update with everything" {
    initialize_table "$BATS_TEST_NAME" from one-entry

    nanoDB --table "$BATS_TEST_NAME" --update "foo=		the what ?
\\	O'Brian has \"tons\" of stuff\!
**for** // but not here"
    assert_table_row "$BATS_TEST_NAME" 1 "foo=\$'\\t\\tthe what ?\\n\\\\\\tO\\'Brian has \"tons\" of stuff\\\\!\\n**for** // but not here'"
}
