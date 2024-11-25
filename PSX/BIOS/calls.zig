const format = @import("std").fmt.comptimePrint;
pub extern fn puts(str: [*:0]const u8) c_int;
comptime {
    asm (ABCCalls(0x00a0, 0x00, 2, "open"));
    asm (ABCCalls(0x00a0, 0x01, 3, "lseek"));
    asm (ABCCalls(0x00a0, 0x02, 3, "read"));
    asm (ABCCalls(0x00a0, 0x03, 3, "write"));
    asm (ABCCalls(0x00a0, 0x04, 1, "close"));
    asm (ABCCalls(0x00a0, 0x3E, 1, "puts"));
}
pub fn ABCCalls(
    CallType: comptime_int,
    CallNumber: comptime_int,
    argc: comptime_int,
    CallName: []const u8,
) []const u8 {
    const callTypeFormatted: []const u8 = format(" 0x{x}\n", .{CallType});
    const callNumberFormatted: []const u8 = format(" 0x{x}\n", .{CallNumber});
    const stackAlloc: []const u8 = format("add $sp, $sp, -{d}\n", .{(argc + 1) * 4});
    const stackFree: []const u8 = format("add $sp, $sp, {d}\n", .{(argc + 1) * 4});
    var regLoad: []const u8 = undefined;
    switch (argc) {
        0 => {
            regLoad = ("");
        },
        1 => {
            regLoad = (
                \\lw    $a0,4($sp)
            );
        },
        2 => {
            regLoad = (
                \\lw    $a0,4($sp)
                \\lw    $a1,8($sp)
            );
        },
        3 => {
            regLoad = (
                \\lw    $a0,4($sp)
                \\lw    $a1,8($sp)
                \\lw    $a2,12($sp)
            );
        },
        4 => {
            regLoad = (
                \\lw    $a0,4($sp)
                \\lw    $a1,8($sp)
                \\lw    $a2,12($sp)
                \\lw    $a3,16($sp)
            );
        },
        else => unreachable,
    }
    return 
    \\.section .text
    \\.globl
    ++ " " ++   CallName ++ "\n" ++ \\.type
        ++ " " ++ CallName ++ \\ @function
        ++ "\n" ++ \\.section .text
        ++ "\n" ++ " " ++ regLoad ++ "\n" ++ stackAlloc ++
        CallName ++ ":" ++
        \\sw    $ra,0($sp)
        \\jal
    ++ callTypeFormatted ++
        \\li    $t1,
    ++ callNumberFormatted ++
        \\lw    $ra, 0($sp)
    ++ "\n" ++ stackFree ++
        \\jr    $ra
    ;
}
