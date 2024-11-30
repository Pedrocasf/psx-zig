const PSX = @import("ZigPSX");
const GP0Cmd = PSX.GP0Command;
const GP0Port = PSX.GP0Port;
const CommandType = PSX.GP0CommandType;
const RawMod = PSX.RawMod;
pub export fn __start() void {
    var old:c_int = 0;
    const tri = GP0Cmd{
        .command_type = CommandType.PolygonPrimitive,
        .command = .{
            .polygon_render = .{
                .rgb = .{
                    .Red = 0xFF,
                    .Green = 0x00,
                    .Blue = 0x00,
                },
                .raw_or_modulated = .{

                }
            }
        },
    };
    while (true) {

        old = PSX.puts("Hello");
    }
}
