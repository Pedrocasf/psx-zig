const PSX = @import("ZigPSX");
pub export fn __start() void {
    var old:c_int = 0;
    while (true) {
        old = PSX.puts("Hello");
    }
}
