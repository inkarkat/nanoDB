#!/usr/bin/env bats

load temp_database

setup()
{
    clean_table "$BATS_TEST_NAME"
}

@test "create a table with various keys, query them individually and in bulk" {
    tabs="this	has	tab	characters"
    newlines="here
the
text
  goes
    over
      several
        lines"
    quoted="I'd rather say: \"How dare you?\""
    specials='* for {here, there} // no matter \\ ?'
    normal="Just plain text"
    spaces="  "
    empty=""

    nanoDB --table "$BATS_TEST_NAME" --truncate --comment "Roundtrip table"
    nanoDB --table "$BATS_TEST_NAME" --update "TABS=$tabs"
    nanoDB --table "$BATS_TEST_NAME" --update "NEWLINES=$newlines"
    nanoDB --table "$BATS_TEST_NAME" --update "QUOTED=$quoted"
    nanoDB --table "$BATS_TEST_NAME" --update "SPECIALS=$specials"
    nanoDB --table "$BATS_TEST_NAME" --update "NORMAL=$normal"
    nanoDB --table "$BATS_TEST_NAME" --update "EMPTY=$empty"
    nanoDB --table "$BATS_TEST_NAME" --update "SPACES=$spaces"

    eval "$(nanoDB --table "$BATS_TEST_NAME" --get-all)"
    [ "$TABS" = "$tabs" ]
    [ "$NEWLINES" = "$newlines" ]
    [ "$QUOTED" = "$quoted" ]
    [ "$SPECIALS" = "$specials" ]
    [ "$NORMAL" = "$normal" ]
    [ "$EMPTY" = "$empty" ]
    [ "$SPACES" = "$spaces" ]


    [ "$tabs" = "$(nanoDB --table "$BATS_TEST_NAME" --query TABS)" ]
    [ "$newlines" = "$(nanoDB --table "$BATS_TEST_NAME" --query NEWLINES)" ]
    [ "$quoted" = "$(nanoDB --table "$BATS_TEST_NAME" --query QUOTED)" ]
    [ "$specials" = "$(nanoDB --table "$BATS_TEST_NAME" --query SPECIALS)" ]
    [ "$normal" = "$(nanoDB --table "$BATS_TEST_NAME" --query NORMAL)" ]
    [ "$empty" = "$(nanoDB --table "$BATS_TEST_NAME" --query EMPTY)" ]
    [ "$spaces" = "$(nanoDB --table "$BATS_TEST_NAME" --query SPACES)" ]
}

@test "create, query, update, query, delete, query, drop" {
    text1="Some simple words"
    text2="Even simpler"
    text3="meaningless"

    nanoDB --table "$BATS_TEST_NAME" --comment "Roundtrip table" --update "VALUE=$text1"
    nanoDB --table "$BATS_TEST_NAME" --update "ALT=$text2"

    eval "$(nanoDB --table "$BATS_TEST_NAME" --get VALUE)"
    [ "$VALUE" = "$text1" ]

    nanoDB --table "$BATS_TEST_NAME" --update "VALUE=$text3"
    nanoDB --table "$BATS_TEST_NAME" --delete ALT

    [ "$text3" = "$(nanoDB --table "$BATS_TEST_NAME" --query VALUE)" ]

    nanoDB --table "$BATS_TEST_NAME" --delete VALUE

    [ "" = "$(nanoDB --table "$BATS_TEST_NAME" --query VALUE)" ]

    nanoDB --table "$BATS_TEST_NAME" --drop

    run nanoDB --table "$BATS_TEST_NAME" --query VALUE
    [ $status -eq 1 ]
}
