#!/bin/bash

export ACTIONS='--update, --delete, --drop, --query, --get, --get-all'
assert_multiple_actions_error()
{
    [ "${lines[0]}" = "ERROR: Only one of $ACTIONS allowed." ]
}
