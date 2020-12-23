#!/bin/bash

export ACTIONS='--update, --delete, --truncate, --drop, --query, --get, --get-all, --get-as-dictionary'
assert_multiple_actions_error()
{
    [ "${lines[0]}" = "ERROR: Only one of $ACTIONS allowed." ]
}
