#set style address foreground red
set breakpoint pending on
set history save on
set history filename ~/.gdb_history

define setup_tui
	layout split
	layout regs
	focus cmd
end

define print_stack
	x/16xw $esp
end

define display_stack
	display/16xw $esp
	display/xw $ebp
end

define default
    break main
    display_stack
    setup_tui
end
