#!/usr/bin/env bats

setup() {
    cd $BATS_TMPDIR
}

@test "does not change empty file" {
    echo > file.cfc

    run cfc file.cfc

    [ $status = 0 ]
    [ "$(cat file)" = "" ]
}

@test "does print simple text" {
    echo "hello" > file.cfc

    run cfc file.cfc

    [ $status = 0 ]
    [ "$(cat file)" = hello ]
}

@test "executes simple script" {
    echo -e "script_begin\necho hello\nscript_end" > file.cfc

    run cfc file.cfc

    [ $status = 0 ]
    [ "$(cat file)" = hello ]
}

@test "executes script with preceeding text" {
    echo -e "hello1\nscript_begin\necho hello2\nscript_end" > file.cfc

    run cfc file.cfc

    [ $status = 0 ]
    [ "$(cat file)" = hello1$'\n'hello2 ]
}

@test "executes script with succeeding text" {
    echo -e "script_begin\necho hello1\nscript_end\nhello2" > file.cfc

    run cfc file.cfc

    [ $status = 0 ]
    [ "$(cat file)" = hello1$'\n'hello2 ]
}

@test "executes two scripts" {
    echo -e "script_begin\necho hello1\nscript_end\nscript_begin\necho hello2\nscript_end" > file.cfc

    run cfc file.cfc

    [ $status = 0 ]
    cat file
    [ "$(cat file)" = hello1$'\n'hello2 ]
}

@test "fails with invalid script" {
    echo -e "script_begin\ninvalid_command\nscript_end" > file.cfc

    run cfc file.cfc

    [ $status != 0 ]
}

@test "doesn't fail with empty script" {
    echo -e "script_begin\nscript_end" > file.cfc

    run cfc file.cfc

    [ $status = 0 ]
}
