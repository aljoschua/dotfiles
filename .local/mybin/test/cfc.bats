#!/usr/bin/env bats

teardown() {
    unset input
}

execute_cfc() {
    cfc <<< "$input"
}

@test "does not change empty input" {
    input=""

    run execute_cfc

    [ $status = 0 ]
    [ -z "$output" ]
}

@test "does print simple text" {
    input=hello

    run execute_cfc

    [ $status = 0 ]
    [ "$output" = hello ]
}

@test "executes simple script" {
    input=$(echo -e "script_begin\necho hello\nscript_end")

    run execute_cfc

    [ $status = 0 ]
    [ "$output" = hello ]
}

@test "executes script with preceeding text" {
    input=$(echo -e "hello1\nscript_begin\necho hello2\nscript_end")

    run execute_cfc

    [ $status = 0 ]
    [ "$output" = hello1$'\n'hello2 ]
}

@test "executes script with succeeding text" {
    input=$(echo -e "script_begin\necho hello1\nscript_end\nhello2")

    run execute_cfc

    [ $status = 0 ]
    [ "$output" = hello1$'\n'hello2 ]
}

@test "executes two scripts" {
    input=$(echo -e "script_begin\necho hello1\nscript_end\nscript_begin\necho hello2\nscript_end")

    run execute_cfc

    [ $status = 0 ]
    [ "$output" = hello1$'\n'hello2 ]
}

@test "fails with invalid script" {
    input=$(echo -e "script_begin\ninvalid_command\nscript_end")

    run execute_cfc

    [ $status != 0 ]
}

@test "doesn't fail with empty script" {
    input=$(echo -e "script_begin\nscript_end")

    run execute_cfc
    [ $status = 0 ]
}
