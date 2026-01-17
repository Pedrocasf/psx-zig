const PSX = @import("ZigPSX");
const GP0Cmd = PSX.GP0Command;
const GP0Port = PSX.GP0Port;
const CommandType = PSX.GP0CommandType;
const RawMod = PSX.RawMod;
pub export fn __start() void {
    var old:c_int = 0;

    while (true) {

        old = PSX.puts("Hello");
    }
}
