const root = @import("root");
extern const __text_start:u8;
extern const __bss_end:u8;
extern const __bss_start:u8;
extern const __data_start:u8;
extern const __data_end:u8;
pub export fn __start()  noreturn {
    // call user's main
    if (@hasDecl(root, "main")) {
        root.main();
    }
    unreachable;
}
