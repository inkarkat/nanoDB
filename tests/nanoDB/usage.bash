#!/bin/bash

export ACTIONS='--update, --delete, --truncate, --drop, --query, --query-keys, --get, --get-all, --get-as-dictionary, --get-as-list'
assert_multiple_actions_error()
{
    [ "${lines[0]}" = "ERROR: Only one of $ACTIONS allowed." ]
}
