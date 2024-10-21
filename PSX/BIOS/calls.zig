const format = @import("std").fmt.comptimePrint;
pub fn puts(str: [*:0]const u8) c_int {
    return asm volatile (
        \\ li $9, 0x3f
        \\ j 0xa0
        : [ret] "={r2}" (-> c_int),
        : [str] "{r4}" (str),
    );
}
comptime {
    asm (ABCCalls(0x00a0, 0x00, 2, "open"));
    asm (ABCCalls(0x00a0, 0x01, 3, "lseek"));
    asm (ABCCalls(0x00a0, 0x02, 3, "read"));
    asm (ABCCalls(0x00a0, 0x03, 3, "write"));
    asm (ABCCalls(0x00a0, 0x04, 1, "close"));
}
pub fn ABCCalls(
    CallType: comptime_int,
    CallNumber: comptime_int,
    CallName: []const u8,
    argc: comptime_int,
) []const u8 {
    const callTypeFormatted: []const u8 = format("{x}\n", CallType);
    const callNumberFormatted: []const u8 = format("{x}\n", CallNumber);
    const stackAlloc: []const u8 = format("add $sp, $sp, -{d}\n", (argc + 1) * 4);
    const stackFree: []const u8 = format("add $sp, $sp, {d}\n", (argc + 1) * 4);
    var regLoad: []const u8 = undefined;
    switch (argc) {
        0 => {
            regLoad = ("");
        },
        1 => {
            regLoad = (
                \\lw    $a0,4($sp) //Store arg0 from stack to a0
            );
        },
        2 => {
            regLoad = (
                \\lw    $a0,4($sp) //Store arg0 from stack to a0
                \\lw    $a1,8($sp) //Store arg1 from stack to a1
            );
        },
        3 => {
            regLoad = (
                \\lw    $a0,4($sp) //Store arg0 from stack to a0
                \\lw    $a1,8($sp) //Store arg1 from stack to a1
                \\lw    $a2,12($sp) //Store arg2 from stack to a2
            );
        },
        4 => {
            regLoad = (
                \\lw    $a0,4($sp) //Store arg0 from stack to a0
                \\lw    $a1,8($sp) //Store arg1 from stack to a1
                \\lw    $a2,12($sp) //Store arg2 from stack to a2
                \\lw    $a3,16($sp) //Store arg3 from stack to a3
            );
        },
    }
    return 
    \\.section .text
    \\.global
    ++ CallName ++ "\n" ++
        regLoad ++ "\n" ++ stackAlloc ++
        \\sw    $ra,0($sp)
        \\jal
    ++ callTypeFormatted ++
        \\li    $t1
    ++ callNumberFormatted ++
        \\lw    $ra, 0($sp)
    ++ "\n" ++ stackFree ++
        \\jr    $ra
    ;
}
