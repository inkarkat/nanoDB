#!/bin/bash

export XDG_DATA_HOME="$BATS_TMPDIR"

clean_table()
{
    rm -f "${XDG_DATA_HOME}/${1:?}"
}

table_exists()
{
    [ -e "${XDG_DATA_HOME}/${1:?}" ]
}

initialize_table()
{
    [ "$2" = from ] || exit 2
    cp -f "${BATS_TEST_DIRNAME}/databases/${3:?}" "${XDG_DATA_HOME}/${1:?}"
}

get_row_number()
{
    wc -l "${XDG_DATA_HOME}/${1:?}" | awk '{ print $1; }'
}

dump_table()
{
    prefix '#' "${XDG_DATA_HOME}/${1:?}" >&3
}

assert_table_row()
{
    [ "$(sed -n -e "${2:?}p" "${XDG_DATA_HOME}/${1:?}")" = "${3?}" ]
}
